//
//  signInVC.swift
//  BornToughTrainer
//
//  Created by admin on 15/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import Firebase

class signInVC: UIViewController {

    @IBOutlet weak var singInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInBtn: CumtomizeButton!
    

    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      componentInit()
        // Do any additional setup after loading the view.
      
    }

    @IBAction func signInAction(_ sender: Any) {
        
        if (emailTextField.text?.isEmpty != true) && (passwordTextField.text?.isEmpty != true){
            
            Auth.auth().signIn(withEmail: (emailTextField.text)!, password: (passwordTextField.text)!) { (auth_data, auth_error) in
                
                if auth_error != nil
                {
                    
                    let alertVC = UIAlertController(title: "Server Error", message: auth_error?.localizedDescription, preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                    
                    
                }
                
                else {
                self.dbRef = Database.database().reference()
                
                self.dbHandle = self.dbRef.child("User").observe(.childAdded, with: { (DataSnap) in
                    
                    
                    let value = DataSnap.value as! [String : String]
                    print(value)
                    
                    let uid_value = value["uID"]
                    
                    if uid_value == (Auth.auth().currentUser?.uid)!{
                         let identify_Status = value["Identify-Create"]
                        
                        if identify_Status == "no"{
                            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "Create Identity") as! createIdentityVC
                            vc.firstTextView = """
                            Define your athletic dreams: 
                            
                            """
                            vc.secondTextView = """
                            sample:
                            I'm unstoppable!
                            """
                            vc.firstQuestion = "What are you working towards?"
                            vc.secondQuestion = "What is your attitude slogan?"
                            vc.lbl = "Create Identity"
                            self.present(vc, animated: true, completion: nil)
                            
                        }
                        
                        
                        else{
                            
                            self.performSegue(withIdentifier: "Menu_Segue", sender: nil)
                        }

                    }
                    
               

                    
                    
                    
                })
                
                
                }
               
            }
            
        }
      
        else{
            let alertVC = UIAlertController(title: "Field Empty", message: "One of you text field is empty", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
        
        
       
        
     
        
    }
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func componentInit (){
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email_here@xyz.com", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.borderColor = UIColor.white.cgColor
        emailTextField.layer.cornerRadius = self.emailTextField.frame.size.height / 2
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.layer.cornerRadius = self.passwordTextField.frame.size.height / 2
        signInBtn.cornerRadius = self.signInBtn.frame.size.height / 2
    }
}
