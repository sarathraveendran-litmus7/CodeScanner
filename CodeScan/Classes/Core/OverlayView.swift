//
//  OverlayView.swift
//  CodeScan
//
//  Created by SR on 9/19/19.
//

import Foundation
import UIKit


class OverlayView: UIView {
    
    // Declaration
    var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var focusView: UIView {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    // Set from parent
    let scannerPosition: ScannerPosition!
    let scannerView: UIView!
    
    
    
    // MARK: Life Cycle
    init(_ scannerPosition: ScannerPosition, scannerView: UIView) {
        self.scannerPosition = scannerPosition
        self.scannerView = scannerView
        super.init(frame: .zero)
        
//        arrangeSubViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    
    }
    
    
    func arrangeSubViews() {
        
        // Style
        backgroundColor = .clear
        
        // Arrange
        arrangeFocusView()
//        arrangeOverlayViews()
    }
    
    
    private func arrangeFocusView() {
        
        addSubview(focusView)
        let size = getScanningAreaSize(self.scannerView)
        switch scannerPosition! {
            
        case .top:
            focusView.setConstraint(width: size.width, height: size.height, centerX: 0, centerY: nil, top: 16)
            
        case .middle:
            focusView.setConstraint(width: size.width, height: size.height, centerX: 0, centerY: 0, top:  nil)
//            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0(width)]", options: NSLayoutConstraint.FormatOptions(), metrics: ["width": size.width], views: ["v0": focusView]))
//            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(height)]", options: NSLayoutConstraint.FormatOptions(), metrics: ["height": size.height], views: ["v0": focusView]))
////            focusView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
////            focusView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
    }
    
    private func arrangeOverlayViews() {
        
        let leftView = overlayView
        let rightView = overlayView
        let topView = overlayView
        let bottomView = overlayView
        
        addSubview(leftView)
        addSubview(rightView)
        addSubview(topView)
        addSubview(bottomView)
        
        // Constraints
        addConstraintsWithFormat("H:|-(0)-[v0]-(0)-[v1]", views: leftView, focusView)
        addConstraintsWithFormat("V:|-(0)-[v0]-(0)-|", views: leftView)
        
        addConstraintsWithFormat("H:[v0]-(0)-[v1]-(0)-|", views: focusView, rightView)
        addConstraintsWithFormat("V:|-(0)-[v0]-(0)-|", views: rightView)
        
        addConstraintsWithFormat("H:[v0]-(0)-[v1]-(0)-[v2]", views: leftView, topView, rightView)
        addConstraintsWithFormat("V:|-(0)-[v0]-(0)-[v1]", views: topView, focusView)
        
        addConstraintsWithFormat("H:[v0]-(0)-[v1]-(0)-[v2]", views: leftView, bottomView, rightView)
        addConstraintsWithFormat("V:[v0]-(0)-[v1]-(0)-|", views: focusView, bottomView)
        
    }
}

