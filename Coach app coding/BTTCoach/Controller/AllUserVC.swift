//
//  AllUserVC.swift
//  BTTCoach
//
//  Created by Syed ShahRukh Haider on 06/08/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class AllUserVC: UIViewController, UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var allUserTable: UITableView!
    
    
    var userList  = [[String:String]]()
    var uidList = [String]()
    var newMsgCount = 0
    var newReciever = ""
    
    var newmessage = [[String:String]]()
    
   let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.allUserTable.dataSource = self
        self.allUserTable.delegate = self
        
        dbRef = Database.database().reference()
        
    
        dbHandle = dbRef.child("User").observe(.childAdded, with: { (userData) in
            let value = userData.value as! [String : String]
            
            if value["uID"] != Auth.auth().currentUser?.uid{
            
                print(value)
            
            self.userList.append(value)
   
                self.allUserTable.reloadData()
            }
            

    
        
        })
        
        
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "AllUser", for: indexPath) as! AllUserTableViewCell
        
        print(userList)
        
        cell.countView.isHidden = true
        
        cell.Name.text?  = userList[indexPath.row]["Name"]!
 
        let imageURL = userList[indexPath.row]["Image-URL"]
        
        
        let string_url = URL(string: imageURL!)
        cell.userImage.sd_setImage(with: string_url!, placeholderImage: UIImage(named: "btt-logo"), options: .cacheMemoryOnly, completed: nil)
        
        
        
        
        
        let channelName = userList[indexPath.row]["uID"]! + "Coach"
        
        
        print(channelName)
        
        
        
        
        self.dbHandle = self.dbRef.child("Messages").child(channelName).observe(.childAdded, with: { (CountSnap) in
            
            //                    print(CountSnap.value)
            
            let value = CountSnap.value as! [String:String]
            
            
            if value["alert"] == "TRUE" && Auth.auth().currentUser?.uid != value["senderID"]{
                
                
               cell.countView.isHidden = false
                
                
                
            }
            
        })
        

      

    
        
        
        
        cell.selectionStyle = .none
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(userList[indexPath.row]["uID"]!)
        
        appDelegate.selectedUser = userList[indexPath.row]["uID"]!
        performSegue(withIdentifier: "Access_Segue", sender: nil)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
        
    }

}
