//
//  setUpTVC.swift
//  BornToughTrainer
//
//  Created by admin on 19/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

class setUpTVC: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var setUpLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.borderColor = UIColor.yellow.cgColor
        mainView.layer.borderWidth = 1
        mainView.layer.cornerRadius = mainView.frame.size.height / 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
