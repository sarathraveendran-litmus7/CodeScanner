//
//  UIViewController.swift
//  Scanner
//
//  Created by SR on 9/6/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setConstraint(width: CGFloat?, height: CGFloat?, centerX: CGFloat?, centerY: CGFloat?, top: CGFloat?) {
        
        guard let superView = self.superview else { return }
        if let _width = width {
            
            self.widthAnchor.constraint(equalToConstant: _width).isActive = true
        }
        
        if let _height = height {
            
            self.heightAnchor.constraint(equalToConstant: _height).isActive = true
        }
        
        if let _centerX = centerX {
           
            self.centerXAnchor.constraint(equalTo: superView.centerXAnchor, constant: _centerX).isActive = true
        }
        
        if let _centerY = centerY {
         
            self.centerYAnchor.constraint(equalTo: superView.centerYAnchor, constant: _centerY).isActive = true
        }
        
        if let _top = top {
            
            self.topAnchor.constraint(equalTo: superView.topAnchor, constant: _top).isActive = true
        }
    }
    
    
    func setConstraint(leftAnchor: NSLayoutXAxisAnchor, rightAnchor: NSLayoutXAxisAnchor, topAnchor: NSLayoutYAxisAnchor, bottomAnchor: NSLayoutYAxisAnchor) {
        
        self.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        self.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}



extension UIView {
    
    // Set Constraints
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
