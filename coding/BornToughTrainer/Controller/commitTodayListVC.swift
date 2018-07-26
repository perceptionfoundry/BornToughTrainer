//
//  commitTodayListVC.swift
//  BornToughTrainer
//
//  Created by admin on 26/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

class commitTodayListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    

    @IBOutlet weak var tableView: UITableView!
    var commitTaskArray = [commitObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        commitTaskArray.append(commitObject(taskTitle: "Task 1 ", completed: true))
        commitTaskArray.append(commitObject(taskTitle: "Task 2 ", completed: true))
        commitTaskArray.append(commitObject(taskTitle: "Task 3 ", completed: false))
        commitTaskArray.append(commitObject(taskTitle: "Task 4 ", completed: false))
        // Do any additional setup after loading the view.
    }
    
    @IBAction func newList(_ sender: Any) {
        
    }
    
    @IBAction func completedAction(_ sender: Any) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commitTaskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if commitTaskArray[indexPath.row].completed == false{
            let cell = tableView.dequeueReusableCell(withIdentifier: "uncompletedCell", for: indexPath) as! unCompletedTaskTVC
            if (indexPath.row % 2 == 0){
                cell.backgroundColor = UIColor(red: 252/255, green: 226/255, blue: 33/255, alpha: 0.7)
            }else{
                cell.backgroundColor = UIColor(red: 252/255, green: 226/255, blue: 33/255, alpha: 1)
            }
            cell.taskTitle.text = commitTaskArray[indexPath.row].taskTitle
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "completedCell", for: indexPath)
            let attributedString = NSMutableAttributedString(string: commitTaskArray[indexPath.row].taskTitle)
            attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
              cell.textLabel?.attributedText = attributedString
            cell.textLabel?.textColor = UIColor.white
            return cell
        }
        
    }
}
