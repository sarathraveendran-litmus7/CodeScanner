//
//  CameraPermissionService.swift
//  Scanner
//
//  Created by SR on 9/8/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation
import AVKit



struct CameraPermissionService: CameraPermission {
   
    // Declarations
    typealias PermissionStatus = (_ isAuthorized: Bool, _ error: ScannerError?) -> ()
    
    
    
    public func checkPermissionStatus(_ onCompletion: @escaping PermissionStatus) {
        
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
            
        case .authorized:
            onCompletion(true, nil)
            
        case .notDetermined:
            requestPermission(onCompletion)
            
        default:
            onCompletion(false, ScannerError.CameraPermissionDenied)
        }
    }
    
    
    
    public func requestPermission(_ onCompletion: @escaping PermissionStatus) {
     
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { status in
            
            DispatchQueue.main.async {
                
                if status {
                    
                    onCompletion(true, nil)
                } else {
                    
                    onCompletion(false, ScannerError.CameraPermissionDenied)
                }
            }
        }
    }
}
