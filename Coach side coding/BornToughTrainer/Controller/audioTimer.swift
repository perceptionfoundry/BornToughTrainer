//
//  audioTimer.swift
//  BornToughTrainer
//
//  Created by Syed ShahRukh Haider on 02/08/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import Foundation


class audioTimer
{
    
    private var startTime : NSDate?
    
    var elaspeTimer : TimeInterval{
        
        if let start = self.startTime{
            return -start.timeIntervalSinceNow
        }
        else{
            return 0
        }
        
    }
    var isRunnning : Bool{
        return startTime != nil
    }
    
    
    func Start(){
        
        startTime = NSDate()
    }
    
    func Stop(){
        
        startTime = nil
    }
    

}
