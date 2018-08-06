//
//  AllUserVC.swift
//  BornToughTrainer
//
//  Created by Syed ShahRukh Haider on 06/08/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

class AllUserVC: UIViewController, UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var allUserTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.allUserTable.dataSource = self
        self.allUserTable.delegate = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "AllUser", for: indexPath)
        
        cell.selectionStyle = .none
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
        
    }

}
