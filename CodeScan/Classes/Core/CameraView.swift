//
//  CameraView.swift
//  Scanner
//
//  Created by SR on 9/9/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation
import AVKit
import Vision



class Reader: NSObject {
    
    // Set Up Camera
    var cameraPosition: AVCaptureDevice.Position = .back
    var cameraFocusMode: AVCaptureDevice.FocusMode = .continuousAutoFocus
    var cameraFlashMode: AVCaptureDevice.FlashMode = .off
    
    lazy var camera: AVCaptureDevice? = {
        
        let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: self.cameraPosition)
        guard let backCamera = availableDevices.devices.first else {
            
            return self.defaultCamera
        }
        return backCamera
    }()
    
    lazy var cameraInput: AVCaptureDeviceInput? = {
        
        guard let camera = self.camera else {
            
            return nil
        }
        let input = try? AVCaptureDeviceInput(device: camera)
        return input
    }()
    
    // Session
    lazy var captureSession: AVCaptureSession = {
        
        let session  = AVCaptureSession()
        session.sessionPreset = .photo
        return session
    }()
    
    lazy var visionRequests: [VNRequest] = {
        
        let request = VNDetectBarcodesRequest(completionHandler: visionDidDetectBarcode)
        if mode.contains(.qrCode) {
            request.symbologies += [.QR]
        }
        if mode.contains(.barCode) {
            request.symbologies += [.UPCE,.Code39,.Code128,.EAN13]
        }
        return [request]
    }()
    
    // Output
    lazy var videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    var videoOutput: AVCaptureVideoDataOutput = {
        
        return AVCaptureVideoDataOutput()
    }()
    
    
    
    // Instance Memebers
    private let permissionController = CameraPermissionService()
    private lazy var bufferQueue: DispatchQueue = {
        let queue = DispatchQueue(label: "ScannerDispatch", qos: .userInteractive, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global())
        return queue
    }()
    private lazy var notificaitonQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = QualityOfService.userInteractive
        return queue
    }()
    
    
    
    // Set from parent
    private let cameraLayer: CALayer
    private let focusLayer: CALayer
    private let mode: ScannerReadingMode
    weak var delegate: ScannerResultDelegate?
    weak var parent: SRScanner?
    
    
    
    // MARK: Life Cycle
    init(cameraLayer: CALayer, focusLayer: CALayer, mode: ScannerReadingMode) {
        self.cameraLayer = cameraLayer
        self.focusLayer = focusLayer
        self.mode = mode
        super.init()
        
        //startMonitoring()
    }
    
    
    
    deinit {
        
        //stopMonitoring()
    }
    
    
    
    
    func startMonitoring() {
        
        NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: self, queue: notificaitonQueue, using: orientationDidChang)
    }
    
    
    
    func stopMonitoring() {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    func orientationDidChang(_ notification: Notification) {
        
        orientionDidChange()
    }
}






extension Reader: CaptureSessionInput, CaptureSessionOutput {
    
    /* Using Default configuration for session Input & Output */
}





extension Reader: CaptureSession {
    
    func initilizeSession() {
        
        guard !ScanningDevice.isSimulator else {
            
            self.delegate?.scanningDidFail(with: ScannerError.ScannerDoesntSupportInSimulator)
            return
        }
        
        permissionController.checkPermissionStatus { [weak self] (isGranted, error) in
            
            guard let self = self else {
                return 
            }
            
            guard isGranted else {
                
                self.delegate?.cameraAcessPermissionStatus(status: .Denied)
                return
            }
            
            self.delegate?.cameraAcessPermissionStatus(status: .Granted)
            if self.captureSession.isRunning {
                
                self.stopCapturing()
            }
            
            self.initilizeFocusMode()
            self.attachSessionInput()
            self.attachSessionOutput()
            self.initilizePreviewLayer()
            self.startCapturing()
            self.initilizeCameraFlash()
        }
    }
    
    
    
    func attachSessionInput() {
        
        guard let input = self.cameraInput else {
            
            self.delegate?.scanningDidFail(with: ScannerError.CameraInputError)
            return
        }
        
        guard captureSession.canAddInput(input) else {
            
            self.delegate?.scanningDidFail(with: ScannerError.CameraInputError)
            return
        }
        captureSession.addInput(input)
    }
    
    
    
    func attachSessionOutput() {
        
        guard captureSession.canAddOutput(self.videoOutput) else {
            
            self.delegate?.scanningDidFail(with: ScannerError.CameraOutputError)
            return
        }
        
        
        // Set the quality of the video
        self.videoOutput.alwaysDiscardsLateVideoFrames = true
        self.videoOutput.setSampleBufferDelegate(self, queue: bufferQueue)
        self.captureSession.addOutput(self.videoOutput)
        
    }
    
    
    
