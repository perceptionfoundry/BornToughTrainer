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

    @IBOutlet weak var PepTitle: textFieldClass!
    @IBOutlet weak var recordingButton: UIButton!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    
    var numberOfRecord = 0
    
    var dbRef : DatabaseReference!
    let storage = Storage.storage()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setting up session
        
//        if let number : Int = UserDefaults.standard.object(forKey: "RecordNumber") as? Int{
//
//            numberOfRecord = number
//        }
        
        
        recordingSession = AVAudioSession.sharedInstance()
        
        AVAudioSession.sharedInstance().requestRecordPermission { (hasPermission) in
            if hasPermission{
                print("Accept")
            }
        }


    }
    
    
    
    
    
    
    @IBAction func RecordingAction(_ sender: Any) {
        
        
        // Check if recording active
        
        if audioRecorder == nil {
            
            numberOfRecord += 1
            
            
            let fileName  = getDirectory().appendingPathComponent("\(PepTitle.text!).m4a")
            
    let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC),AVSampleRateKey: 12000,AVNumberOfChannelsKey :1,AVEncoderAudioQualityKey :AVAudioQuality.high.rawValue]
            
            // Start recording
            
            do{
                
                audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
                audioRecorder.delegate = self
                audioRecorder.record()
                
                // set button
                recordingButton.setImage(#imageLiteral(resourceName: "recording"), for: .normal)
            }
            catch{
                
                display(alertTitle: "Oop! ", alertMessage: "Recording")
            }
        }
        
        
        else{
            audioRecorder.stop()
            audioRecorder = nil
            
            
//            UserDefaults.standard.set(numberOfRecord, forKey: "RecordNumber")
            
            // set button label
            recordingButton.setImage(#imageLiteral(resourceName: "Oval 4"), for: .normal)
        }
        
        
    }
    
    
    
    // save audio
    
    func getDirectory() -> URL{
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentationDirectory = path[0]
        return documentationDirectory
    }
    
    // Display Alert
    
    func display (alertTitle: String, alertMessage : String){
        
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func addAction(_ sender: Any) {
        
        let path = getDirectory().appendingPathComponent("\(PepTitle.text!).m4a")
        
        
        print (path.absoluteString )
        
        var  audioInfo = ["Title": PepTitle.text!,
                     "Audio-URL": path.absoluteString,
                     "uID" : ""]
        
        
        print(audioInfo)
        
        
//        
//        
//        let uploadMetaData = StorageMetadata()
//        uploadMetaData.contentType = "audio/m4a"
//        
//        
//        let StorageRef = self.storage.reference().child("Pep_Audio").child((Auth.auth().currentUser!.uid)).child(self.PepTitle.text!)
//        
//        StorageRef.putFile(from: path, metadata: uploadMetaData, completion: { (audio_meta, video_error) in
//            
//            print(audio_meta)
//            
//            if video_error != nil{
//                
//                let alert = UIAlertController(title: "ERROR!", message: video_error?.localizedDescription, preferredStyle: .alert)
//                
//                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
//                alert.addAction(action)
//                
//                self.present(alert, animated: true, completion: nil)
//                
//                
//            }
//                
//            else{
//                
//                
//                
//                audioInfo["uID"] = (Auth.auth().currentUser?.uid)!
//               
//                
//                StorageRef.downloadURL(completion: { (audio_URl, error) in
//                    print(audio_URl?.absoluteString)
//                    
//                    audioInfo["Audio-URL"] = (audio_URl?.absoluteString)!
//                    self.dbRef = Database.database().reference()
//                    
//                    self.dbRef.child("Audio").child((Auth.auth().currentUser?.uid)!).child(self.PepTitle.text!).setValue(audioInfo)
//                })
//                
//                
//                let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "pepList") as! pepTalkListVC
//                
//                vc.audioLink = path
//                
//                self.present(vc, animated: true, completion: nil)
//                
//                //                        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HOME")
//                //                        self.present(homeVC!, animated: true, completion: nil)
//            }
//            
//        })
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "pepList") as! pepTalkListVC
        
        vc.audioLink = path
        
        self.present(vc, animated: true, completion: nil)
        
        
//        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "pepList") as! pepTalkListVC
//
//        present(vc, animated: true, completion: nil)
    }
    
}
