//
//  ImageLoader.swift
//  QRCodeScanner
//
//  Created by SR on 9/13/19.
//

import Foundation
import UIKit

class Image {
    
    static func getImage(_ named: String) -> UIImage? {
       
        let bundle = Bundle(for: Image.self)
        return UIImage(named: named, in: bundle, compatibleWith: nil)
    }
}
