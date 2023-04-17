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

import UIKit

// MARK: - Public Properties

public extension String {
  var smartString: SmartString {
    SmartString(string: self)
  }
  
  var smartStringXML: SmartString {
    SmartString(string: self, hasXML: true)
  }
  
  func tag<T>(_ tag: T) -> String where T: RawRepresentable, T.RawValue == String {
    "<\(tag.rawValue)>\(self)</\(tag.rawValue)>"
  }
}

// MARK: - Public Methods

extension String: SmartStringable {
  
  // MARK: - Style
  
  public func style(_ smartStyle: SmartStringStyle) -> SmartString {
    SmartString(string: self).style(smartStyle)
  }
  
  public func align(_ alignment: NSTextAlignment) -> SmartString {
    SmartString(string: self).align(alignment)
  }
  
  public func lineSpacing(_ lineSpacing: CGFloat) -> SmartString {
    SmartString(string: self).lineSpacing(lineSpacing)
  }
  
  public func lineHeight(_ height: CGFloat) -> SmartString {
    SmartString(string: self).lineHeight(height)
  }
   
  public func charactersSpacing(_ space: CGFloat) -> SmartString {
    SmartString(string: self).charactersSpacing(space)
  }
  
  // MARK: - Color
  
  public func color(_ color: UIColor) -> SmartString {
    SmartString(string: self).color(color)
  }
  
  public func color(closure: () -> UIColor) -> SmartString {
    SmartString(string: self).color(closure: closure)
  }
  
  public func background(_ color: UIColor) -> SmartString {
    SmartString(string: self).background(color)
  }
  
  public func background(closure: () -> UIColor) -> SmartString {
    SmartString(string: self).background(closure: closure)
  }
  
  // MARK: - Font
  
  public func font(_ font: UIFont) -> SmartString {
    SmartString(string: self).font(font)
  }
  
  public func font(closure: () -> UIFont) -> SmartString {
    SmartString(string: self).font(closure: closure)
  }
  
  public func bold() -> SmartString {
    SmartString(string: self).bold()
  }
  
  public func underline() -> SmartString {
    SmartString(string: self).underline()
  }
  
  public func italic() -> SmartString {
    SmartString(string: self).italic()
  }
  
  // MARK: - Shadow
  
  public func shadow(_ shadow: SmartShadow) -> SmartString {
    SmartString(string: self).shadow(shadow)
  }
  
  public func shadow(closure: () -> SmartShadow) -> SmartString {
    SmartString(string: self).shadow(closure: closure)
  }
  
  // MARK: - Link
  
  public func link(_ url: URL) -> SmartString {
    SmartString(string: self).link(url)
  }
  
  public func link(closure: () -> URL) -> SmartString {
    SmartString(string: self).link(closure: closure)
  }
  
  // MARK: - Image
  
  public func appendImage(_ image: UIImage, height: CGFloat = 18) -> SmartString {
    SmartString(string: self).appendImage(image, height: height)
  }
  
  public func appendImage(height: CGFloat, closure: () -> UIImage) -> SmartString {
    SmartString(string: self).appendImage(height: height, closure: closure)
  }
  
  // MARK: - Tap Handler
  
  public func onTap(closure: @escaping (String) -> Void) -> SmartString {
    SmartString(string: self).onTap(closure: closure)
  }
  
}

// MARK: - Public Helpers

public extension String {
  static func + (lhs: String, rhs: SmartString) -> SmartString {
    SmartString(string: lhs) + rhs
  }
}

extension String {
  /// Safely subscript string within a given range.
  ///
  ///        "Hello World!"[safe: 6..<11] -> "World"
  ///        "Hello World!"[safe: 21..<110] -> nil
  ///
  ///        "Hello World!"[safe: 6...11] -> "World!"
  ///        "Hello World!"[safe: 21...110] -> nil
  ///
  /// - Parameter range: Range expression.
  subscript<R>(safe range: R) -> String? where R: RangeExpression, R.Bound == Int {
    let range = range.relative(to: Int.min..<Int.max)
    guard range.lowerBound >= 0,
          let lowerIndex = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex),
          let upperIndex = index(startIndex, offsetBy: range.upperBound, limitedBy: endIndex) else {
      return nil
    }
    
    return String(self[lowerIndex..<upperIndex])
  }
}
