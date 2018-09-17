//
//  createNewTaskVC.swift
//  BornToughTrainer
//
//  Created by admin on 21/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import Firebase

class createNewTaskVC: UIViewController {

    @IBOutlet weak var TaskTitle: textFieldClass!
   
    @IBOutlet weak var TaskDescription: UITextView!
    
    var dbRef:DatabaseReference!
    
    let commitedDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func addAction(_ sender: Any) {
        
        
        
        let Format = DateFormatter()
            Format.dateFormat = "MM/dd/yyyy"
        
        let currentDate = Date()
        
      let date = Format.string(from: currentDate)
        
        dbRef = Database.database().reference()
        
        if (TaskTitle.text?.isEmpty != true){
            
            let taskData = ["Title":(TaskTitle.text)!,
                            "Committed": date,
                            "Status":"incomplete"]
            
            self.dbRef.child("User").child((Auth.auth().currentUser?.uid)!).child("Commit").setValue("YES")
            
            dbRef.child("Commit").child((Auth.auth().currentUser?.uid)!).child((TaskTitle.text)!).setValue(taskData)

            
            
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "commitList") as! commitTodayListVC
            
            present(vc, animated: true, completion: nil)
        }

     
    }
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
