//
//  Scanner.swift
//  Scanner
//
//  Created by SR on 9/6/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation
import UIKit


public class SRScanner: NSObject {
    
    // Declarations
    private let scannerView: UIView
    private let scannerPosition: ScannerPosition
    private let mode: ScannerReadingMode
    private lazy var focusView: FocusView = {
        let view = FocusView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var overlayView: OverlayView = {
        let view = OverlayView(self.scannerPosition, focusView: self.focusView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // Set from parent
    public weak var delegate: ScannerResultDelegate? {
        didSet {
            self.reader.delegate = self.delegate
        }
    }
    private var reader: Reader!
    
    
    
    // MARK: Life Cycle
    public init(_ view: UIView, position: ScannerPosition, mode: ScannerReadingMode) {
        self.scannerView = view
        self.scannerPosition = position
        self.mode = mode
        super.init()
        
        self.styleScanner()
        self.reader = Reader(cameraLayer: scannerView.layer, focusLayer: self.focusView.layer, mode: mode)
        self.reader.parent = self
    }
}






extension SRScanner {
    
    private func styleScanner() {
        
        let size = getScanningAreaSize(self.scannerView)
        scannerView.addSubview(focusView)
        
        switch scannerPosition {
            
        case .top:
            arrangeScannerAtTop(width: size.width, height: size.height)
            
        case .middle:
            arrangeScannerAtMiddle(width: size.width, height: size.height)
        }
    }
    
    
    
    private func arrangeScannerAtTop(width: CGFloat, height: CGFloat) {
        
        focusView.setConstraint(width: width, height: height, centerX: 0, centerY: nil, top: 16)
    }
    
    
    
    private func arrangeScannerAtMiddle(width: CGFloat, height: CGFloat) {
        
        focusView.setConstraint(width: width, height: height, centerX: 0, centerY: 0, top:  nil)
    }
}






extension SRScanner {
    
    public func initializeScanning() {
    
        reader.initilizeSession()
    }
    
    
    
    public func pauseAnimation() {
        
        DispatchQueue.main.async {
            
            self.focusView.pause()
        }
    }
    
    
    
    public func resumeAnimation() {
        
        DispatchQueue.main.async {
            
            self.focusView.resume()
        }
    }
    
    
    
    public func startCapturing() {
        
        DispatchQueue.main.async {
            
            self.reader.startCapturing()
            self.resumeAnimation()
        }
    }
    
    
    
    public func pauseCapturing() {
        
        DispatchQueue.main.async {
            
            self.reader.pauseCapturing()
            self.pauseAnimation()
        }
    }
    
    
    
    public func stopCapturing() {
        
        DispatchQueue.main.async {
            
            self.reader.stopCapturing()
            self.pauseAnimation()
        }
    }
    
    
    
    public func orientionDidChange() {
        
        reader.orientionDidChange()
    }
    
    
    
    public func updatePreviewFrame() {
        
        reader.updatePreviewFrame()
        updateOverlayFrame()
    }
    
    
    public func addOverlay() {
        
        self.scannerView.addSubview(overlayView)
        overlayView.setConstraint(leftAnchor: self.scannerView.leftAnchor, rightAnchor: self.scannerView.rightAnchor, topAnchor: self.scannerView.topAnchor, bottomAnchor: self.scannerView.bottomAnchor)
    }
    
    
    func updateOverlayFrame() {
        
        overlayView.addMask()
    }
}




