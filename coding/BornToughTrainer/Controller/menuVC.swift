//
//  menuVC.swift
//  BornToughTrainer
//
//  Created by admin on 15/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class menuVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var TeamLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    
    var menuArray = [menuObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        compInit()
        appendInObject()
        // Do any additional setup after loading the view.
    }
    
    func compInit(){
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height / 2
        profileImage.layer.borderWidth = 3
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor.white.cgColor
        
        dbRef = Database.database().reference()
        

        
        dbHandle = dbRef.child("User").observe(.childAdded, with: { (userData) in
            let value = userData.value as! [String : String]

            if value["uID"] == (Auth.auth().currentUser?.uid)!{
                
                // setting profile image
                let imageURL = URL(string: (value["Image-URL"])!)
                self.profileImage.sd_setImage(with: imageURL!, placeholderImage: UIImage(named: "btt-logo"), options: .progressiveDownload, completed: nil)
                
                
                // setting label value
                
            let name = value["Name"]
            let team = value["Team"]
                
                self.NameLabel.text = name!
                self.TeamLabel.text = team!
                

            }
        })
        //tableView Settings
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! menuTVC
        cell.img.image = menuArray[indexPath.row].img
        cell.menuName.text = menuArray[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! menuTVC
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.menuName.textColor = UIColor.white
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! menuTVC
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.menuName.textColor = UIColor.black
        tableView.reloadInputViews()
        
        
        
         // 1.  ************ HAVE FAITH ***************
        if menuArray[indexPath.row].name == "Have Faith"{
            
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "HaveFaith") as! haveFaithVC
            vc.firstQuestion = "What do you believe in?"
            vc.secondQuestion = "Why will you be successful?"
            vc.firstTextView = """
            sample:
            In me and myself!
            """
            vc.secondTextView = """
            sample:
            Because I ROCK!
            """
            vc.lbl = "Have Faith"
            present(vc, animated: true, completion: nil)
        }
        
        
        
        
        
        
         // 2. ************ CREATE IDENTIFY ***************
        else if menuArray[indexPath.row].name == "Create Identity"{
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "Create Identity") as! createIdentityVC
            vc.firstTextView = """
            Define your athletic dreams: (after clicked the top goes away and font is 14 here)
            """
            vc.secondTextView = """
            sample:
            I'm unstoppable!
"""
            vc.firstQuestion = "What are you working towards?"
            vc.secondQuestion = "What is your attitude slogan?"
            vc.lbl = "Create Identity"
            present(vc, animated: true, completion: nil)
        }
        
        
         // 3. ************ COMMIT ***************
        else if menuArray[indexPath.row].name == "Commit to Today"{
           
            dbRef.child("Commit").observe(.value) { (commit_snap) in
                
                if commit_snap.exists() == false{
                    
                    let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "commanHome") as! commanHomeVC
                    vc.screenImg = #imageLiteral(resourceName: "commit")
                    vc.screenLblText = "Commit to Today"
                    vc.descriptionText = """
                    what do we have to accomplish to make
                    today a success?
                    """
                    vc.btnTitle = "+ Add a New Task"
                    self.present(vc, animated: true, completion: nil)
                    
                }
                else{
                    let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "commitList") as! commitTodayListVC
                    
                    self.present(vc, animated: true, completion: nil)                }
            }
        }
        
        
        
         // 4. ************ PEP TALK ***************
        else if menuArray[indexPath.row].name == "Produce Pep Talks"{
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "commanHome") as! commanHomeVC
            vc.screenImg = #imageLiteral(resourceName: "mic")
            vc.screenLblText = "Pep Talks"
            vc.descriptionText = """
            Recoed your own "Pep Talk" so you can hear
            your own voice as you create a mentally
            tough mindset for training and performance.
            """
            vc.btnTitle = "+ Add Pep Talk"
            
            present(vc, animated: true, completion: nil)
        }
        
        
        // 5. ************ LOG PROGRESS ***************
        else if menuArray[indexPath.row].name == "Log Progress"{
            
            dbRef.child("Log").observe(.value) { (log_snap) in
                
                if log_snap.exists() == false{
                    
                    let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "commanHome") as! commanHomeVC
                    vc.screenImg = #imageLiteral(resourceName: "log-1")
                    vc.screenLblText = "Log Progress"
                    vc.descriptionText = """
                    Create your Logs to help evaluate your
                    training and performance over time.
                    """
                    vc.btnTitle = "+ Add New Log"
                    
                    self.present(vc, animated: true, completion: nil)
                    
                }
                    
                else{
                    let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "logList") as! LogListVC
                    
                    self.present(vc, animated: true, completion: nil)                }
            }
            
            
            
            
            
            
            
        }
        
        
         // 6.  ************ DEVELOP ROUTINES ***************
        else if menuArray[indexPath.row].name == "Develop Routines"{
            
            dbRef.child("Routine").observe(.value) { (log_snap) in
                
                if log_snap.exists() == false{
                    
                    let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "commanHome") as! commanHomeVC
                    vc.screenImg = #imageLiteral(resourceName: "routines")
                    vc.screenLblText = "Develop Routines"
                    vc.descriptionText = """
                    Create the routines you will rely on during
                    training and performance to ensure mental
                    toughness.
                    """
                    vc.btnTitle = "+ Add New Task"
                    
                    self.present(vc, animated: true, completion: nil)
                    
                }
                
                else
                {
                    let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "routineList") as! routineListVC
                    self.present(vc, animated: true, completion: nil)
                }
            
          
        }
        
        }
            
            
            
         //7.  ************ INTERVIEW YOURSELF ***************
        else if menuArray[indexPath.row].name == "Interview Yourself"{
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "commanHome") as! commanHomeVC
            vc.screenImg = #imageLiteral(resourceName: "video")
            vc.screenLblText = "Interview Yourself"
            vc.descriptionText = """
            Add New Interview
            """
            vc.btnTitle = "+ Add New Interview"
            
            present(vc, animated: true, completion: nil)
        }
        
        
         // 8. ************ TRACK CHARACTER ***************
        else if menuArray[indexPath.row].name == "Track Character"{
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "secondCommanHome") as! secondCommanHomeVC
            vc.screenImg = #imageLiteral(resourceName: "track")
            vc.screenLblText = "Track Character"
            vc.descriptionText = """
            "WINNING is not a sometime thing; it's an all the
            time thing. You don't win once in a qhile; you
            don't do things right once in a while; you do
            them right all of the time. winning is a habit.
            Unfortunately, so is lodin." Vince Lombardi
            """
            vc.firstBtnTitle = "Set up Tracker"
            vc.secongBtnTitle = "Enter Grade"
            vc.thirdBtnTitle = "View Responses"
            present(vc, animated: true, completion: nil)
        }
        
         // 9. ************ FIND FLO ***************
        else if menuArray[indexPath.row].name == "Find Flo"{
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "secondCommanHome") as! secondCommanHomeVC
            vc.screenImg = #imageLiteral(resourceName: "flo")
            vc.screenLblText = "Find Flo"
            vc.descriptionText = """
            Keeping 100% of your focus in the present
            moment is the key to competing at your best.
            """
            vc.firstBtnTitle = "Set up Flo Tracker"
            vc.secongBtnTitle = "Enter Grade"
            vc.thirdBtnTitle = "View Responses"
            present(vc, animated: true, completion: nil)
        }
        else {
            return
        }
    }
    
    func nextScreen (){
        
    }
    func appendInObject(){
        menuArray.append(menuObject(img: #imageLiteral(resourceName: "bell"), name: "Messages"))
        menuArray.append(menuObject(img: #imageLiteral(resourceName: "CI"), name: "Create Identity"))
        menuArray.append(menuObject(img: #imageLiteral(resourceName: "commit-icon"), name: "Commit to Today"))
        menuArray.append(menuObject(img: #imageLiteral(resourceName: "pep talks"), name: "Produce Pep Talks"))
        menuArray.append(menuObject(img: #imageLiteral(resourceName: "log"), name: "Log Progress"))
        menuArray.append(menuObject(img: #imageLiteral(resourceName: "develop"), name: "Develop Routines"))
        menuArray.append(menuObject(img: #imageLiteral(resourceName: "camera"), name: "Interview Yourself"))
        menuArray.append(menuObject(img: #imageLiteral(resourceName: "character"), name: "Track Character"))
        menuArray.append(menuObject(img: #imageLiteral(resourceName: "find flo"), name: "Find Flo"))
        menuArray.append(menuObject(img: #imageLiteral(resourceName: "have faith"), name: "Have Faith"))
    }

}
