//
//  unCompletedTaskTVC.swift
//  BornToughTrainer
//
//  Created by admin on 26/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

class unCompletedTaskTVC: UITableViewCell {

    @IBOutlet weak var taskSwitch: UISwitch!
    @IBOutlet weak var taskTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  
}
