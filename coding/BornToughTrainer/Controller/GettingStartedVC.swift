//
//  GettingStartedVC.swift
//  BornToughTrainer
//
//  Created by admin on 14/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

class GettingStartedVC: UIViewController {

    let white = "Clicking Sign Up means that you agree to the"
    let Green1 = "Terms & Conditions"
    let Green2 = "Privacy Policy"
    let and = "and"
    
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var levelTextField: textFieldClass!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTextField: textFieldClass!
    
    @IBOutlet weak var mobileTextField: textFieldClass!
    @IBOutlet weak var teamTextField: textFieldClass!
    @IBOutlet weak var genderTextField: textFieldClass!
    @IBOutlet weak var sportTextField: textFieldClass!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Multi Color String
        let stringValue = "\(self.white)\n\(self.Green1) \(and) \(Green2)"
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringValue)
        attributedString.setColor(color: UIColor.white, forText: white)
        attributedString.setColor(color: UIColor.green, forText: Green1)
        attributedString.setColor(color: UIColor.white, forText: and)
        attributedString.setColor(color: UIColor.green, forText: Green2)
        termLabel.font = UIFont.systemFont(ofSize: 15)
        termLabel.attributedText = attributedString
        
        // imageView Rounded
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.masksToBounds = true
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.profileImage.layer.borderWidth = 5
        self.profileImage.layer.borderColor = UIColor.white.cgColor
        
        // Do any additional setup after loading the view.
    }

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func getStartedAction(_ sender: Any) {
        
    }
    
}

extension NSMutableAttributedString {
    
    func setColor(color: UIColor, forText stringValue: String) {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
    }
    
}
