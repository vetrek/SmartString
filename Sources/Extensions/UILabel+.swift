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
            
            if let smartString = smartString,
               smartString.tappableRanges.isEmpty == false {
                isUserInteractionEnabled = true
                addGestureRecognizer(
                    UITapGestureRecognizer(
                        target: newValue,
                        action: #selector(smartString.labelDidTap)
                    )
                )
            } 
        }
    }
    
    
    private static var framesetterLock: NSLock = .init()
    
    var flushFactor: CGFloat {
        switch textAlignment {
        case .center: return 0.5
        case .right: return 1.0
        default: return 0.0
        }
    }

}
