 //
//  pepTalkListVC.swift
//  BornToughTrainer
//
//  Created by MAQ on 7/23/18.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
 import AVFoundation
 import Firebase
 
 
 
 protocol TableUpdate {
    
    func updateValue (value : [String : String])

 }
 

class pepTalkListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, TableUpdate{

    
    
    // PROTOCOL FUNCTION INITIALIZE
    func updateValue(value: [String : String]) {


            self.pepTalkArray.append(value)
            tableView.reloadData()



    }

    
    
    var pepTalkArray = [[String : String]]()
    
    // FIREBASE VARIABLE
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    
    // AUDIO PLAYER VARIABLE
    var audioPlayer : AVPlayer!
    
    var numberOfRecord = 0

    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        // Do any additional setup after loading the view.
      
        

    
        
        
        dbRef = Database.database().reference()

        dbHandle = dbRef.child("Audio").child((Auth.auth().currentUser!.uid)).observe(.childAdded, with: { (audio_snap) in


            let audio_value = audio_snap.value as! [String : String]
            
            self.pepTalkArray.append(audio_value)
            self.tableView.reloadData()
        })
        
    }

    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pepTalkArray.count
    }

    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! pepTalkTVC
        
        if (indexPath.row % 2 == 0){
            cell.backgroundColor = UIColor(red: 252/255, green: 226/255, blue: 33/255, alpha: 0.8)
        }else{
            cell.backgroundColor = UIColor(red: 252/255, green: 226/255, blue: 33/255, alpha: 1)
        }
        cell.popTitle.text = pepTalkArray[indexPath.row]["Title"]
//        cell.popTitle.text = String("Record \(indexPath.row + 1)")
        cell.pepPlay.tag = indexPath.row
        cell.pepDelete.tag = indexPath.row
        
        cell.selectionStyle = .none
        
        cell.pepPlay.addTarget(self, action: #selector(AudioPlayer), for: .touchUpInside)
        cell.pepDelete.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)

        return cell
    }
    
    
    
    // FUNCTION TO PLAY AUDIO
    @objc func AudioPlayer(_ play: UIButton){
        
        let indexValue = play.tag
        
        let Track = (pepTalkArray[indexValue]["Path-URL"])!
        
        
        let path = URL(string: Track)
        
        
        let trackerror : NSError!
        
        do{
            
            print(path!)
            
            audioPlayer =  try AVPlayer(url: path!)
            
            audioPlayer.play()
        }
        catch{
            print(trackerror.localizedDescription)
        }
        
    }
    
    
 
    
    
    @objc func deleteAction(_ delete: UIButton){
        
        let indexValue = delete.tag
        

        
        self.dbRef.child("Audio").child((Auth.auth().currentUser?.uid)!).child(pepTalkArray[indexValue]["Title"]!).removeValue()
        self.pepTalkArray.remove(at: indexValue)
        
        self.tableView.reloadData()
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "menu") as! menuVC
        self.present(vc, animated: true, completion: nil)
        
        
    }
    @IBAction func addAction(_ sender: Any) {
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "createPepTalk") as! createPepTalkVC
        
        vc.delegate = self

        present(vc, animated: true, completion: nil)
    }
    
}
