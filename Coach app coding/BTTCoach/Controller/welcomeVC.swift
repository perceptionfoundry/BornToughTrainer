//
//  welcomeVC.swift
//  BTTCoach
//
//  Created by admin on 13/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import Firebase

class welcomeVC: UIViewController {

    @IBOutlet weak var signUpBtn: buttonStyle!
    @IBOutlet weak var loginBtn: buttonStyle!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
      
      
    }

    override func viewDidAppear(_ animated: Bool) {
        if (Auth.auth().currentUser) != nil {
        }
    }
    

    @IBAction func signInAction(_ sender: Any) {
        self.performSegue(withIdentifier: "signIn", sender: self)
    }
    
    @IBAction func signUpAction(_ sender: Any) {
    }
}

