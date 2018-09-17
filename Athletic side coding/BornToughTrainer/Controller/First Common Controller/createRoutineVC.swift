//
//  createRoutineVC.swift
//  BornToughTrainer
//
//  Created by admin on 24/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import Firebase

class createRoutineVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var addRoutineTextField: textFieldClass!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var taskStepsTextField: textFieldClass!
    
    var stepData = [String]()
    
    
    
    var dbRef : DatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        taskStepsTextField.delegate = self
        
        taskStepsTextField.clearsOnBeginEditing = true

        
        // Do any additional setup after loading the view.
    }

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func addStepAction(_ sender: Any) {
        
        if taskStepsTextField.text?.isEmpty != true   {
            self.stepData.append(taskStepsTextField.text!)
            print(stepData)
            
            taskStepsTextField.endEditing(true)
            taskStepsTextField.text = nil
            
            tableView.reloadData()

        }
        
//        else if stepData.count > 5 {
//            
//            let alertVC = UIAlertController(title: "Reach max limit", message: "You have reached to max limit to add step", preferredStyle: .alert)
//            let button = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
//            alertVC.addAction(button)
//            self.present(alertVC, animated: true, completion: nil)
//        }
    }
    
    @IBAction func addAction(_ sender: Any) {
        
        let stepString = stepData.joined(separator: ",")
        
        
        dbRef = Database.database().reference()
        
        
        print(stepString)
        
        let addValue = ["Title": addRoutineTextField.text!,
                        "Step": stepString,
                        "open": "false"]
        
        
        self.dbRef.child("User").child((Auth.auth().currentUser?.uid)!).child("Routine").setValue("YES")

        
        dbRef.child("Routine").child((Auth.auth().currentUser?.uid)!).child((addRoutineTextField.text)!).setValue(addValue)
        
        
        
        
        
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "routineList") as! routineListVC
        present(vc, animated: true, completion: nil)

        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.minimumScaleFactor = 0.5
        cell.isUserInteractionEnabled = false
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = stepData[indexPath.row]
    
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stepData.count
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 26
    }
    
}
