//
//  setUpVC.swift
//  BornToughTrainer
//
//  Created by admin on 19/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

class setUpVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var setUpArray = ["Daily","Weekly","Monthly"]
    var screenLbl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setUpArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! setUpTVC
        cell.setUpLbl.text = setUpArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! setUpTVC
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.mainView.backgroundColor = UIColor.yellow
        cell.setUpLbl.textColor = UIColor.black
        cell.accessoryType = UITableViewCellAccessoryType.checkmark
        cell.tintColor = UIColor.yellow
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! setUpTVC
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.mainView.backgroundColor = UIColor.clear
        cell.setUpLbl.textColor = UIColor.white
        cell.accessoryType = UITableViewCellAccessoryType.none
    }
    
    @IBAction func thirdBtnAction(_ sender: Any) {
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "gradeList") as! gradeListVC
        if screenLbl ==  "Find Flo"{
            //send data from here
            vc.gradeArray.append(gradeObject(gradeDate: "Log 1 - Firday - 20 July", grade: "A"))
            vc.gradeArray.append(gradeObject(gradeDate: "Log 2 - Firday - 21 July", grade: "B"))
            vc.gradeArray.append(gradeObject(gradeDate: "Log 3 - Firday - 22 July", grade: "C"))
            vc.gradeArray.append(gradeObject(gradeDate: "Log 4 - Firday - 20 July", grade: "A"))
            vc.gradeArray.append(gradeObject(gradeDate: "Log 5 - Firday - 21 July", grade: "B"))
            vc.gradeArray.append(gradeObject(gradeDate: "Log 6 - Firday - 22 July", grade: "C"))
            
            vc.gradeArray.append(gradeObject(gradeDate: "Log 7 - Firday - 20 July", grade: "A"))
            vc.gradeArray.append(gradeObject(gradeDate: "Log 8 - Firday - 21 July", grade: "B"))
            vc.gradeArray.append(gradeObject(gradeDate: "Log 9 - Firday - 22 July", grade: "C"))
            vc.currentController = "flo"
            
            present(vc, animated: true, completion: nil)
        }else if screenLbl == "Track Character"{
            //send data from here
            vc.gradeArray.append(gradeObject(gradeDate: "Your Character - Firday - 20 July", grade: "A"))
            vc.gradeArray.append(gradeObject(gradeDate: "Your Character - Firday - 21 July", grade: "B"))
            vc.gradeArray.append(gradeObject(gradeDate: "Your Character - Firday - 22 July", grade: "C"))
            vc.gradeArray.append(gradeObject(gradeDate: "Your Character - Firday - 20 July", grade: "A"))
            vc.gradeArray.append(gradeObject(gradeDate: "Your Character - Firday - 21 July", grade: "B"))
            vc.gradeArray.append(gradeObject(gradeDate: "Your Character - Firday - 22 July", grade: "C"))
            
            vc.gradeArray.append(gradeObject(gradeDate: "Your Character - Firday - 20 July", grade: "A"))
            vc.gradeArray.append(gradeObject(gradeDate: "Your Character - Firday - 21 July", grade: "B"))
            vc.gradeArray.append(gradeObject(gradeDate: "Your Character - Firday - 22 July", grade: "C"))
            vc.currentController = "track"
            present(vc, animated: true, completion: nil)
        }
    }
}
