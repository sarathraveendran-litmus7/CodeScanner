//
//  OverlayView.swift
//  CodeScan
//
//  Created by SR on 9/19/19.
//

import Foundation
import UIKit


class OverlayView: UIView {
    
    
    // Set from parent
    let scannerPosition: ScannerPosition!
    weak var focusView: UIView!
    
    
    
    // MARK: Life Cycle
    init(_ scannerPosition: ScannerPosition, focusView: UIView) {
        self.scannerPosition = scannerPosition
        self.focusView = focusView
        super.init(frame: .zero)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        mask(withRect: focusView.frame, inverse: true)
    }
    
    
    func addMask() {
        
        // Style
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
}


