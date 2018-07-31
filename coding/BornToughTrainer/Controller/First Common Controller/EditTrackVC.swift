//
//  EditTrackVC.swift
//  BornToughTrainer
//
//  Created by Syed ShahRukh Haider on 31/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

class EditTrackVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    
    
    @IBOutlet weak var TitleLabel: textFieldClass2!
    @IBOutlet weak var Datelabel: textFieldClass2!
    @IBOutlet weak var GradeLabel: textFieldClass2!
    
    
    var pickerView = UIPickerView()
    let GradeArray = ["","A","B","C","D","E","F"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        pickerView.delegate = self
        pickerView.dataSource = self
        self.GradeLabel.delegate = self
        // Do any additional setup after loading the view.
    }

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if textField == self.GradeLabel{
            self.pickerView.tag = 0
            self.GradeLabel.inputView = self.pickerView
            self.pickerView.reloadAllComponents()
        }
            
      
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.GradeLabel{
            self.pickerView.tag = 0
            self.GradeLabel.inputView = nil
            self.pickerView.reloadAllComponents()
        }
            
     
        
    }
    
    
    // PickerView related functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
            return GradeArray.count
  
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
            return GradeArray[row]
      
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
       
            self.GradeLabel.text = GradeArray[row]
    
    }
    
    
  
    @IBAction func AcceptAction(_ sender: Any) {
    }
    
    
    
    @IBAction func BackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    

}
