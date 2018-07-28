//
//  commitTodayListVC.swift
//  BornToughTrainer
//
//  Created by admin on 26/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import Firebase

class commitTodayListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    

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
        dbHandle = dbRef.child("Commit").child((Auth.auth().currentUser!.uid)).observe(.childAdded, with: { (Commit_Snap) in
            
            
            var commit_Value = Commit_Snap.value  as! [String : String]
            self.commitTaskArray.append(commit_Value)
            
            print(self.commitTaskArray)

            self.tableView.reloadData()
            
        })
        

    }
    
    @IBAction func newList(_ sender: Any) {
        self.performSegue(withIdentifier: "createNewTask", sender: self)
    }
    
    @IBAction func completedAction(_ sender: Any) {
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
            cell.taskTitle.text = commitTaskArray[indexPath.row]["Title"]
            
            
            if cell.taskSwitch.isOn == false{
                let title = commitTaskArray[indexPath.row]["Title"]
                self.dbRef.child("Commmit").child((Auth.auth().currentUser?.uid)!).child(title!).child("Status").setValue("Complete")
                self.tableView.reloadData()
            }
   
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
         let cell = tableView.dequeueReusableCell(withIdentifier: "uncompletedCell", for: indexPath) as! unCompletedTaskTVC
        
        if cell.taskSwitch.isOn == false{
            let title = commitTaskArray[indexPath.row]["Title"]
            self.dbRef.child("Commmit").child((Auth.auth().currentUser?.uid)!).child(title!).child("Status").setValue("complete")
            self.tableView.reloadData()
        }
    }
}

extension unCompletedTaskTVC {
    

}
