//
//  interviewListVC.swift
//  BornToughTrainer
//
//  Created by admin on 23/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import Firebase

class interviewListVC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    var interviewArray = [[String : String]]()
    
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    
    var selectedVideoURL : URL?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        // Do any additional setup after loading the view.
        
        
        
        dbRef = Database.database().reference()
        
        dbHandle = dbRef.child("Interview").child((Auth.auth().currentUser?.uid)!).observe(.childAdded, with: { (interview_snap) in
            
            let interview_value = interview_snap.value as! [String : String]
            
            self.interviewArray.append(interview_value)
            
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interviewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! pepTalkTVC
        
        if (indexPath.row % 2 == 0){
            cell.backgroundColor = UIColor(red: 252/255, green: 226/255, blue: 33/255, alpha: 0.5)
        }else{
            cell.backgroundColor = UIColor(red: 252/255, green: 226/255, blue: 33/255, alpha: 1)
        }
        cell.popTitle.text = interviewArray[indexPath.row]["Name"]
        
        cell.pepPlay.tag = indexPath.row
        cell.pepDelete.tag = indexPath.row
        
        cell.pepPlay.addTarget(self, action: #selector(PlayAction), for: .touchUpInside)
        cell.pepDelete.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        
        
        return cell
    }
    
    @objc func PlayAction(_ play: UIButton){
        
        let indexValue = play.tag
        
        let video_String = self.interviewArray[indexValue]["Video-URL"]
        
        self.selectedVideoURL = URL(string: video_String!)
        
        self.performSegue(withIdentifier: "Streaming", sender: nil)
        
        
    }
    
    @objc func deleteAction(_ delete: UIButton){
        
        let indexValue = delete.tag
        
        self.dbRef.child("Interview").child((Auth.auth().currentUser?.uid)!).child(interviewArray[indexValue]["Name"]!).removeValue()
        self.interviewArray.remove(at: indexValue)

        self.tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination  as! StreamingVC
        
        dest.url_link = self.selectedVideoURL
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "menu") as! menuVC
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func addAction(_ sender: Any) {
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "createInterview") as! createInterviewVC
        
        present(vc, animated: true, completion: nil)
    }
    
}
