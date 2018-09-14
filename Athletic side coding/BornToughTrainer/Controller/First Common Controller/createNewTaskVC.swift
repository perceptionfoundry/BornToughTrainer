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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func addAction(_ sender: Any) {
        
        dbRef = Database.database().reference()
        
        if (TaskTitle.text?.isEmpty != true) && (TaskDescription.text.isEmpty != true){
            
            let taskData = ["Title":(TaskTitle.text)!,
                            "Description":(TaskDescription.text)!,
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
