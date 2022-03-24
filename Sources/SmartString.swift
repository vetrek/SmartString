//
//  SmartStrings.swift
//  Mobility
//
//  Created by Valerio Sebastianelli on 1/31/22.
//

import Foundation
import UIKit

public typealias StringClosure = (String) -> Void

public final class SmartString: SmartStringable {
    var attributedText: NSMutableAttributedString!
    var tappableRanges: [NSRange: StringClosure] = [:]
    
    public init(string: String) {
        self.attributedText = NSMutableAttributedString(string: string)
    }
    
    public init(attributedString: NSAttributedString) {
        self.attributedText = NSMutableAttributedString(attributedString: attributedString)
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
        if let tappableRange = rhs.tappableRanges.first {
            let range = NSMakeRange(lhs.length, tappableRange.key.length)
            
            lhs.tappableRanges[range] = tappableRange.value
        }
        lhs.append(smartString: rhs)
        return lhs
    }
    
    @objc func labelDidTap(gesture: UITapGestureRecognizer) {
        guard let label = gesture.view as? UILabel else { return }
        for tappableRange in tappableRanges {
            guard
                gesture.didTapAttributedTextInLabel(label: label, inRange: tappableRange.key)
            else { continue }
            
            let string = attributedText.attributedSubstring(from: tappableRange.key).string
            tappableRange.value(string)
            return 
        }
    }
}

// MARK: - Internal Properties

extension SmartString {
    var length: Int {
        attributedText.length
    }
    
    var fullRange: NSRange {
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
    
    @discardableResult
    func background(_ color: UIColor) -> SmartString {
        addAttribute(key: .backgroundColor, value: color)
    }
    
    @discardableResult
    func background(closure: () -> UIColor) -> SmartString {
        background(closure())
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
    
    @discardableResult
    func underline() -> SmartString {
        addAttribute(key: .underlineStyle, value: NSUnderlineStyle.single.rawValue)
    }
    
    /// To work you must have set a font prior to this. Otherwise there is not Font to convert to bold
    /// - Returns: SmartString instance
    @discardableResult func bold() -> SmartString {
        let attributes = attributedText.attributes(at: 0, effectiveRange: nil)
        if let font = attributes[NSAttributedString.Key.font] as? UIFont {
            let bold = font.bold()
            addAttribute(key: .font, value: bold)
        }
        return self
    }
    
    @discardableResult func italic() -> SmartString {
        let attributes = attributedText.attributes(at: 0, effectiveRange: nil)
        if let font = attributes[NSAttributedString.Key.font] as? UIFont {
            let italic = font.italic()
            addAttribute(key: .font, value: italic)
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
    
    // MARK: - Link
    
    @discardableResult
    func link(_ url: URL) -> SmartString {
        addAttribute(key: .link, value: url)
    }
    
    func link(closure: () -> URL) -> SmartString {
        link(closure())
    }
    
    // MARK: - Tap Handler
    
    func onTap(closure: @escaping (String) -> Void) -> SmartString {
        tappableRanges[fullRange] = closure
        return self
    }
}

extension SmartString {
    func removeAttribute(key: NSAttributedString.Key) {
        attributedText.enumerateAttribute(
            key,
            in: fullRange,
            options: [],
            using: { value, range, _ in
                guard value != nil else { return }
                attributedText.removeAttribute(key, range: range)
            }
        )
    }
    
    @discardableResult
    func addAttribute(key: NSAttributedString.Key, value: Any) -> SmartString {
        removeAttribute(key: key)
        attributedText.addAttributes([key: value], range: fullRange)
        return self
    }
}

// MARK: - SmartString + Label
extension SmartString {
    /// Add the label default font if needed
    func addMissingFontIfNeeded(label: UILabel) {
        guard let labelFont = label.font else { return }
        attributedText.enumerateAttributes(
            in: fullRange,
            options: []
        ) { [weak self] attr, range, asd in
            guard !attr.contains(where: ({ $0.key == .font })) else { return }
            self?.attributedText.addAttributes(
                [.font: labelFont],
                range: range
            )
        }
    }
}
