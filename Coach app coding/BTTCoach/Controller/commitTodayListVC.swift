//
//  commitTodayListVC.swift
//  BTTCoach
//
//  Created by admin on 26/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import Firebase

class commitTodayListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    var appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var tableView: UITableView!
    
    var commitTaskArray = [[String:String]]()
    
    var dbRef: DatabaseReference!
    var dbHandle: DatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        dbRef = Database.database().reference()
        
        let userUID = appDelegate.selectedUser
        
        dbHandle = dbRef.child("Commit").child(userUID).observe(.childAdded, with: { (Commit_Snap) in
            
            
            let commit_Value = Commit_Snap.value  as! [String : String]
            self.commitTaskArray.append(commit_Value)
            
            print(self.commitTaskArray)

            self.tableView.reloadData()
            
        })
        

    }
    
    @IBAction func newList(_ sender: Any) {
        self.performSegue(withIdentifier: "createNewTask", sender: self)
    }
    
    @IBAction func completedAction(_ sender: Any) {
        
        for loop in 0...(commitTaskArray.count-1){
            
            self.commitTaskArray[loop]["Status"] = "complete"
            self.tableView.reloadData()
            
            let title = commitTaskArray[loop]["Title"]
            
            self.dbRef.child("Commit").child((Auth.auth().currentUser?.uid)!).child(title!).child("Status").setValue("complete")
            
        }
        
    }
    
    @IBAction func backAction(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "menu") as! menuVC
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commitTaskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if commitTaskArray[indexPath.row]["Status"] == "incomplete"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "uncompletedCell", for: indexPath) as! unCompletedTaskTVC
            
            cell.selectionStyle = .none
            
            if (indexPath.row % 2 == 0){
                cell.backgroundColor = UIColor(red: 252/255, green: 226/255, blue: 33/255, alpha: 0.7)
            }else{
                cell.backgroundColor = UIColor(red: 252/255, green: 226/255, blue: 33/255, alpha: 1)
            }
            
            cell.taskTitle.textColor = UIColor.black
            cell.taskTitle.text = commitTaskArray[indexPath.row]["Title"]
//          
            
            
          
   
            return cell
        }
        
        
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "completedCell", for: indexPath)
            let attributedString = NSMutableAttributedString(string: commitTaskArray[indexPath.row]["Title"]!)
            attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
              cell.textLabel?.attributedText = attributedString
            cell.textLabel?.textColor = UIColor.white
            return cell
        }
    }
    
    
    @objc func SwitchButtonAction(_ commitSwitch : UISwitch){
        print(commitSwitch.tag)
        
        let title = commitTaskArray[commitSwitch.tag]["Title"]
        
        
        if commitSwitch.isOn == false{
            self.dbRef.child("Commit").child((Auth.auth().currentUser?.uid)!).child(title!).child("Status").setValue("complete")
            
            commitTaskArray[commitSwitch.tag]["Status"] = "Complete"
            
            self.tableView.reloadData()
            
//       
        }
    
    }
    
  
}


