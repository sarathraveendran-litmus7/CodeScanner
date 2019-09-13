//
//  DefaultConfiguration.swift
//  Scanner
//
//  Created by SR on 9/12/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation
import AVKit
import UIKit


extension CaptureSessionInput {
    
    var defaultCamera: AVCaptureDevice? {
        
        return AVCaptureDevice.default(for: .video)
    }
}



extension CaptureSessionOutput {
    
    var videoOrientation: AVCaptureVideoOrientation {
        
        let orientation = UIApplication.shared.statusBarOrientation
        print(orientation.rawValue)
        switch orientation {
        case .portrait              : return .portrait
        case .portraitUpsideDown    : return .portraitUpsideDown
        case .landscapeLeft         : return .landscapeLeft
        case .landscapeRight        : return .landscapeRight
        default                     : return .portrait
        }
    }
}
