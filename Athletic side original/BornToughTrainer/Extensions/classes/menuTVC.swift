//
//  menuTVC.swift
//  BornToughTrainer
//
//  Created by admin on 16/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

class menuTVC: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var menuName: UILabel!
   
    @IBOutlet weak var countView: Custom_View!
    @IBOutlet weak var countLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
