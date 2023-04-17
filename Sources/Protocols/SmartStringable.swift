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
  
  /// Sets a SmartString style to the text.
  /// - Parameter style: A SmartStringStyle object.
  /// - Returns: A new SmartString instance with the applied style.
  func style(_ style: SmartStringStyle) -> SmartString
  
  /// Sets text alignment.
  /// - Parameter alignment: A NSTextAlignment value.
  /// - Returns: A new SmartString instance with the applied text alignment.
  func align(_ alignment: NSTextAlignment) -> SmartString
  
  /// Sets line spacing between text lines.
  /// - Parameter lineSpacing: A CGFloat value representing line spacing.
  /// - Returns: A new SmartString instance with the applied line spacing.
  func lineSpacing(_ lineSpacing: CGFloat) -> SmartString
  
  /// Sets a fixed line height for the text.
  /// - Parameter height: A CGFloat value representing line height.
  /// - Returns: A new SmartString instance with the applied line height.
  func lineHeight(_ height: CGFloat) -> SmartString
  
  /// Sets character spacing (kerning) for the text.
  /// - Parameter space: A CGFloat value representing character spacing.
  /// - Returns: A new SmartString instance with the applied character spacing.
  func charactersSpacing(_ space: CGFloat) -> SmartString
  
  // MARK: - Color
  
  /// Sets the text color.
  /// - Parameter color: A UIColor object representing the text color.
  /// - Returns: A new SmartString instance with the applied text color.
  func color(_ color: UIColor) -> SmartString
  
  /// Sets the text color using a closure.
  /// - Parameter closure: A closure that returns a UIColor object.
  /// - Returns: A new SmartString instance with the applied text color.
  func color(closure: () -> UIColor) -> SmartString
  
  /// Sets the background color of the text.
  /// - Parameter color: A UIColor object representing the background color.
  /// - Returns: A new SmartString instance with the applied background color.
  func background(_ color: UIColor) -> SmartString
  
  /// Sets the background color of the text using a closure.
  /// - Parameter closure: A closure that returns a UIColor object.
  /// - Returns: A new SmartString instance with the applied background color.
  func background(closure: () -> UIColor) -> SmartString
  
  // MARK: - Font
  
  /// Sets the font of the text.
  /// - Parameter font: A UIFont object representing the font.
  /// - Returns: A new SmartString instance with the applied font.
  func font(_ font: UIFont) -> SmartString
  
  /// Sets the font of the text using a closure.
  /// - Parameter closure: A closure that returns a UIFont object.
  /// - Returns: A new SmartString instance with the applied font.
  func font(closure: () -> UIFont) -> SmartString
  
  /// Applies a bold effect to the font. **Only works if a font was previously applied**
  /// - Returns: A new SmartString instance with the bold effect applied.
  func bold() -> SmartString
  
  /// Applies an underline effect to the text.
  /// - Returns: A new SmartString instance with the underline effect applied.
  func underline() -> SmartString
  
  /// Applies an italic effect to the font. **Only works if a font was previously applied**
  /// - Returns: A new SmartString instance with the italic effect applied.
  func italic() -> SmartString
  
  // MARK: - Shadow
  
  /// Applies a shadow to the text.
  /// - Parameter shadow: A SmartShadow object representing the shadow style.
  /// - Returns: A new SmartString instance with the applied shadow.
  func shadow(_ shadow: SmartShadow) -> SmartString
  
  /// Applies a shadow to the text using a closure.
  /// - Parameter closure: A closure that returns a SmartShadow object.
  /// - Returns: A new SmartString instance with the applied shadow.
  func shadow(closure: () -> SmartShadow) -> SmartString
  
  // MARK: - Link
  
  /// Applies a link effect to the text and makes it tappable.
  /// - Parameter url: The URL to be opened in the default browser.
  /// - Returns: A new SmartString instance with the link effect applied.
  func link(_ url: URL) -> SmartString
  
  /// Applies a link effect to the text and makes it tappable using a closure.
  /// - Parameter closure: A closure that returns the URL to be opened in the default browser.
  /// - Returns: A new SmartString instance with the link effect applied.
  func link(closure: () -> URL) -> SmartString
  
  // MARK: - Image
  
  /// Appends an image with a specified height to the text.
  /// - Parameters:
  /// - image: The UIImage object to be appended.
  /// - height: The height of the image (default is 18).
  /// - Returns: A new SmartString instance with the image appended.
  func appendImage(_ image: UIImage, height: CGFloat) -> SmartString
  
  /// Appends an image with a specified height to the text using a closure.
  /// - Parameters:
  /// - height: The height of the image (default is 18).
  /// - closure: A closure that returns the UIImage object to be appended.
  /// - Returns: A new SmartString instance with the image appended.
  func appendImage(height: CGFloat, closure: () -> UIImage) -> SmartString
  
  // MARK: - Tap Handler
  
  /// Adds a tap gesture to the SmartString object.
  /// - Parameter closure: A closure that is called when the user taps on the text. The closure takes a String parameter.
  /// - Returns: A new SmartString instance with the tap gesture added.
  func onTap(closure: @escaping (String) -> Void) -> SmartString
}
