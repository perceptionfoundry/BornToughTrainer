//
//  welcomeVC.swift
//  BornToughTrainer
//
//  Created by admin on 13/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

class welcomeVC: UIViewController {

    @IBOutlet weak var signUpBtn: buttonStyle!
    @IBOutlet weak var loginBtn: buttonStyle!
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpBtn.cornerRadius = self.signUpBtn.frame.size.height / 2
        loginBtn.cornerRadius = self.loginBtn.frame.size.height / 2
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInAction(_ sender: Any) {
        self.performSegue(withIdentifier: "signIn", sender: self)
    }
    
    @IBOutlet weak var signUpAction: buttonStyle!
}

