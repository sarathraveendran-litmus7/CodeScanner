//
//  ScannerResultDelegate.swift
//  Scanner
//
//  Created by SR on 9/9/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation
import AVKit

public protocol ScannerResultDelegate: class {
    
    func scanningDidSuccess(with codeType: CodeType, value: String?)
    func scanningDidFail(with error: ScannerError?)
    
    func cameraFlashError(_ error: ScannerError)
    func cameraAcessPermissionStatus(status: CameraAccessPermmisionStatus)
}
