//
//  File.swift
//  
//
//  Created by Valerio Sebastianelli on 2/3/22.
//

import Foundation
import UIKit

public extension UITextField {
    private static let smartString = AssociatedObject<SmartString>()
    
    var smartString: SmartString? {
        get {
            return UITextField.smartString[self]
        }
        set {
            attributedText = newValue?.attributedText
            UITextField.smartString[self] = newValue
        }
    }
}
