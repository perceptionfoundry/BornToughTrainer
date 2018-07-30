//
//  welcomeVC.swift
//  BornToughTrainer
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
        signUpBtn.cornerRadius = self.signUpBtn.frame.size.height / 2
        loginBtn.cornerRadius = self.loginBtn.frame.size.height / 2
        // Do any additional setup after loading the view, typically from a nib.
        
        print((Auth.auth().currentUser?.uid)!)
        
      
      
    }

//    override func viewDidAppear(_ animated: Bool) {
//        if (Auth.auth().currentUser) != nil {
//            switchController()
//        }
//    }
//    
//    func switchController () {
//        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "menu") as! menuVC
//        present(vc, animated: true, completion: nil)
//    }

    @IBAction func signInAction(_ sender: Any) {
        self.performSegue(withIdentifier: "signIn", sender: self)
    }
    
    @IBAction func signUpAction(_ sender: Any) {
    }
}

