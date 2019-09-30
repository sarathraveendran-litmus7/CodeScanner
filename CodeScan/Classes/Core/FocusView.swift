//
//  FocusView.swift
//  Scanner
//
//  Created by SR on 9/6/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation
import UIKit


class FocusView: UIView {
    
    // Declarations
    lazy var focusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Image.getImage("scanner_focus")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        imageView.contentMode = ContentMode.scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var scannerListenerView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // State Variables
    private var isPause: Bool = false
    
    
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        arrangeSubviews()
        //startAnimation()
    }
    
    
    
    private func addSubViews() {
        
        addSubview(focusImageView)
        addSubview(scannerListenerView)
    }
    
    
    
    private func arrangeSubviews() {
        
        // Focus Image View
        focusImageView.setConstraint(width: self.bounds.width, height: self.bounds.height, centerX: 0, centerY: 0, top: nil)
        
    
        // Green Indicator
        scannerListenerView.widthAnchor.constraint(equalTo: widthAnchor, constant: -24.0).isActive = true
        scannerListenerView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        scannerListenerView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        scannerListenerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    
    
    private func startAnimation() {
        
        /*let bottomPosition = frame.height - 12
        self.scannerListenerView.layer.animate(from: self.scannerListenerView.frame.origin.x, endPoint: bottomPosition)*/
    }
    
    
    
    private func pauseLayer(layer: CALayer) {
        
        /*let pausedTime: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime*/
    }
    
    
    
    private func resumeLayer(layer: CALayer) {
        
        /*let pausedTime: CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause*/
    }
}






extension FocusView {
    
    public func resume() {
        
        if isPause {
            
            isPause = false
            resumeLayer(layer: self.scannerListenerView.layer)
        }
    }
    
    
    
    public func pause() {
        
        if !isPause {
            
            isPause = true
            pauseLayer(layer: self.scannerListenerView.layer)
        }
    }
}

