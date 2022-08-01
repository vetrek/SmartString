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

    func style(_ style: SmartStringStyle) -> SmartString
    
    // MARK: - Color
    
    func color(_ color: UIColor) -> SmartString
    func color(closure: () -> UIColor) -> SmartString
    
    func background(_ color: UIColor) -> SmartString
    func background(closure: () -> UIColor) -> SmartString
    
    // MARK: - Font

    func font(_ font: UIFont) -> SmartString
    func font(closure: () -> UIFont) -> SmartString
    
    func bold() -> SmartString
    
    func underline() -> SmartString
    
    func italic() -> SmartString
    
    // MARK: - Shadow
    
    func shadow(_ shadow: SmartShadow) -> SmartString
    func shadow(closure: () -> SmartShadow) -> SmartString
    
    // MARK: - Link
    
    func link(_ url: URL) -> SmartString
    func link(closure: () -> URL) -> SmartString
    
    // MARK: - Image
    func appendImage(_ image: UIImage, height: CGFloat) -> SmartString
    func appendImage(height: CGFloat, closure: () -> UIImage) -> SmartString
    
    // MARK: - Tap Handler
    
    func onTap(closure: @escaping (String) -> Void) -> SmartString
}
