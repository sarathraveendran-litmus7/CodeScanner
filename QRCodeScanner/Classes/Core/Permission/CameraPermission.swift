//
//  PermissionHelper.swift
//  Scanner
//
//  Created by SR on 9/8/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation


protocol CameraPermission {
    
    typealias PermissionStatus = (_ isAuthorized: Bool, _ error: ScannerError?) -> ()
    func checkPermissionStatus(_ onCompletion: @escaping PermissionStatus)
    func requestPermission(_ onCompletion: @escaping PermissionStatus)
}

