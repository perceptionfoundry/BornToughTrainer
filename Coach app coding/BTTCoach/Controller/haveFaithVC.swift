//
//  haveFaithVC.swift
//  BTTCoach
//
//  Created by Syed ShahRukh Haider on 30/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SDWebImage

class haveFaithVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var workingToward: UITextView!
    @IBOutlet weak var attitudeSlogan: UITextView!
    @IBOutlet weak var secondQuestionLbl: UILabel!
    @IBOutlet weak var firstQuestionLbl: UILabel!
    @IBOutlet weak var mainLbl: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate

    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    var firstTextView = ""
    var secondTextView = ""
    var firstQuestion = ""
    var secondQuestion = ""
    var lbl = ""
    
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
        workingToward.textColor = UIColor.lightGray
        
        attitudeSlogan.layer.cornerRadius = 10
        attitudeSlogan.clipsToBounds = true
        attitudeSlogan.text = secondTextView
        attitudeSlogan.textColor = UIColor.lightGray
        
        workingToward.delegate = self
        attitudeSlogan.delegate = self
        
        mainLbl.text = "This is id"
        firstQuestionLbl.text = firstQuestion
        secondQuestionLbl.text = secondQuestion
        // Do any additional setup after loading the view.
        
        dbRef = Database.database().reference()
        
        dbHandle = dbRef.child("User").observe(.childAdded, with: { (userData) in
            let value = userData.value as! [String : String]
            
            let userUID = self.appDelegate.selectedUser
            
            if value["uID"] == userUID{
                let imageURL = URL(string: (value["Image-URL"])!)
                self.profileImage.sd_setImage(with: imageURL!, placeholderImage: UIImage(named: "btt-logo"), options: .progressiveDownload, completed: nil)
                

//
                    self.dbRef.child("Faith").observe(.childAdded, with: { (Faith_Data) in
                        
                        
                        if (Faith_Data.key == userUID) && (Faith_Data.value != nil)
                        {
                        let identify_values = Faith_Data.value as! [String : String]

                        self.workingToward.textColor = UIColor.green
                        self.workingToward.text = identify_values["Working"]

                        self.attitudeSlogan.textColor = UIColor.green
                        self.attitudeSlogan.text = identify_values["Slogan"]
                        }
                    })

                
            }
        })
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        mainLbl.text = lbl
    }
    
    
    @IBAction func menuAction(_ sender: Any) {
        
        var Faith_Value = ["Working": "", "Slogan": ""]
        
        Faith_Value ["Working"] = self.workingToward.text!
        Faith_Value ["Slogan"] = self.attitudeSlogan.text!
        
        dbRef.child("Faith").child((Auth.auth().currentUser?.uid)!).setValue(Faith_Value )
        
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "menu") as! menuVC
        present(vc, animated: true, completion: nil)
    }
    
    
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        
        if textView.textColor == UIColor.lightGray {
            workingToward.text = nil
            workingToward.textColor = UIColor.green
            
            attitudeSlogan.text = nil
            attitudeSlogan.textColor = UIColor.green
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
    
}
