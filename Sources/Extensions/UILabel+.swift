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

public extension UILabel {
  
  private static let smartString = AssociatedObject<SmartString>()
  
  var smartString: SmartString? {
    get {
      UILabel.smartString[self]
    }
    set {
      attributedText = newValue?.attributedText
      UILabel.smartString[self] = newValue
      
      guard
        let smartString = smartString,
        !smartString.tappableRanges.isEmpty
      else { return }
      
      isUserInteractionEnabled = true
      addGestureRecognizer(
        UITapGestureRecognizer(
          target: newValue,
          action: #selector(smartString.labelDidTap)
        )
      )
    }
  }
  
  var flushFactor: CGFloat {
    switch textAlignment {
    case .center:
      return 0.5
    case .right:
      return 1.0
    default:
      return 0.0
    }
  }
  
}
