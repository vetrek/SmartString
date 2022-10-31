//
//  SmartStrings.swift
//
//  Copyright (c) 2021 Vetrek (valerio.alsebas@gmail.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

public typealias StringClosure = (String) -> Void

public final class SmartString: SmartStringable {

    // MARK: - Public Properties
    
    public private(set) var attributedText: NSMutableAttributedString!
    public var string: String { attributedText.string }
    
    // MARK: - Private Properties
    var tappableRanges: [NSRange: StringClosure] = [:]
    
    // MARK: - Init
    init() {
        self.attributedText = NSMutableAttributedString(string: "")
    }
    
    public init(string: String, hasXML: Bool = false) {
        guard
            hasXML,
            let xmlSmartString = try? XMLStringParser(string: string).parse()
        else {
            self.attributedText = NSMutableAttributedString(string: string)
            return
        }
        self.tappableRanges = xmlSmartString.tappableRanges
        self.attributedText = xmlSmartString.attributedText
    }
    
    public init(attributedString: NSAttributedString) {
        self.attributedText = NSMutableAttributedString(attributedString: attributedString)
        
        let mutable = NSMutableAttributedString(attributedString: attributedString)
        let fullRange = NSRange(location: 0, length: mutable.length)
        mutable.enumerateAttributes(in: fullRange) { value, range, _ in
            guard
                value.keys.contains(.link),
                let url = value[.link] as? URL
            else { return }
            tappableRanges[range] = { _ in
                guard UIApplication.shared.canOpenURL(url) else { return }
                UIApplication.shared.open(url)
            }
        }
    }
    
    // MARK: - Public overload operators
    
    public static func +(lhs: SmartString, rhs: String) -> SmartString {
        lhs.append(string: rhs)
        return lhs
    }
    
    public static func +(lhs: SmartString, rhs: SmartString) -> SmartString {
        if let tappableRange = rhs.tappableRanges.first {
            let range = NSMakeRange(lhs.length, tappableRange.key.length)
            
            lhs.tappableRanges[range] = tappableRange.value
        }
        lhs.append(smartString: rhs)
        return lhs
    }
    
    public static func +=(lhs: SmartString, rhs: SmartString) {
        if let tappableRange = rhs.tappableRanges.first {
            let range = NSMakeRange(lhs.length, tappableRange.key.length)
            
            lhs.tappableRanges[range] = tappableRange.value
        }
        lhs.append(smartString: rhs)
    }
    
    // MARK: - Public Utility functions
    
    public func height(for width: CGFloat) -> CGFloat {
        attributedText.computeStringHeight(width: width)
    }
    
}

// MARK: - Internal functions

extension SmartString {
    func append(string: String) {
        attributedText.append(NSAttributedString(string: string))
    }
    
    func append(smartString: SmartString) {
        attributedText.append(smartString.attributedText)
    }
}

// MARK: - Internal Computed Properties

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
        if let font = style.font {
            self.font(font)
        }
        
        if let color = style.color {
            self.color(color)
        }
        
        if let backgroundColor = style.backgroundColor {
            self.background(backgroundColor)
        }
        
        if let shadow = style.shadow {
            self.shadow(shadow)
        }
        
        if style.underlined {
            self.underline()
        }
        
        if let url = style.link {
            self.link(url)
        }
        
        if let onTap = style.onTap {
            self.onTap(closure: onTap)
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
    @discardableResult
    func bold() -> SmartString {
        guard attributedText.length > 0 else { return self }
        let attributes = attributedText.attributes(at: 0, effectiveRange: nil)
        if let font = attributes[NSAttributedString.Key.font] as? UIFont {
            let bold = font.bold()
            addAttribute(key: .font, value: bold)
        }
        else {
            print("SmartString 🔵", "Bold can only be applied if the SmartString has an associated Font")
        }
        return self
    }
    
    @discardableResult
    func italic() -> SmartString {
        guard attributedText.length > 0 else { return self }
        let attributes = attributedText.attributes(at: 0, effectiveRange: nil)
        if let font = attributes[NSAttributedString.Key.font] as? UIFont {
            let italic = font.italic()
            addAttribute(key: .font, value: italic)
        }
        else {
            print("SmartString 🔵", "italic can only be applied if the SmartString has an associated Font")
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
        return onTap { _ in
            guard UIApplication.shared.canOpenURL(url) else { return }
            UIApplication.shared.open(url)
        }
    }
    
    func link(closure: () -> URL) -> SmartString {
        link(closure())
    }
    
    // MARK: - Image
    
    @discardableResult
    func appendImage(_ image: UIImage, height: CGFloat = 18) -> SmartString {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.setImageHeight(height: height)
        attributedText.append(NSAttributedString(attachment: attachment))
        return self
    }
    
    func appendImage(height: CGFloat, closure: () -> UIImage) -> SmartString {
        appendImage(closure(), height: height)
    }
        
    // MARK: - Tap Handler
    
    @discardableResult
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
