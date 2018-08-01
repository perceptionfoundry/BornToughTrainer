//
//  createNewLogVC.swift
//  BornToughTrainer
//
//  Created by admin on 21/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import Firebase

class createNewLogVC: UIViewController, dateFetching {

    @IBOutlet weak var logTitle: textFieldClass!
    @IBOutlet weak var loGDate: textFieldClass!
    @IBOutlet weak var logDescription: UITextView!
    
    
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SettingDate))
        loGDate.addGestureRecognizer(tap)
    }

    
    @objc func SettingDate(){
        
        performSegue(withIdentifier: "Date_Segue", sender: nil)
        
    }
    
    func dateValue(Date: String) {
        
        print("Date:\(Date)")
        
        //        self.dateValue = Date
        self.loGDate.text = Date
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Date_Segue"
        {
            
            let dest = segue.destination as! DateCheckinVC
            
            dest.dateDelegate = self
            
            
        }
        
        
    }
    

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func doneAction(_ sender: Any) {
        
        print("check ")
        
        if (logDescription.text.isEmpty != true) && (logTitle.text?.isEmpty != true) && (loGDate.text?.isEmpty != true){

        let logData = ["Title":(logTitle.text)!,
                       "Date":(loGDate.text)!,
                       "Description":(logDescription.text)!]


        dbRef = Database.database().reference()

        dbRef.child("Log").child((Auth.auth().currentUser?.uid)!).child((logTitle.text)!).setValue(logData)




        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "logList") as! LogListVC
        present(vc, animated: true, completion: nil)
        }
    }
}
