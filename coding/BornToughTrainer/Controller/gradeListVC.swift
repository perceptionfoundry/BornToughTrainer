//
//  gradeListVC.swift
//  BornToughTrainer
//
//  Created by admin on 20/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

class gradeListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var gradeArray = [gradeObject]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
       tableView.tableFooterView = UIView()
       tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        

        // Do any additional setup after loading the view.
    }


    @IBAction func addAction(_ sender: Any) {
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gradeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! gradeListTVC
        
        if (indexPath.row % 2 == 0){
            cell.backgroundColor = UIColor(red: 252/255, green: 226/255, blue: 33/255, alpha: 0.5)
        }else{
            cell.backgroundColor = UIColor(red: 252/255, green: 226/255, blue: 33/255, alpha: 1)
        }
        cell.gradeDate.text = gradeArray[indexPath.row].gradeDate
        cell.grade.text = gradeArray[indexPath.row].grade
        return cell
    }
}
