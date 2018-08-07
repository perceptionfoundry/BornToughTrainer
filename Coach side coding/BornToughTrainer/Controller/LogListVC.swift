//
//  LogListVC.swift
//  BornToughTrainer
//
//  Created by admin on 21/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import Firebase

//protocol editProtocal : class {
//    func editFucntion(newValue : [String : String], indexValue : Int)
//}


class LogListVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    func editFucntion() {

        self.LogArray.removeAll()
        self.tableVIew.reloadData()

        dbRef = Database.database().reference()
        
        let userUID = appDelegate.selectedUser
        
        dbHandle = dbRef.child("Log").child(userUID).observe(.childAdded, with: { (log_snap) in





            let logvalue = log_snap.value as! [String : String]

            self.LogArray.append(logvalue)
            self.tableVIew.reloadData()
        })



    }
    
    
    var dbRef : DatabaseReference!
    var dbHandle: DatabaseHandle!
    
    @IBOutlet weak var tableVIew: UITableView!
   
    
    var selectedTitle = ""
    var selectedIndex = 0
   
    var LogArray = [[String : String]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        

        
        tableVIew.delegate = self
        tableVIew.dataSource = self
        tableVIew.tableFooterView = UIView()
        tableVIew.separatorStyle = UITableViewCellSeparatorStyle.none
        // Do any additional setup after loading the view.
        
        
        dbRef = Database.database().reference()
        
        let userUID = appDelegate.selectedUser
        
        dbHandle = dbRef.child("Log").child(userUID).observe(.childAdded, with: { (log_snap) in
            
            let logvalue = log_snap.value as! [String : String]
            
            self.LogArray.append(logvalue)
            self.tableVIew.reloadData()
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableVIew.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tableVIew.reloadData()
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "menu") as! menuVC
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    
    
    @IBAction func editAction(_ sender: Any) {
// 
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LogArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! logListTVC
        
        if (indexPath.row % 2 == 0){
            cell.backgroundColor = UIColor(red: 252/255, green: 226/255, blue: 33/255, alpha: 0.5)
        }else{
            cell.backgroundColor = UIColor(red: 252/255, green: 226/255, blue: 33/255, alpha: 1)
        }
        
        
        print((LogArray[indexPath.row]["Title"])!)
        print((LogArray[indexPath.row]["Date"])!)
        
        let DisplayText = "\((LogArray[indexPath.row]["Title"])!) - \((LogArray[indexPath.row]["Date"])!)"
        cell.logTitle.text = DisplayText
        
//        cell.logEdit.tag = indexPath.row
//        cell.logEdit.addTarget(self, action: #selector(EditingAction), for: .touchUpInside)
        
        return cell
    }
    
    @objc func EditingAction(_ button : UIButton){
        
        print(LogArray[button.tag]["Title"]!)
        
        self.selectedTitle = LogArray[button.tag]["Title"]!
        self.selectedIndex = button.tag
        
        self.performSegue(withIdentifier: "Edit_Segue", sender: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Edit_Segue"
        {
//            let dest = segue.destination as! editLogVC
//            dest.segueTitle = self.selectedTitle
//            dest.segueIndex = self.selectedIndex
//            
//            dest.delegate = self
        }
    }
    
}
