
//
//  commanHomeVC.swift
//  BornToughTrainer
//
//  Created by admin on 18/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

class commanHomeVC: UIViewController {

    @IBOutlet weak var screenImage: UIImageView!
    @IBOutlet weak var screenLbl: UILabel!
    @IBOutlet weak var DescriptionLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    
    var screenImg = UIImage()
    var screenLblText = String()
    var descriptionText = String()
    var btnTitle = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenImage.image = screenImg
        screenLbl.text = screenLblText
        DescriptionLbl.text = descriptionText
        addBtn.setTitle(btnTitle, for: .normal)
    }

    @IBAction func addAction(_ sender: Any) {
        
        if screenLblText == "Commit to Today"{
            self.performSegue(withIdentifier: "createNewTask", sender: self)
        }else if screenLblText == "Log Progress"{
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "newLog") as! createNewLogVC
            present(vc, animated: true, completion: nil)
        }else if screenLblText == "Pep Talks"{
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "createPepTalk") as! createPepTalkVC
            
            present(vc, animated: true, completion: nil)
        }else if screenLblText == "Interview Yourself"{
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "createInterview") as! createInterviewVC
            
            present(vc, animated: true, completion: nil)
        } else if screenLblText == "Develop Routines"{
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "createRoutine") as! createRoutineVC
            
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
