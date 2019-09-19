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
        
        let size = getScanningAreaSize()
        scannerView.addSubview(focusView)
        
        switch scannerPosition {
            
        case .top:
            arrangeScannerAtTop(width: size.width, height: size.height)
            
        case .middle:
            arrangeScannerAtMiddle(width: size.width, height: size.height)
        }
    }
    
    
    
    private func getScanningAreaSize() -> CGSize {
        
        let device = UIDevice.current.userInterfaceIdiom
        let size: CGSize
        
        switch device {
            
        case .pad:
            let width = round(self.scannerView.bounds.width * 0.6)
            let height = round((width * 3)/4) + 120
            size = CGSize(width: width, height: height)
            
        case .phone:
            let width = round(self.scannerView.bounds.width * 0.8)
            let height = round((width * 3)/4) + 80
            size = CGSize(width: width, height: height)
            
        default:
            size = CGSize(width: 0, height: 0)
        }
        return size
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
        
        focusView.pause()
    }
    
    
    public func resumeAnimation() {
        
        focusView.resume()
    }
    
    
    public func startCapturing() {
        
        reader.startCapturing()
    }
    
    
    public func pauseCapturing() {
        
        reader.pauseCapturing()
    }
    
    
    
    public func stopCapturing() {
        
        reader.stopCapturing()
    }
    
    
    public func orientionDidChange() {
        
        reader.orientionDidChange()
    }
    
    
    public func updatePreviewFrame() {
        
        reader.updatePreviewFrame()
    }
}




