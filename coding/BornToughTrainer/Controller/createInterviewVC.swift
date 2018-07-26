//
//  createInterviewVC.swift
//  BornToughTrainer
//
//  Created by admin on 23/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

class createInterviewVC: UIViewController {

    @IBOutlet weak var interviewDate: textFieldClass!
    @IBOutlet weak var interviewTitle: textFieldClass!
    @IBOutlet weak var timerLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func clearAction(_ sender: Any) {
    }
    @IBAction func addAction(_ sender: Any) {
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "interviewList") as! interviewListVC
        
        present(vc, animated: true, completion: nil)
        
    }
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
