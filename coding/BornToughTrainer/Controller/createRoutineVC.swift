//
//  createRoutineVC.swift
//  BornToughTrainer
//
//  Created by admin on 24/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

class createRoutineVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var addRoutineTextField: textFieldClass!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var taskStepsTextField: textFieldClass!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func addStepAction(_ sender: Any) {
    }
    
    @IBAction func addAction(_ sender: Any) {
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "routineList") as! routineListVC
        present(vc, animated: true, completion: nil)

        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cellForRow(at: indexPath)!
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}
