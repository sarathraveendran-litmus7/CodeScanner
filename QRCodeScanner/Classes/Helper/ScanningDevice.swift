//
//  ScanningDevice.swift
//  Scanner
//
//  Created by SR on 9/9/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation

class ScanningDevice {
    
    static var isSimulator: Bool = {
       
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }()
}
