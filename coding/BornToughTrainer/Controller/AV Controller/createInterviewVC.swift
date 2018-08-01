//
//  createInterviewVC.swift
//  BornToughTrainer
//
//  Created by admin on 23/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import CameraManager
import Firebase

class createInterviewVC: UIViewController {

    @IBOutlet weak var interviewDate: textFieldClass!
    @IBOutlet weak var interviewTitle: textFieldClass!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var uploadView: UIView!
    var tapCount = 1
    let cameraManager = CameraManager()
    var video_URL : URL?

    var dbRef : DatabaseReference!
    let storage = Storage.storage()

    override func viewDidLoad() {
        super.viewDidLoad()
        cameraView.isHidden = true
        configureCamera()
        self.cameraManager.addPreviewLayerToView(cameraView)
        // Do any additional setup after loading the view.
        
        self.uploadView.isHidden = true
    }


    @IBAction func clearAction(_ sender: Any) {
    }
    
    @IBAction func RecordButtonAction(_ sender: Any) {
        
        
        
        
        
        
        
        if tapCount % 2 != 0 {
            tapCount += 1
            print("Start")
            self.recordButton.setImage(#imageLiteral(resourceName: "recording"), for: .normal)
            self.cameraView.isHidden = false
            self.cameraManager.startRecordingVideo()
        }
        else{
            tapCount += 1
            self.cameraView.isHidden = true

            print("stop")
            
            self.recordButton.setImage(#imageLiteral(resourceName: "Oval 4"), for: .normal)

            self.cameraManager.stopVideoRecording { (videoURL, error) in
                print("***************")
                print(error?.localizedDescription)
                
                print(videoURL!)
                self.video_URL = videoURL!
//                let uploadMetaData = StorageMetadata()
//                uploadMetaData.contentType = "video/mp4"
//
//
//                let StorageRef = self.storage.reference().child("Interview_Video").child((Auth.auth().currentUser!.uid)).child(self.interviewTitle.text!)
//
//                    StorageRef.putFile(from: video_URL, metadata: uploadMetaData, completion: { (video_meta, video_error) in
//
//                    print(video_meta)
//
//                    if video_error != nil{
//
//                        let alert = UIAlertController(title: "ERROR!", message: video_error?.localizedDescription, preferredStyle: .alert)
//
//                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
//                        alert.addAction(action)
//
//                        self.present(alert, animated: true, completion: nil)
//
//
//                    }
//
//                    else{
//
//
//
//                        userInfo["uID"] = (Auth.auth().currentUser?.uid)!
//                        //                        userInfo["Image"] = (metaData?.downloadURL()?.description)!
//
//                        StorageRef.downloadURL(completion: { (image_URl, error) in
//                            print(image_URl?.absoluteString)
//
//                            userInfo["Video-URL"] = (image_URl?.absoluteString)!
//                            self.dbRef = Database.database().reference()
//
//                            self.dbRef.child("Interview").child((Auth.auth().currentUser?.uid)!).child(self.interviewTitle.text!).setValue(userInfo)
//                        })
//
////                        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HOME")
////                        self.present(homeVC!, animated: true, completion: nil)
//                        }
//
//                })
            }
        }
    }
    
    
    @IBAction func addAction(_ sender: Any) {
        
        
        self.uploadView.isHidden = false
        
        var userInfo = [ "Name": interviewTitle.text!,
                         "Date": interviewDate.text!,
                         "Video-URL" :"",
                         "uID" : ""
        ]
        
        
        
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "video/mp4"
        
        
        let StorageRef = self.storage.reference().child("Interview_Video").child((Auth.auth().currentUser!.uid)).child(self.interviewTitle.text!)
        
        StorageRef.putFile(from: self.video_URL!, metadata: uploadMetaData, completion: { (video_meta, video_error) in
            
            print(video_meta)
            
            if video_error != nil{
                
                let alert = UIAlertController(title: "ERROR!", message: video_error?.localizedDescription, preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
                
                
            }
                
            else{
                
                
                
                userInfo["uID"] = (Auth.auth().currentUser?.uid)!
                //                        userInfo["Image"] = (metaData?.downloadURL()?.description)!
                
                StorageRef.downloadURL(completion: { (image_URl, error) in
                    print(image_URl?.absoluteString)
                    
                    userInfo["Video-URL"] = (image_URl?.absoluteString)!
                    self.dbRef = Database.database().reference()
                    
                    self.dbRef.child("Interview").child((Auth.auth().currentUser?.uid)!).child(self.interviewTitle.text!).setValue(userInfo)
                })
                
                
                let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "interviewList") as! interviewListVC
                
                self.present(vc, animated: true, completion: nil)
                
                //                        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HOME")
                //                        self.present(homeVC!, animated: true, completion: nil)
            }
            
        })
        
//        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "interviewList") as! interviewListVC
//
//        present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func configureCamera(){
        
        cameraManager.cameraOutputMode = .videoWithMic
        cameraManager.cameraOutputQuality = .medium
        cameraManager.writeFilesToPhoneLibrary = false
        
    }

}
