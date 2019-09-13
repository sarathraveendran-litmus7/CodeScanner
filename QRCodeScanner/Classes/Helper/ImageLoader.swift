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
       
        let podBundle = Bundle(for: Image.self) // for getting pod url
        if let url = podBundle.url(forResource: "Asset", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            return UIImage(named: named, in: bundle, compatibleWith: nil)
        }
        return UIImage()
    }
}
