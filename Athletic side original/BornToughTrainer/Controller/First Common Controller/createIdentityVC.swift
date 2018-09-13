//
//  createIdentityVC.swift
//  BornToughTrainer
//
//  Created by admin on 16/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import MessageUI


class createIdentityVC: UIViewController, UITextViewDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var workingToward: UITextView!
    @IBOutlet weak var attitudeSlogan: UITextView!
    @IBOutlet weak var secondQuestionLbl: UILabel!
    @IBOutlet weak var firstQuestionLbl: UILabel!
    @IBOutlet weak var mainLbl: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    var firstTextView = ""
    var secondTextView = ""
    var firstQuestion = ""
    var secondQuestion = ""
    var lbl = ""
    
    var identity = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = UIColor.white.cgColor

        workingToward.alignTextVerticallyInContainer()
        attitudeSlogan.alignTextVerticallyInContainer()
        
        workingToward.layer.cornerRadius = 10
        workingToward.clipsToBounds = true
        workingToward.text = firstTextView
        workingToward.textColor = UIColor.black
       
        attitudeSlogan.layer.cornerRadius = 10
        attitudeSlogan.clipsToBounds = true
        attitudeSlogan.text = secondTextView
        attitudeSlogan.textColor = UIColor.black
        
        workingToward.delegate = self
        attitudeSlogan.delegate = self
        
        mainLbl.text = "This is id"
        firstQuestionLbl.text = firstQuestion
        secondQuestionLbl.text = secondQuestion
        // Do any additional setup after loading the view.
        
        dbRef = Database.database().reference()
        
        dbHandle = dbRef.child("User").observe(.childAdded, with: { (userData) in
            let value = userData.value as! [String : String]
            
            if value["uID"] == (Auth.auth().currentUser?.uid)!{
                let imageURL = URL(string: (value["Image-URL"])!)
                self.profileImage.sd_setImage(with: imageURL!, placeholderImage: UIImage(named: "btt-logo"), options: .progressiveDownload, completed: nil)
                
                if value["Identify-Create"] != "no"{
                    
                    self.dbRef.child("Create-Identify").observe(.childAdded, with: { (identify_Data) in
//                        print(identify_Data.value ?? <#default value#>)
                        let identify_values = identify_Data.value as! [String : String]
                        
                        if identify_Data.key == Auth.auth().currentUser?.uid{
                        self.workingToward.textColor = UIColor.black
                        self.workingToward.text = identify_values["Working"]
                        
                        self.attitudeSlogan.textColor = UIColor.black
                        self.attitudeSlogan.text = identify_values["Slogan"]
                        }
                    })
                }
            
            }
        })
        
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        mainLbl.text = lbl
    }

    
    @IBAction func menuAction(_ sender: Any) {
        
        var identify_Value = ["Working": "", "Slogan": ""]
        
        identify_Value["Working"] = self.workingToward.text!
        identify_Value["Slogan"] = self.attitudeSlogan.text!
        
        dbRef.child("Create-Identify").child((Auth.auth().currentUser?.uid)!).setValue(identify_Value)
        
        if self.identity == "no"{
            dbRef.child("User").child((Auth.auth().currentUser?.uid)!).child("Identify-Create").setValue("yes")
        }
        
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "menu") as! menuVC
        present(vc, animated: true, completion: nil)
    }
    
    
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        
        if textView.text == "Define your athletic dreams" {
            workingToward.text = nil
            workingToward.textColor = UIColor.black
        }
        
        if textView.text == "Your Slogan Here" {
            attitudeSlogan.text = nil
            
            attitudeSlogan.textColor = UIColor.black
        }
        
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            workingToward.text = "Define your athletic dreams"
            attitudeSlogan.text = "Your Slogan Here"
            workingToward.textColor = UIColor.black
            attitudeSlogan.textColor = UIColor.black
        }
    }
    
    
    
    @IBAction func EmailButtonAction(_ sender: Any) {
        
        
        print("messages")
        
        let mailComposeViewController = ConfigureMailController()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        }
        else{
            showMailError()
        }
    }
    
    
    func ConfigureMailController() -> MFMailComposeViewController{
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["admin@btt.com"])
        mailComposerVC.setSubject("Need Assistance")
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
        
    }
    
    
    func showMailError(){
        
        let sendMailErrorAlert = UIAlertController(title: "Couldn't send mail", message: "Your device could not send mail", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        
        self.present(sendMailErrorAlert, animated: true, completion: nil)
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

}
