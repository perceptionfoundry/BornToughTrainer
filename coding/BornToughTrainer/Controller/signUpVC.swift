//
//  signUpVC.swift
//  BornToughTrainer
//
//  Created by admin on 14/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func singInAction(_ sender: Any) {
        
    }
    @IBAction func signUpAction(_ sender: Any) {
        self.performSegue(withIdentifier: "gettingStarted", sender: self)
    }
    
    
}
