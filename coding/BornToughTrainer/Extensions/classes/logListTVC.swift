//
//  logListTVC.swift
//  BornToughTrainer
//
//  Created by admin on 21/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

class logListTVC: UITableViewCell {

    @IBOutlet weak var logTitle: UILabel!
    @IBOutlet weak var logEdit: UIButton!
    weak var cellDelegate: editProtocal!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func editAction(_ sender: Any) {
        cellDelegate.editFucntion()
    }
}
