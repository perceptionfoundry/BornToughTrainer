//
//  LogListVC.swift
//  BornToughTrainer
//
//  Created by admin on 21/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

protocol editProtocal : class {
    func editFucntion()
}

class LogListVC: UIViewController, UITableViewDataSource, UITableViewDelegate, editProtocal{
    func editFucntion() {

        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "editLog") as! editLogVC
        
        present(vc, animated: true, completion: nil)
        print("funtion is running")
    }
    

    @IBOutlet weak var tableVIew: UITableView!
    var LogArray = [gradeObject]()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        LogArray.append(gradeObject(gradeDate: "Your Log - Firday - 22 July", grade: "C"))
        LogArray.append(gradeObject(gradeDate: "Your Log - Firday - 22 July", grade: "C"))
        LogArray.append(gradeObject(gradeDate: "Your Log - Firday - 22 July", grade: "C"))
        LogArray.append(gradeObject(gradeDate: "Your Log - Firday - 22 July", grade: "C"))
        tableVIew.delegate = self
        tableVIew.dataSource = self
        tableVIew.tableFooterView = UIView()
        tableVIew.separatorStyle = UITableViewCellSeparatorStyle.none
        // Do any additional setup after loading the view.
    }

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editAction(_ sender: Any) {
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "editLog") as! editLogVC
        present(vc, animated: true, completion: nil)
        
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
        cell.logTitle.text = LogArray[indexPath.row].gradeDate
        cell.cellDelegate = self
        
        return cell
    }
    
    
}
