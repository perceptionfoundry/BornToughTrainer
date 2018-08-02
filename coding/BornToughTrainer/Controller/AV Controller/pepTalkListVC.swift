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

class pepTalkListVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var pepTalkArray = [[String : String]]()
    
    
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    var audioPlayer : AVPlayer!
    
    var audioLink : URL?
    
    
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
            cell.backgroundColor = UIColor(red: 252/255, green: 226/255, blue: 33/255, alpha: 0.5)
        }else{
            cell.backgroundColor = UIColor(red: 252/255, green: 226/255, blue: 33/255, alpha: 1)
        }
        cell.popTitle.text = pepTalkArray[indexPath.row]["Title"]
        cell.pepPlay.tag = indexPath.row
        cell.pepDelete.tag = indexPath.row
        
        cell.selectionStyle = .none
        
        cell.pepPlay.addTarget(self, action: #selector(AudioPlayer), for: .touchUpInside)
        cell.pepDelete.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)

        return cell
    }
    
    @objc func AudioPlayer(_ play: UIButton){
        
        let indexValue = play.tag
        
        let Track = URL(string: (pepTalkArray[indexValue]["Audio-URL"])!)
        
        do{

            print(audioLink!)



//            audioPlayer =   AVPlayer(url: URL(string: "https://jam.wapbaze.com/mp3/tag/tmp/Joyner_Lucas_ft_Chris_Brown_-_Stranger_Things[wapBaze.com].mp3")!)
            audioPlayer =   AVPlayer(url: audioLink!)

            audioPlayer.play()
        }
        catch{

        }
        
//        let docUrl:URL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
//        let desURL = docUrl.appendingPathComponent("record.m4a")
//        var downloadTask:URLSessionDownloadTask
//        downloadTask = URLSession.shared.downloadTask(with: Track!, completionHandler: { [weak self](URLData, response, error) -> Void in
//            do{
//                let isFileFound:Bool? = FileManager.default.fileExists(atPath: desURL.path)
//                if isFileFound == true{
//                    print(desURL) //delete tmpsong.m4a & copy
//                } else {
//                    try FileManager.default.copyItem(at: URLData!, to: desURL)
//                }
//                let audioPlayer = try AVAudioPlayer(contentsOf: desURL)
////                self?.audioPlayer = sPlayer
//               audioPlayer.prepareToPlay()
//                audioPlayer.play()
//
//            }catch let err {
//                print(err.localizedDescription)
//            }
//
//        })
//        downloadTask.resume()
        
        
        
        
        
    }
    
    
    @objc func deleteAction(_ delete: UIButton){
        
        let indexValue = delete.tag
        
        self.dbRef.child("Audio").child((Auth.auth().currentUser?.uid)!).child(pepTalkArray[indexValue]["Title"]!).removeValue()
        self.pepTalkArray.remove(at: indexValue)
        
        self.tableView.reloadData()
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func addAction(_ sender: Any) {
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "createPepTalk") as! createPepTalkVC
        
        present(vc, animated: true, completion: nil)
    }
    
}