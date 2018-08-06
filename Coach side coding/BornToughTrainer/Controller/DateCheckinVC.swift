//
//  DateCheckinVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 31/05/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit




class DateCheckinVC: UIViewController {

    
    var  selectedDate : String?
    var dateDelegate : dateFetching?
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.datePickerMode = .date
        
    }
    
    
    @IBAction func pickerAction(_ sender: Any) {
        let format = DateFormatter()
    
        format.dateFormat = "dd-MM-YYYY"
        let date = format.string(from: datePicker.date)
        self.selectedDate = date

    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
//        print(selectedDate!)
        if self.selectedDate != nil{
            
            
            print((self.selectedDate)!)
            dateDelegate?.dateValue(Date: (self.selectedDate)!)
            self.dismiss(animated: true, completion: nil)

        }
        else{
            let Alert = UIAlertController(title: "Warning", message: "Select your Desire Date", preferredStyle: .alert)
            let actionButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            Alert.addAction(actionButton)
            self.present(Alert, animated: true, completion: nil)
        }
     
        
    }
    
}
