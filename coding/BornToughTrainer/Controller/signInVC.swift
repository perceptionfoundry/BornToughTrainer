//
//  signInVC.swift
//  BornToughTrainer
//
//  Created by admin on 15/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

class signInVC: UIViewController {

    @IBOutlet weak var singInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInBtn: CumtomizeButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
      componentInit()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInAction(_ sender: Any) {
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "Create Identity") as! createIdentityVC
        vc.firstTextView = """
        Define your athletic dreams: (after clicked the top goes away and font is 14 here)
        """
        vc.secondTextView = """
        sample:
        I'm unstoppable!
        """
        vc.firstQuestion = "What are you working towards?"
        vc.secondQuestion = "What is your attitude slogan?"
        vc.lbl = "Create Identity"
        present(vc, animated: true, completion: nil)
        
     
        
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
