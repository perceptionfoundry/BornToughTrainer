//
//  createIdentityVC.swift
//  BornToughTrainer
//
//  Created by admin on 16/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

class createIdentityVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var workingToward: UITextView!
    @IBOutlet weak var attitudeSlogan: UITextView!
    @IBOutlet weak var secondQuestionLbl: UILabel!
    @IBOutlet weak var firstQuestionLbl: UILabel!
    @IBOutlet weak var mainLbl: UILabel!
    var firstTextView = ""
    var secondTextView = ""
    var firstQuestion = ""
    var secondQuestion = ""
    var lbl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        workingToward.alignTextVerticallyInContainer()
        attitudeSlogan.alignTextVerticallyInContainer()
        workingToward.layer.cornerRadius = 10
        workingToward.clipsToBounds = true
        workingToward.text = firstTextView
        workingToward.textColor = UIColor.lightGray
        attitudeSlogan.layer.cornerRadius = 10
        attitudeSlogan.clipsToBounds = true
        workingToward.delegate = self
        attitudeSlogan.delegate = self
        
        mainLbl.text = "This is id"
        firstQuestionLbl.text = firstQuestion
        secondQuestionLbl.text = secondQuestion
        attitudeSlogan.text = secondTextView
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        mainLbl.text = lbl
    }

    
    @IBAction func menuAction(_ sender: Any) {
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "menu") as! menuVC
        present(vc, animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        
        if textView.textColor == UIColor.lightGray {
            workingToward.text = nil
            workingToward.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }

}
