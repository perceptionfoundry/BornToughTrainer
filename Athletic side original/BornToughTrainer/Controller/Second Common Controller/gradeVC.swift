//
//  gradeVC.swift
//  BornToughTrainer
//
//  Created by admin on 19/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

class gradeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var setUpArray = ["A","B","C","D","E","F"]
    var screenIdentifier = String()
    
    var selectedGrade = "ALL"
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func backAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func viewResponses(_ sender: Any) {
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "gradeList") as! gradeListVC
        if screenIdentifier ==  "Find Flo"{
           
            vc.currentController = "flo"
            
            print("**************")

            print(self.selectedGrade)
            
            print("**************")
            vc.grading = self.selectedGrade
            
            
        
            
            present(vc, animated: true, completion: nil)
        }
        
        
        else if screenIdentifier == "Track Character"{
            
            vc.currentController = "track"
            
            print("**************")

            print(self.selectedGrade)
            
            print("**************")

            vc.grading = self.selectedGrade

            present(vc, animated: true, completion: nil)
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setUpArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! gradeTVC
        cell.setUpLbl.text = setUpArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! gradeTVC
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.mainView.backgroundColor = UIColor.yellow
        cell.setUpLbl.textColor = UIColor.black
        cell.accessoryType = UITableViewCellAccessoryType.checkmark
        cell.tintColor = UIColor.yellow
        self.selectedGrade = setUpArray[indexPath.row]

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! gradeTVC
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.mainView.backgroundColor = UIColor.clear
        cell.setUpLbl.textColor = UIColor.white
        cell.accessoryType = UITableViewCellAccessoryType.none
        
    }

}
