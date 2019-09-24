//
//  ViewController.swift
//  CodeScan
//
//  Created by sarathraveendran-litmus7 on 09/13/2019.
//  Copyright (c) 2019 sarathraveendran-litmus7. All rights reserved.
//

import UIKit
import CodeScan


class ViewController: UIViewController {
    
    var scanner: SRScanner!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scanner = SRScanner(self.view, position: ScannerPosition.middle, mode: [ScannerReadingMode.barCode, ScannerReadingMode.qrCode])
        scanner.delegate = self
        scanner.initializeScanning()
        scanner.addOverlay()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scanner.updatePreviewFrame()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func resume() {
        
        scanner.resumeAnimation()
        
    }
    
    @IBAction func pause() {
        
        scanner.pauseAnimation()
    }
    
}




extension ViewController: ScannerResultDelegate {
    func scanningDidSuccess(with codeType: CodeType, value: String?) {
        
        print(value as Any)
    }
    
    func scanningDidFail(with error: ScannerError?) {
        
        print(error as Any)
    }
    
    func cameraFlashError(_ error: ScannerError) {
        print(error)
        
    }
    
    func cameraAcessPermissionStatus(status: CameraAccessPermmisionStatus) {
        print("===", status)
    }
    
    
}


