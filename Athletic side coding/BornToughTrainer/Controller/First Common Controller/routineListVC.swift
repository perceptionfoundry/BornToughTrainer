//
//  routineListVC.swift
//  BornToughTrainer
//
//  Created by admin on 24/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
// ;;io-]

import UIKit
import Firebase

class routineListVC: UIViewController ,UITableViewDataSource, UITableViewDelegate{

    var array = [routineObject]()
    var test = [String]()
    
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
//        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        
        dbRef = Database.database().reference()
        dbHandle = dbRef.child("Routine").child((Auth.auth().currentUser?.uid)!).observe(.childAdded, with: { (routine_snap) in
            
            let routineValue = routine_snap.value as! [String : String]
            
            let routinetitle = routineValue["Title"]
            let stringToArray = routineValue["Step"]?.split(separator: ",").map({"\($0)"})
            let openToBool = Bool(routineValue["open"]!)
            
            
            self.array.append(routineObject(routineTitle: routinetitle!, routineStep:stringToArray!, open: openToBool!))
            
            self.tableView.reloadData()
         
            
        })
        
//        array.append(routineObject(routineTitle: "Routine 1", routineStep: ["step 01","step 02","step 03"], open: false))
//        array.append(routineObject(routineTitle: "Routine 1", routineStep: ["step 01","step 02","step 03"], open: false))
//        array.append(routineObject(routineTitle: "Routine 1", routineStep: ["step 01","step 02","step 03"], open: false))
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if array[section].open == true{
            return array[section].routineStep.count + 1
        }else {
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellSection", for: indexPath)
            print(indexPath.row)
            
            cell.textLabel?.text = array[indexPath.section].routineTitle
            cell.backgroundColor = UIColor(red: 252/255, green: 226/255, blue: 33/255, alpha: 1)
                    tableView.separatorStyle = .singleLine

            return cell
        }else{
                    tableView.separatorStyle = UITableViewCellSeparatorStyle.none

            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! routineTVC
            cell.backgroundColor = UIColor(red: 252/255, green: 226/255, blue: 33/255, alpha: 0.9)
            var lastRowIndex = array[indexPath.section].routineStep.count
            cell.routineTitle.text = array[indexPath.section].routineStep[indexPath.row - 1]
            cell.img.image = #imageLiteral(resourceName: "l1x")
            cell.img.contentMode = UIViewContentMode.scaleAspectFit
            cell.routineTitle.textColor = UIColor.black
            if (indexPath.row == lastRowIndex ){
                cell.img.image = #imageLiteral(resourceName: "l2")
                cell.img.contentMode = UIViewContentMode.top
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if array[indexPath.section].open == true{
            array[indexPath.section].open = false
            let sections = IndexSet.init(integer: indexPath.section)
            print(sections)
            tableView.reloadSections(sections, with: .none)
            
        }else{
            array[indexPath.section].open = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func addAction(_ sender: Any) {
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "createRoutine") as! createRoutineVC
        
        present(vc, animated: true, completion: nil)
    }
    

}
