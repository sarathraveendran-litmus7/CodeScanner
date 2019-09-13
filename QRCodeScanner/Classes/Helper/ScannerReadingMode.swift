//
//  ScannerReadingMode.swift
//  Scanner
//
//  Created by SR on 9/8/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation


public struct ScannerReadingMode: OptionSet {
    
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let qrCode = ScannerReadingMode(rawValue: 1 << 0)
    public static let barCode = ScannerReadingMode(rawValue: 1 << 1)
}



public enum CodeType {
    
    case QRCode, BarCode
}

