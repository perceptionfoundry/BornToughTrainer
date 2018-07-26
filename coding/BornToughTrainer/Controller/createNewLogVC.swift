//
//  createNewLogVC.swift
//  BornToughTrainer
//
//  Created by admin on 21/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

class createNewLogVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func doneAction(_ sender: Any) {
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "logList") as! LogListVC
        present(vc, animated: true, completion: nil)
    }
}
