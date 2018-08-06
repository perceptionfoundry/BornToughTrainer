//
//  extension.swift
//  BornToughTrainer
//
//  Created by admin on 16/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    
    func alignTextVerticallyInContainer() {
        var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        self.contentInset.top = topCorrect
    }
    
}
