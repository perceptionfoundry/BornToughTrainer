//
//  createPepTalkVC.swift
//  BornToughTrainer
//
//  Created by MAQ on 7/23/18.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase





class createPepTalkVC: UIViewController, AVAudioRecorderDelegate {
   

    var delegate : TableUpdate! 
    
    // OUTLET
    @IBOutlet weak var PepTitle: textFieldClass!
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    // TIMER
    let timing = audioTimer()
    
    
    // AVRecord Vairable
    var recordingSession: AVAudioSession!
    
    var audioRecorder: AVAudioRecorder!
    var numberOfRecord = 0
    
    var recordingPath : URL?
    
    
    
    // FireBase Variable
    var dbRef : DatabaseReference!
    let storage = Storage.storage()

    
    
    var ArrayOfData = [[String : String]]()
    
    var newData = [String : String]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cancelBtn.isHidden = true
        addBtn.isHidden = true
        
        // setting up session
        recordingSession = AVAudioSession.sharedInstance()
        try! recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        if let number:Int = UserDefaults.standard.object(forKey: "recordNumber") as? Int{
            numberOfRecord = number
        }
        
        
        
        AVAudioSession.sharedInstance().requestRecordPermission { (permission) in
            if permission {
                print("Accepted")
            }
        }
        


    }
    
    
    // FUNCTION THAT WILL HANDLE ELAPSE TIME
   @objc func UpdateElapse(timer : Timer){
        
        if timing .isRunnning{
            
            let minute = Int(timing.elaspeTimer/60)
            let second = Int(Int(timing.elaspeTimer) % 60)
//            let tenOfSecond = Int((Int(timing.elaspeTimer) * 10) % 10)
            
            TimerLabel.text = String (format: "%02d:%02d", minute,second)
            
        }
        
        else{
            timer.invalidate()
        }
    }
    
    
    
    // ACTION ON PRESS "RECORD" BUTTON
    
    @IBAction func RecordingAction(_ sender: Any) {
        
        
        
        
        
        // Check if recording active
        
        if PepTitle.text?.isEmpty != true {
        
            
            
            var  audioInfo = ["Title": "",
                            "Path-URL": ""
                            ]
            
            
            if audioRecorder == nil {
                
                let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as! String
                
                let fileNAme = "\(PepTitle.text!).wav"
                let path = [dir,fileNAme]
                
                let url = URL(fileURLWithPath: path.joined(separator: "/"))
                //
                let session = AVAudioSession.sharedInstance()
                try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
                self.audioRecorder = try! AVAudioRecorder(url: url, settings: [:])
                self.audioRecorder.delegate=self
                self.audioRecorder.isMeteringEnabled=true
                
                // START TIMER
                Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateElapse), userInfo: nil, repeats: true)
                timing.Start()
                
                //                // set button

                recordingButton.setImage(#imageLiteral(resourceName: "recording"), for: .normal)

                self.audioRecorder.prepareToRecord()
                self.audioRecorder.record()
            
                
                
                
                
                
                
                
//            numberOfRecord += 1
//
//
//
//
//
//            // DIRECTORY WHERE RECORDED AUDIO WILL BE STORE
//            let fileName  = getDirectory().appendingPathComponent("\(numberOfRecord).m4a")
//
//
//            let settings = [AVFormatIDKey: Int(kAudioFormatm),
//                            AVSampleRateKey: 32000,
//                            AVNumberOfChannelsKey :1,
//                            AVEncoderAudioQualityKey :AVAudioQuality.high.rawValue]
//
//            // Start recording
//
//            do{
//
//                self.acceptButton.isEnabled = false
//                audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
//                audioRecorder.delegate = self
//                audioRecorder.prepareToRecord()
//                audioRecorder.record()
//
//                // START TIMER
//                Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateElapse), userInfo: nil, repeats: true)
//                timing.Start()
//
//                // set button
//                recordingButton.setImage(#imageLiteral(resourceName: "recording"), for: .normal)
//            }
//            catch{
//
//
//                display(alertTitle: "Oop! ", alertMessage: "Recording")
//            }
        }
        
        // STOP AUDIO
        else{
                
            self.acceptButton.isEnabled = true
            audioRecorder.stop()
            timing.Stop()
            audioRecorder = nil
                addBtn.isHidden = false
                cancelBtn.isHidden = false
//
//                // ************* SAVE AUDIO DETAIL ******************
//            UserDefaults.standard.set(numberOfRecord, forKey: "recordNumber")
//
//
//                audioInfo["Title"] = PepTitle.text!
//                audioInfo["Path-URL"] = String(numberOfRecord)
//
//
//                print(audioInfo)
//                self.newData = audioInfo
//
//                print(newData)
//
//                if let tempData = UserDefaults.standard.value(forKey: "MYRECORD") as? [[String : String]]{
//
//                    print(tempData)
//
//                    self.ArrayOfData = tempData
//
//
//                }
//
//
//
//                if ArrayOfData.isEmpty == false{
//
//
//                    ArrayOfData.append(audioInfo)
//
//
//                    UserDefaults.standard.set(ArrayOfData, forKey: "MYRECORD")
////                    self.delegate.updateValue(value: audioInfo)
//
//                }
//
//                else{
//
//                    ArrayOfData.append(audioInfo)
//
//                    UserDefaults.standard.set(ArrayOfData, forKey: "MYRECORD")
//
////                    delegate.updateValue(value: audioInfo)
//
//
//                }
//
                
                
                
            
            // set button label
            recordingButton.setImage(#imageLiteral(resourceName: "Oval 4"), for: .normal)
        }
    }
        
            
            // ALERT FUNCTION ON MISSING TITLE
        else {
            display(alertTitle: "Title Missing", alertMessage: "please give title first")

            
        }
        
    }
    
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("************")
        print(recorder.url)
        print("************")
        
        self.recordingPath = recorder.url
    }
    
    // FUNCTION THAT WILLL HANDLE SAVED AUDIO DIRECTORY INFO
    
    func getDirectory() -> URL{ 
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let documentDirectory = paths[0]
        return documentDirectory

    }
    
    
    
    
    
    // Display Alert
    
    func display (alertTitle: String, alertMessage : String){
        
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    // FUNCTION WHICH WILL RUNNING ON PRESSING BACK BUTTON

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
        
        
        
        
    }
    
    
    
    // FUNCTION WHICH WILL RUNNING ON PRESSING ACTION BUTTON
    @IBAction func addAction(_ sender: Any) {
        
//
//
//
//   *****************  FIREBASE ******************
//
//

        var  audioInfo = ["Title": PepTitle.text!,
                     "Path-URL": "",
                     "uID" : ""]




        // Create metaData
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "audio/wav"


        let StorageRef = self.storage.reference().child("Pep_Audio").child((Auth.auth().currentUser!.uid)).child(PepTitle.text!)



//      let path = getDirectory().appendingPathComponent("\(numberOfRecord).wav")
        
    
        
                audioInfo["uID"] = (Auth.auth().currentUser?.uid)!

        
        print("*************************")

        print(self.recordingPath?.absoluteString)

        print("*************************")
        
        
        StorageRef.putFile(from: self.recordingPath!, metadata: uploadMetaData, completion: { (audio_meta, audio_error) in

            
            
            print("*************************")

            
//            print(audio_meta)

            print("*************************")

            
            // IF SOME ERROR OCCUR
            if audio_error != nil{

                let alert = UIAlertController(title: "ERROR!", message: audio_error?.localizedDescription, preferredStyle: .alert)

                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)

                self.present(alert, animated: true, completion: nil)


            }
                
                
                // IF THERE IS NO ERROR

            else{



                audioInfo["uID"] = (Auth.auth().currentUser?.uid)!


                StorageRef.downloadURL(completion: { (audio_URl, error) in
                    
                    
//                    print(audio_URl?.absoluteString)

                    audioInfo["Path-URL"] = (audio_URl?.absoluteString)!
                    
                    
//                    print( audioInfo["Path-URL"])
                    
                    
                    self.dbRef = Database.database().reference()

                    
                    print(audioInfo)
                    
                    self.dbRef.child("Audio").child((Auth.auth().currentUser?.uid)!).child(self.PepTitle.text!).setValue(audioInfo)



                })
//
//
                let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "pepList") as! pepTalkListVC
                //
                //                vc.audioLink = path
                
                print(self.newData)
                
//                self.delegate.updateValue(value: self.newData)
                
                
                //
                self.present(vc, animated: true, completion: nil)

            }

            
           
            
            
            
            
           
            
            
        })

        
        // User Default
//        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "pepList") as! pepTalkListVC
//        //
//        //                vc.audioLink = path
//
//        print(newData)
//
//
//
//
//        self.delegate.updateValue(value: newData)
//
//
//        //
//        self.present(vc, animated: true, completion: nil)
        
    }
        }


