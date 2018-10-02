//
//  gradeListVC.swift
//  BornToughTrainer
//
//  Created by admin on 20/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import Firebase

class gradeListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var gradeArray = [gradeObject]()
    
    
    var currentController : String?
    var grading = "ALL"
    
    
    
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var NoRecordLabel_1: UILabel!
    @IBOutlet weak var NoRecordLabel_2: UILabel!
    @IBOutlet weak var NoRecordLabel_3: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var dbRef: DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
       tableView.tableFooterView = UIView()
       tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
       // gradeObject(gradeDate: "Your Character - Firday - 22 July", grade: "C"))

        
        if gradeArray.isEmpty == true{
            NoRecordLabel_1.isHidden = false
            NoRecordLabel_2.isHidden = false
            NoRecordLabel_3.isHidden = false
            AddButton.isHidden = true
        }
        print(currentController!)
        
        print(grading)
        
        dbRef = Database.database().reference()
        
            if currentController == "track"{
       
                
                dbHandle = dbRef.child("Track").child((Auth.auth().currentUser?.uid)!).observe(.childAdded, with: { (Track_Snap) in
            
            let Track_Value = Track_Snap.value  as! [String : String]
            
                    print(self.grading)
                    
           if self.grading == "ALL"{
//                let Title_Date = Track_Value["Title"]! + " -  " + Track_Value["Date"]!
            let Title_Date = Track_Value["Date"]!

            self.gradeArray.append(gradeObject(gradeDate: Title_Date, grade: Track_Value["Grade"]!))
            
            self.NoRecordLabel_1.isHidden = true
            self.NoRecordLabel_2.isHidden = true
            self.NoRecordLabel_3.isHidden = true
            self.AddButton.isHidden = false

            self.tableView.reloadData()
                
            }
            
//           else{
//
//            if Track_Value ["Grade"] == self.grading{
//                let Title_Date = Track_Value["Title"]! + " -  " + Track_Value["Date"]!
//                self.gradeArray.append(gradeObject(gradeDate: Title_Date, grade: Track_Value["Grade"]!))
//
//                self.tableView.reloadData()
//            }
//
//            }
        })
                
        
    }
        
        
            else{
                
                dbHandle = dbRef.child("Flo").child((Auth.auth().currentUser?.uid)!).observe(.childAdded, with: { (Track_Snap) in
                    
                    let Track_Value = Track_Snap.value  as! [String : String]
                    
                    if self.grading == "ALL"{
//                        let Title_Date = Track_Value["Title"]! + " -  " + Track_Value["Date"]!
//                        self.gradeArray.append(gradeObject(gradeDate: Title_Date, grade: Track_Value["Grade"]!))
//
//                        self.tableView.reloadData()
                        
                        let Title_Date = Track_Value["Date"]!
                        
                        self.gradeArray.append(gradeObject(gradeDate: Title_Date, grade: Track_Value["Grade"]!))
                      
                        self.NoRecordLabel_1.isHidden = true
                        self.NoRecordLabel_2.isHidden = true
                        self.NoRecordLabel_3.isHidden = true
                        self.AddButton.isHidden = false

                        
                        self.tableView.reloadData()
                        
                    }
                        
                    else{
                        
                        if Track_Value ["Grade"] == self.grading{
                            let Title_Date = Track_Value["Title"]! + " -  " + Track_Value["Date"]!
                            self.gradeArray.append(gradeObject(gradeDate: Title_Date, grade: Track_Value["Grade"]!))
                            
                            self.tableView.reloadData()
                        }
                        
                    }
                })
        }

        // Do any additional setup after loading the view.
    }


    @IBAction func addAction(_ sender: Any) {
        if currentController! == "flo"{
//            self.performSegue(withIdentifier: "EditFlo", sender: nil)
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "grade") as! gradeVC

            self.present(vc, animated: true, completion: nil)
        }
            
        else{
//            self.performSegue(withIdentifier: "EditTrack", sender: nil)
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "grade") as! gradeVC
            
            self.present(vc, animated: true, completion: nil)

        }
    }
    
    
    @IBAction func backAction(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "menu")
        
        present(vc, animated: true, completion: nil)    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gradeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! gradeListTVC
        cell.selectionStyle = .none
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
