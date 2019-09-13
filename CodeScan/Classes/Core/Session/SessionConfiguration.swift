//
//  Session.swift
//  Scanner
//
//  Created by SR on 9/8/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation
import AVKit



protocol CaptureSessionInput {
    
    var camera: AVCaptureDevice? { get }
    var cameraInput: AVCaptureDeviceInput? { get }
    
    // Defaults
    var cameraPosition: AVCaptureDevice.Position { get set}
    var cameraFocusMode: AVCaptureDevice.FocusMode { get set }
    var cameraFlashMode: AVCaptureDevice.FlashMode { get set }
    var defaultCamera: AVCaptureDevice? { get }
}



protocol CaptureSessionOutput {
    
    var videoOutput: AVCaptureVideoDataOutput { get }
    var videoOrientation: AVCaptureVideoOrientation { get }
    var videoPreviewLayer: AVCaptureVideoPreviewLayer { get set }
}



protocol CaptureSession {
    
    var captureSession: AVCaptureSession { get set }
    
    func initilizeSession()
    func attachSessionInput()
    func attachSessionOutput() 
    func initilizePreviewLayer()
    
    func toggleCameraFlash(isOn: Bool) 
    func startCapturing()
    func pauseCapturing()
    func stopCapturing()
}


