//
//  StreamingVC.swift
//  BornToughTrainer
//
//  Created by Syed ShahRukh Haider on 01/08/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import Player

class StreamingVC: UIViewController {

    
    @IBOutlet weak var StreamingView: UIView!
    
    @IBOutlet weak var pauseButton: UIButton!
    var url_link = URL(string: "")
    
    var buttonCount = 1
    
    var player = Player()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.player.playerDelegate = self as? PlayerDelegate
        self.player.playbackDelegate = self as? PlayerPlaybackDelegate
        self.player.view.frame = self.StreamingView.bounds
        
        self.addChildViewController(self.player)
        self.StreamingView.addSubview(self.player.view)
        self.player.didMove(toParentViewController: self)
        self.player.fillMode = PlayerFillMode.resizeAspectFit.avFoundationType

        print(url_link)
        
        self.player.url = url_link!
        self.player.playFromBeginning()
    

        
        // Do any additional setup after loading the view.
    }

    public func playerPlaybackDidEnd(_ player: Player) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func playNpauseButton(_ sender: Any) {
        
        if buttonCount % 2 == 0{
            buttonCount += 1
        self.player.pause()
            self.pauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
    }
        else{
            buttonCount += 1
            self.player.playFromCurrentTime()
            self.pauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    

}


