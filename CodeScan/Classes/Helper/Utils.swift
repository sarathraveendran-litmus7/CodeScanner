//
//  Utils.swift
//  CodeScan
//
//  Created by SR on 9/19/19.
//

import Foundation
import UIKit


func getScanningAreaSize(_ scannerView: UIView) -> CGSize {
    
    let device = UIDevice.current.userInterfaceIdiom
    let size: CGSize
    
    switch device {
        
    case .pad:
        let width = round(scannerView.bounds.width * 0.7)
        let height = round((width * 3)/4) - 80
        size = CGSize(width: width, height: height)
        
    case .phone:
        let width = round(scannerView.bounds.width * 0.8)
        let height = round((width * 3)/4) - 60
        size = CGSize(width: width, height: height)
        
    default:
        size = CGSize(width: 0, height: 0)
    }
    return size
}



