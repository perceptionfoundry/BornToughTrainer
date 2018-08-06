//
//  buttonStyle.swift
//  BornToughTrainer
//
//  Created by admin on 13/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CumtomizeButton: UIButton {
    
    @IBInspectable var  cornerRadius : CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
            
        }
        
    }
    
}


@IBDesignable class buttonStyle: UIButton {
    @IBInspectable var borderColor: UIColor? = UIColor.clear {
        didSet {
            layer.borderColor = self.borderColor?.cgColor
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = self.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = self.cornerRadius
            layer.masksToBounds = self.cornerRadius > 0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor?.cgColor
    }
}
