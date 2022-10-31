//
//  File.swift
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

import Foundation
import UIKit

public protocol SmartStringable {
    // MARK: - Style

    /// Set SmartString style
    /// - Parameter style: The a SmartStringStyle object.
    /// - Returns: The new SmartString instance.
    func style(_ style: SmartStringStyle) -> SmartString
    
    // MARK: - Color
    
    /// Apply a new color.
    /// - Parameter color: The new color.
    /// - Returns: The new SmartString instance.
    func color(_ color: UIColor) -> SmartString
    
    /// Apply a new Color using a Closure.
    /// - Parameter closure: The closure which must return the new Color.
    /// - Returns: The new SmartString instance.
    func color(closure: () -> UIColor) -> SmartString
    
    /// Apply a new Background color.
    /// - Parameter closure: The new Background color.
    /// - Returns: The new SmartString instance.
    func background(_ color: UIColor) -> SmartString
    
    /// Apply a new Background color using a Closure.
    /// - Parameter closure: The closure which must return the new Background Color.
    /// - Returns: The new SmartString instance.
    func background(closure: () -> UIColor) -> SmartString
    
    // MARK: - Font

    /// Apply a new Font.
    /// - Parameter closure: The new Font.
    /// - Returns: The new SmartString instance.
    func font(_ font: UIFont) -> SmartString
    
    /// Apply a new Font using a Closure.
    /// - Parameter closure: The closure which must return the new Font.
    /// - Returns: The new SmartString instance.
    func font(closure: () -> UIFont) -> SmartString
    
    /// Apply a bold effect to the Font. **Works only if a Font was previously applyed**
    /// - Returns: SmartString instance
    func bold() -> SmartString
    
    /// Apply the Underline effect to the string.
    /// - Returns: The new SmartString instance.
    func underline() -> SmartString
    
    /// Apply an italic effect to the Font. **Works only if a Font was previously applyed**
    /// - Returns: SmartString instance
    func italic() -> SmartString
    
    // MARK: - Shadow
    
    /// Apply a Shadow.
    /// - Parameter closure: The shadow style.
    /// - Returns: The new SmartString instance.
    func shadow(_ shadow: SmartShadow) -> SmartString
    
    /// Apply a Shadow using a Closure.
    /// - Parameter closure: The closure which must return the new Shadow Style.
    /// - Returns: The new SmartString instance.
    func shadow(closure: () -> SmartShadow) -> SmartString
    
    // MARK: - Link
    
    /// Apply a link type effect and make the url tappable.
    /// - Parameter closure: The URL to open using the default browser.
    /// - Returns: The new SmartString instance.
    func link(_ url: URL) -> SmartString
    
    /// Apply a link type effect and make the url tappable using a Closure.
    /// - Parameter closure: The closure which must return the URL to open using the default browser.
    /// - Returns: The new SmartString instance.
    func link(closure: () -> URL) -> SmartString
    
    // MARK: - Image
    
    /// Append an Image of a given height to the string.
    /// - Parameters:
    ///   - image: The image to append
    ///   - height: The image height to use. Default is 18.
    /// - Returns: The new SmartString instance.
    func appendImage(_ image: UIImage, height: CGFloat) -> SmartString
    
    /// Append an Image of a given height to the string using a Closure
    /// - Parameters:
    ///   - height: The image height to use. Default is 18.
    ///   - closure: The closure which must return the Image to append.
    /// - Returns: The new SmartString instance.
    func appendImage(height: CGFloat, closure: () -> UIImage) -> SmartString
    
    // MARK: - Tap Handler
    
    /// Add Tap Geture to the SmartString object.
    /// - Parameter closure: The closure called when user tap on the string.
    /// - Returns: The new SmartString instance.
    func onTap(closure: @escaping (String) -> Void) -> SmartString
}
