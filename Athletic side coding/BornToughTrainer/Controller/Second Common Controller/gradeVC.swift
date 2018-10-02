//
//  gradeVC.swift
//  BornToughTrainer
//
//  Created by admin on 19/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import Firebase

class gradeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var setUpArray = ["A","B","C","D","E","F"]
    var screenIdentifier = String()
    var buttonName = ""
    
    var selectedGrade = "ALL"
    var today = ""
    
    var dbRef : DatabaseReference!
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var ActionButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(buttonName)
        
        if buttonName == "Save"{
            ActionButton.setTitle("Save", for: .normal)

        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        
        
        let Format = DateFormatter()
        Format.dateFormat = "MM/dd/yyyy"
        
        let currentDate = Date()
        
        self.today = Format.string(from: currentDate)
        
        DateLabel.text = Format.string(from: currentDate)
        
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
        
        print(buttonName)
        
//        if buttonName == "Save"{
        
            
//            let Format = DateFormatter()
//            Format.dateFormat = "MM-yyyy"
//
//            let nodeDate = Date()
//
//            print(nodeDate)
            
            
//            dbRef = Database.database().reference()
//
//
//
//                let trackInfo = [
//                                 "Date": self.today,
//                                 "Grade": selectedGrade]
//
//                print(self.today)
//
//            let parent = "\((Auth.auth().currentUser?.uid)!)+\(selectedGrade)"
//                dbRef.child("Track").child((Auth.auth().currentUser?.uid)!).child(parent).setValue(trackInfo)
//
//                self.dismiss(animated: true, completion: nil)
            
        
            
            
//
//        }
//        else {
        
        
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "gradeList") as! gradeListVC
      
        
        if screenIdentifier ==  "Find Flo" && buttonName == "Save"{
           
            vc.currentController = "flo"
            
            print("**************")

            print(self.selectedGrade)
            
            print("**************")
//            vc.grading = self.selectedGrade
            
            dbRef = Database.database().reference()
            
            
            
            let floInfo = [
                "Date": self.today,
                "Grade": selectedGrade]
            
            
            let Format = DateFormatter()
            Format.dateFormat = "MM-yyyy"
            
            let date = Date()
            
            let nodeDate = Format.string(from: date)
            
            print(nodeDate)
            
            
            dbRef.child("Flo").child((Auth.auth().currentUser?.uid)!).child(nodeDate).setValue(floInfo)
            
        
            
            present(vc, animated: true, completion: nil)
        }
        
   
        else if screenIdentifier == "Track Character" && buttonName == "Save"{
            
            vc.currentController = "track"
            
            print("**************")

            print(self.selectedGrade)
            
            print("**************")

//            vc.grading = self.selectedGrade

            
            dbRef = Database.database().reference()
            
            
            
            let trackInfo = [
                "Date": self.today,
                "Grade": selectedGrade]
            
            
            let Format = DateFormatter()
            Format.dateFormat = "MM-yyyy"
            
            let date = Date()
            
            let nodeDate = Format.string(from: date)
            
            print(nodeDate)
            
            
            dbRef.child("Track").child((Auth.auth().currentUser?.uid)!).child(nodeDate).setValue(trackInfo)
            
            
            present(vc, animated: true, completion: nil)
        }
//        }
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
