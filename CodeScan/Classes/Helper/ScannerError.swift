//
//  ScannerError.swift
//  Scanner
//
//  Created by SR on 9/8/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation

public enum ScannerError: Error {
    
    case ScannerDoesntSupportInSimulator
    case CameraPermissionDenied
    case CameraFlashNotAvailable
    
    case CameraNotFound
    case CameraInputError
    
    case CameraOutputError
    case CameraFocusModeError
}


public enum CameraAccessPermmisionStatus {
    
    case Granted, Denied
}