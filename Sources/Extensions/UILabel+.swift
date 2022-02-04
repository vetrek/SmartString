//
//  File.swift
//  
//
//  Created by Valerio Sebastianelli on 2/3/22.
//

import Foundation
import UIKit

public extension UILabel {
    private static let smartString = AssociatedObject<SmartString>()
    
    var smartString: SmartString? {
        get {
            return UILabel.smartString[self]
        }
        set {
            attributedText = newValue?.attributedText
            UILabel.smartString[self] = newValue
        }
    }
}
