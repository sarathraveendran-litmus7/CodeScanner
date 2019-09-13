//
//  CALayer.swift
//  Scanner
//
//  Created by SR on 9/7/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    
    func animate(from startPoint: CGFloat, endPoint: CGFloat) {
        
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = startPoint
        animation.toValue = endPoint
        animation.duration = 1.9
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.8, 0.8, 0.8, 0.8)
        
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.repeatCount = .infinity
        animation.autoreverses = true
        
        add(animation, forKey: "position")
    }
}
