//
//  SmartStrings.swift
//  Mobility
//
//  Created by Valerio Sebastianelli on 1/31/22.
//

import Foundation
import UIKit

public final class SmartString: SmartStringable {
    var attributedText: NSMutableAttributedString!
    
    init(string: String) {
        self.attributedText = NSMutableAttributedString(string: string)
    }
    
    func append(string: String) {
        attributedText.append(NSAttributedString(string: string))
    }
    
    func append(smartString: SmartString) {
        attributedText.append(smartString.attributedText)
    }
    
    public static func + (lhs: SmartString, rhs: String) -> SmartString {
        lhs.append(string: rhs)
        return lhs
    }
    
    public static func + (lhs: SmartString, rhs: SmartString) -> SmartString {
        lhs.append(smartString: rhs)
        return lhs
    }
}

// MARK: - Internal Properties

extension SmartString {
    var length: Int {
        attributedText.length
    }
    
    var completeRange: NSRange {
        NSMakeRange(0, length)
    }
}

// MARK: - Public Methods

public extension SmartString {
    // MARK: - Style
    
    @discardableResult
    func style(_ style: SmartStringStyle) -> SmartString {
        if let color = style.color {
            self.color(color)
        }
        
        if let font = style.font {
            self.font(font)
        }
        
        if let shadow = style.shadow {
            self.shadow(shadow)
        }
        
        return self
    }
    
    // MARK: - Color
    
    @discardableResult
    func color(_ color: UIColor) -> SmartString {
        addAttribute(key: .foregroundColor, value: color)
    }
    
    @discardableResult
    func color(closure: () -> UIColor) -> SmartString {
        color(closure())
    }
    
    // MARK: - Font
    
    @discardableResult
    func font(_ font: UIFont) -> SmartString {
        addAttribute(key: .font, value: font)
    }
    
    @discardableResult
    func font(closure: () -> UIFont) -> SmartString {
        font(closure())
    }
    
    // MARK: - Shadow
    
    /// To work you must have set a font prior to this. Otherwise there is not Font to convert to bold
    /// - Returns: SmartString instance
    @discardableResult func toBold() -> SmartString {
        let attributes = attributedText.attributes(at: 0, effectiveRange: nil)
        if let font = attributes[NSAttributedString.Key.font] as? UIFont {
            let bold = font.bold()
            addAttribute(key: .font, value: bold)
        }
        return self
    }
    
    
    // MARK: - Shadow
    
    @discardableResult
    func shadow(_ shadow: SmartShadow) -> SmartString {
        addAttribute(key: .shadow, value: shadow.toNSShadow())
    }
    
    @discardableResult
    func shadow(closure: () -> SmartShadow) -> SmartString {
        shadow(closure())
    }
    
}

extension SmartString {
    func removeAttribute(key: NSAttributedString.Key) {
        var attributes = attributedText.attributes(at: 0, effectiveRange: nil)
        attributes.removeValue(forKey: key)
        attributedText.setAttributes(attributes, range: completeRange)
    }
    
    @discardableResult
    func addAttribute(key: NSAttributedString.Key, value: Any) -> SmartString {
        removeAttribute(key: key)
        attributedText.addAttributes([key: value], range: completeRange)
        return self
    }
}
