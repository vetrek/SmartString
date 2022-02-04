//
//  File.swift
//  
//
//  Created by Valerio Sebastianelli on 2/3/22.
//

import Foundation
import UIKit

extension UITextView {
    private static let smartString = AssociatedObject<SmartString>()
    
    var smartString: SmartString? {
        get {
            return UITextView.smartString[self]
        }
        set {
            attributedText = newValue?.attributedText
            UITextView.smartString[self] = newValue
        }
    }
}