    func initilizePreviewLayer() {
        
        let bounds = cameraLayer.bounds
        videoPreviewLayer.bounds = bounds
        videoPreviewLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        cameraLayer.insertSublayer(videoPreviewLayer, at: 0)
        
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer.session = captureSession
        if let connection = videoPreviewLayer.connection, connection.isVideoOrientationSupported {
            
            connection.videoOrientation = self.videoOrientation
        }
    }
    
    
    
    func orientionDidChange() {
        
        updatePreviewFrame()
        if let connection = videoPreviewLayer.connection, connection.isVideoOrientationSupported {
            
            connection.videoOrientation = self.videoOrientation
        }
    }
    
    
    
    func updatePreviewFrame() {
        
        let bounds = cameraLayer.bounds
        videoPreviewLayer.bounds = bounds
        videoPreviewLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    
    
    func initilizeCameraFlash() {
        
        let isFlashOn = Bool(truncating: self.cameraFlashMode.rawValue as NSNumber)
        self.toggleCameraFlash(isOn: isFlashOn)
    }
    
    
    
    func initilizeFocusMode() {
        
        guard let camera = self.camera else {
            
            delegate?.scanningDidFail(with: ScannerError.CameraNotFound)
            return
        }
        
        do {
            
            if camera.isFocusModeSupported(self.cameraFocusMode) {
                
                try self.camera!.lockForConfiguration()
                self.camera!.focusMode = self.cameraFocusMode
                self.camera!.unlockForConfiguration()
                return
            } else {
                
                delegate?.scanningDidFail(with: ScannerError.CameraFocusModeError)
                return
            }
        } catch {
            
            delegate?.scanningDidFail(with: ScannerError.CameraFocusModeError)
            return
        }
    }
    
    
    
    public func toggleCameraFlash(isOn: Bool) {
        
        guard let camera = self.camera else {
            
            delegate?.cameraFlashError(ScannerError.CameraNotFound)
            return
        }
        
        do {
            
            if camera.hasTorch {
                
                try camera.lockForConfiguration()
                camera.torchMode = (isOn) ? .on : .off
                camera.unlockForConfiguration()
                return
            } else {
                
                delegate?.cameraFlashError(.CameraFlashNotAvailable)
                return
            }
        } catch {
            
            delegate?.cameraFlashError(.CameraFlashNotAvailable)
            return
        }
    }
    
    
    
    public func startCapturing() {
        
        captureSession.startRunning()
    }
    
    
    
    public func pauseCapturing() {
        
        captureSession.stopRunning()
    }
    
    
    
    public func stopCapturing() {
        
        captureSession.removeOutput(self.videoOutput)
        captureSession.stopRunning()
    }
    
    
    
    func getBoundsRespectWithScreen(for barcode: VNBarcodeObservation) -> CGRect {
        
        /*
        // Current origin is on the bottom-left corner
        let xCord = barcode.boundingBox.origin.x * self.cameraLayer.frame.size.width
        var yCord = (1 - barcode.boundingBox.origin.y) * self.cameraLayer.frame.size.height
        let width = barcode.boundingBox.size.width * self.cameraLayer.frame.size.width
        var height = -1 * barcode.boundingBox.size.height * self.cameraLayer.frame.size.height
        
        // Re-adjust origin to be on the top-left corner, so that calculations can be standardized
        yCord += height
        height *= -1
        return CGRect(x: xCord, y: yCord, width: width, height: height)
        */
        
        let transformedRect = barcode.boundingBox
        let convertedRect = self.videoPreviewLayer.layerRectConverted(fromMetadataOutputRect: transformedRect)
        return CGRect(x: convertedRect.origin.x, y:  convertedRect.origin.y, width:  convertedRect.size.width, height:  convertedRect.size.height)
    }
}






extension Reader: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        // Validation
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        var requestOptions: [VNImageOption : Any] = [:]
        if let camData = CMGetAttachment(sampleBuffer, key: kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, attachmentModeOut: nil) {
            
            requestOptions = [.cameraIntrinsics : camData]
        }
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: imageBuffer, orientation: .up, options: requestOptions)
        do {
            
            try imageRequestHandler.perform(self.visionRequests)
        } catch {
            
            print(error)
        }
    }
}






extension Reader {
    
    func visionDidDetectBarcode(_ request: VNRequest?, error: Error?) {
        
        guard let scanCodes = request?.results as? [VNBarcodeObservation], scanCodes.count > 0 else {
            return
        }
        
        if self.captureSession.isRunning { 
            
            // Assume first item is user selected
            if let code = scanCodes.first {
                
                // Check Code scanned in Focus Region
                let bounds = getBoundsRespectWithScreen(for: code)
                if focusLayer.frame.contains(bounds) {
                    
                    self.pauseCapturing()
                    self.parent?.pauseAnimation()
                    let codeType: CodeType = (code.symbology == .QR ? CodeType.QRCode : .BarCode)
                    let data = code.payloadStringValue
                    delegate?.scanningDidSuccess(with: codeType, value: data)
                } else {
                    
                    print("Out of focus area!")
                }
                
            }
        }
    }
}







