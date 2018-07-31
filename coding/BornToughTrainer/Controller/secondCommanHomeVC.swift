//
//  secondCommanHomeVC.swift
//  BornToughTrainer
//
//  Created by admin on 18/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit

class secondCommanHomeVC: UIViewController {

    @IBOutlet weak var screenImage: UIImageView!
    @IBOutlet weak var screenLbl: UILabel!
    @IBOutlet weak var descirptionLbl: UILabel!
    @IBOutlet weak var firstBtn: buttonStyle!
    @IBOutlet weak var secondBtn: buttonStyle!
    @IBOutlet weak var thirdBtn: UIButton!
    
    var screenImg = UIImage()
    var screenLblText = String()
    var descriptionText = String()
    var firstBtnTitle = String()
    var secongBtnTitle = String()
    var thirdBtnTitle = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        screenImage.image = screenImg
        screenLbl.text = screenLblText
        descirptionLbl.text = descriptionText
        firstBtn.setTitle(firstBtnTitle, for: .normal)
        secondBtn.setTitle(secongBtnTitle, for: .normal)
        thirdBtn.setTitle(thirdBtnTitle, for: .normal)
        
        firstBtn.cornerRadius = self.firstBtn.frame.size.height / 7
        secondBtn.cornerRadius = secondBtn.frame.size.height / 7
        // Do any additional setup after loading the view.
    }

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func FirstBtnAction(_ sender: Any) {
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "setUp") as! setUpVC
        if screenLblText ==  "Find Flo"{
            vc.screenLbl = "Find Flo"
            present(vc, animated: true, completion: nil)
        }else if screenLblText == "Track Character"{
            vc.screenLbl = "Track Character"
            present(vc, animated: true, completion: nil)
        }
        
    }
    @IBAction func secondBtnAction(_ sender: Any) {
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "grade") as! gradeVC
        if screenLblText ==  "Find Flo"{
            //send data from here
            vc.screenIdentifier = "Find Flo"
            present(vc, animated: true, completion: nil)
        }else if screenLblText == "Track Character"{
            //send data from here
            vc.screenIdentifier = "Track Character"
            present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func thirdBtnAction(_ sender: Any) {
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "gradeList") as! gradeListVC
        if screenLblText ==  "Find Flo"{
            //send data from here
            vc.gradeArray.append(gradeObject(gradeDate: "Log 1 - Firday - 20 July", grade: "A"))
            vc.gradeArray.append(gradeObject(gradeDate: "Log 2 - Firday - 21 July", grade: "B"))
            vc.gradeArray.append(gradeObject(gradeDate: "Log 3 - Firday - 22 July", grade: "C"))
            vc.gradeArray.append(gradeObject(gradeDate: "Log 4 - Firday - 20 July", grade: "A"))
            vc.gradeArray.append(gradeObject(gradeDate: "Log 5 - Firday - 21 July", grade: "B"))
            vc.gradeArray.append(gradeObject(gradeDate: "Log 6 - Firday - 22 July", grade: "C"))
            
            vc.gradeArray.append(gradeObject(gradeDate: "Log 7 - Firday - 20 July", grade: "A"))
            vc.gradeArray.append(gradeObject(gradeDate: "Log 8 - Firday - 21 July", grade: "B"))
            vc.gradeArray.append(gradeObject(gradeDate: "Log 9 - Firday - 22 July", grade: "C"))
            vc.currentController = "flo"
            
            present(vc, animated: true, completion: nil)
        }else if screenLblText == "Track Character"{
            //send data from here
            vc.gradeArray.append(gradeObject(gradeDate: "Your Character - Firday - 20 July", grade: "A"))
            vc.gradeArray.append(gradeObject(gradeDate: "Your Character - Firday - 21 July", grade: "B"))
            vc.gradeArray.append(gradeObject(gradeDate: "Your Character - Firday - 22 July", grade: "C"))
            vc.gradeArray.append(gradeObject(gradeDate: "Your Character - Firday - 20 July", grade: "A"))
            vc.gradeArray.append(gradeObject(gradeDate: "Your Character - Firday - 21 July", grade: "B"))
            vc.gradeArray.append(gradeObject(gradeDate: "Your Character - Firday - 22 July", grade: "C"))
            
            vc.gradeArray.append(gradeObject(gradeDate: "Your Character - Firday - 20 July", grade: "A"))
            vc.gradeArray.append(gradeObject(gradeDate: "Your Character - Firday - 21 July", grade: "B"))
            vc.gradeArray.append(gradeObject(gradeDate: "Your Character - Firday - 22 July", grade: "C"))
            vc.currentController = "track"
            present(vc, animated: true, completion: nil)
        }
    }
}
