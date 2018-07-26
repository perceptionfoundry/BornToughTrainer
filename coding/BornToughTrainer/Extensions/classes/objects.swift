//
//  objects.swift
//  BornToughTrainer
//
//  Created by admin on 16/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import Foundation
import UIKit

struct menuObject {
    var img: UIImage
    var name: String
    
    init(img: UIImage, name: String) {
        self.img = img
        self.name = name
    }
    
}

struct gradeObject {
    
    var grade: String
    var gradeDate: String
    
    init(gradeDate: String, grade: String) {
        
        self.gradeDate = gradeDate
        self.grade = grade
        
    }
    
}

struct routineObject {
    var routineTitle : String
    var routineStep : [String]
    var open : Bool
    init(routineTitle : String, routineStep :[String], open: Bool) {
        self.routineTitle = routineTitle
        self.routineStep = routineStep
        self.open = open
    }
}
struct commitObject {
    
    var taskTitle: String
    var completed: Bool
    
    init(taskTitle: String, completed: Bool) {
        
        self.taskTitle = taskTitle
        self.completed = completed
        
    }
    
}
