//
//  signUpVC.swift
//  BornToughTrainer
//
//  Created by admin on 14/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import Firebase

class signUpVC: UIViewController {

    @IBOutlet weak var fulNameTextField: textFieldClass!
    @IBOutlet weak var emailTextFeild: textFieldClass!
    @IBOutlet weak var passwordTextField: textFieldClass!
    @IBOutlet weak var confirmPasswordTextField: textFieldClass!
    @IBOutlet weak var createAccountBtn: buttonStyle!
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createAccountBtn.cornerRadius = self.createAccountBtn.frame.size.height / 2
        // Do any additional setup after loading the view.

    }


    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
   
    
    
    
    @IBAction func signUpAction(_ sender: Any) {
        
        if (fulNameTextField.text?.isEmpty != true ) && (emailTextFeild.text?.isEmpty != true ) && (passwordTextField.text?.isEmpty != true ) && (confirmPasswordTextField.text?.isEmpty != true ) {
            
            
            if passwordTextField.text! == confirmPasswordTextField.text!{
                
                
                
                
                self.performSegue(withIdentifier: "gettingStarted", sender: self)

                
            }
            
            else{
                alertWindow(alertTitle: "Password Mismatch", alertMessage: "Please assure both password are same")
            }
            
            
            

            
        }
        
        else{
            alertWindow(alertTitle: "Data Missing", alertMessage: "Some text field is empty")
        }
        
    }
    
    
    // Function that will management Alert ViewController
    func alertWindow(alertTitle: String, alertMessage: String){
        
        let AlertVC = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        AlertVC.addAction(alertAction)
        self.present(AlertVC, animated: true, completion: nil)
    }
    
    
}
