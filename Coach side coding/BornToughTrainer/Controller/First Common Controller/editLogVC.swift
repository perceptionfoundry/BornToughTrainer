//
//  editLogVC.swift
//  BornToughTrainer
//
//  Created by admin on 24/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import Firebase

class editLogVC: UIViewController,  dateFetching {

    @IBOutlet weak var editTitle: textFieldClass2!
    @IBOutlet weak var editDate: textFieldClass2!
    @IBOutlet weak var editDescription: UITextView!
    
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    var delegate  : editProtocal!
    
    var segueTitle = ""
    var segueIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("******************")

        print(segueTitle)
        print(segueIndex)
        print("******************")
        
        dbRef = Database.database().reference()
        
        dbHandle = dbRef.child("Log").child((Auth.auth().currentUser?.uid)!).observe(.childAdded, with: { (LogSnap) in
            
            var logValue = LogSnap.value as! [String:String]
            

            if self.segueTitle == logValue["Title"]{
                
            self.editTitle.text = logValue["Title"]
            self.editDate.text = logValue["Date"]
            self.editDescription.text = logValue["Description"]
            }
            
        })
        let tap = UITapGestureRecognizer(target: self, action: #selector(SettingDate))
        editDate.addGestureRecognizer(tap)
    }
    
    
    @objc func SettingDate(){
        
        performSegue(withIdentifier: "Date_Segue", sender: nil)
        
    }
    
    func dateValue(Date: String) {
        
        print("Date:\(Date)")
        
        //        self.dateValue = Date
        self.editDate.text = Date
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Date_Segue"
        {
            
            let dest = segue.destination as! DateCheckinVC
            
            dest.dateDelegate = self
            
            
        }
        
    }
    
    
    
    @IBAction func acceptButtonAction(_ sender: Any) {
        
        let newValue = ["Title": editTitle.text!,
                       "Date" : editDate.text!,
                       "Description" : editDescription.text!]
        
        
        if segueTitle != editTitle.text!{
           
            self.dbRef.child("Log").child((Auth.auth().currentUser?.uid)!).child(segueTitle).removeValue()
            
            
            print(newValue)
            
            self.dbRef.child("Log").child((Auth.auth().currentUser?.uid)!).child(editTitle.text!).setValue(newValue)

            
//            self.dbRef.child("Log").child((Auth.auth().currentUser?.uid)!).child(editTitle.text!).child("Title").setValue(editTitle.text!)
//            self.dbRef.child("Log").child((Auth.auth().currentUser?.uid)!).child(editTitle.text!).child("Date").setValue(editDate.text!)
//            self.dbRef.child("Log").child((Auth.auth().currentUser?.uid)!).child(editTitle.text!).child("Description").setValue(editDescription.text!)
            
//            delegate.editFucntion(newValue: newValue, indexValue: segueIndex)
            delegate.editFucntion()
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
        else{
            self.dbRef.child("Log").child((Auth.auth().currentUser?.uid)!).child(segueTitle).child("Title").setValue(editTitle.text!)
            self.dbRef.child("Log").child((Auth.auth().currentUser?.uid)!).child(segueTitle).child("Date").setValue(editDate.text!)
            self.dbRef.child("Log").child((Auth.auth().currentUser?.uid)!).child(segueTitle).child("Description").setValue(editDescription.text!)
            
//            delegate.editFucntion(newValue: newValue, indexValue: segueIndex)
            delegate.editFucntion()
            
            self.dismiss(animated: true, completion: nil)
        }
    
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    
}
