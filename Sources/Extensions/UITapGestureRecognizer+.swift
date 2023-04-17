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

extension UITapGestureRecognizer {
  /// Detect if the Label tap was within the specified Range
  func didTapAttributedTextInLabel(
    label: UILabel,
    inRange targetRange: NSRange
  ) -> Bool {
    let point = location(in: label)
    
    guard
      let font = label.font,
      let attributedText = label.attributedText,
      label.bounds.contains(point)
    else { return false }
    
    let txtRect = label.textRect(
      forBounds: label.bounds,
      limitedToNumberOfLines: label.numberOfLines
    )
    guard txtRect.contains(point) else { return false }
    
    var relativePoint = CGPoint(
      x: point.x - txtRect.origin.x,
      y: point.y - txtRect.origin.y
    )
    relativePoint = CGPoint(
      x: relativePoint.x,
      y: txtRect.size.height - relativePoint.y
    )
    
    print("Relative point", relativePoint)
    // --
    
    let attStr = NSMutableAttributedString(attributedString: attributedText)
    attStr.enumerateAttribute(
      .font,
      in: NSRange(location: 0, length: attStr.length),
      options: [],
      using: { value, range, _ in
        if value == nil {
          attStr.addAttribute(
            .font,
            value: font,
            range: range
          )
        }
      }
    )
    
    let frameSetter = CTFramesetterCreateWithAttributedString(attStr as CFAttributedString)
    let path = UIBezierPath(
      rect: CGRect(
        x: 0,
        y: 0,
        width: txtRect.size.width,
        height: attStr.computeStringHeight(width: txtRect.size.width)
      )
    )
    let frame = CTFramesetterCreateFrame(
      frameSetter,
      CFRangeMake(0, attStr.length),
      path.cgPath,
      nil
    )
    
    guard let lines = CTFrameGetLines(frame) as? [CTLine] else {
      return false
    }
    
    // --
    
    let lineCount = label.numberOfLines > 0 ? min(label.numberOfLines, lines.count) : lines.count
    guard lineCount > 0 else {
      return false
    }
    
    var index = NSNotFound
    var lineOrigins: [CGPoint] = .init(repeating: .zero, count: lineCount)
    CTFrameGetLineOrigins(frame, CFRange(location: 0, length: lineCount), &lineOrigins)
    
    for lineIndex in 0..<lineOrigins.count {
      var lineOrigin = lineOrigins[lineIndex]
      let line = lines[lineIndex]
      var ascent: CGFloat = 0.0
      var descent: CGFloat = 0.0
      var leading: CGFloat = 0.0
      
      let width = CGFloat(CTLineGetTypographicBounds(line, &ascent, &descent, &leading))
      let yMin = ceil(lineOrigin.y - descent)
      let yMax = floor(lineOrigin.y + ascent)
      
      let penOffset = CGFloat(CTLineGetPenOffsetForFlush(line, label.flushFactor, Double(txtRect.width)))
      lineOrigin.x = penOffset
      
      // if we've already passed the point, stop
      guard relativePoint.y <= yMax else {
        break
      }
      
      guard relativePoint.y >= yMin,
            relativePoint.x >= lineOrigin.x && relativePoint.x <= lineOrigin.x + width
      else { continue }
      
      let position = CGPoint(x: relativePoint.x - lineOrigin.x, y: relativePoint.y - lineOrigin.y)
      index = CTLineGetStringIndexForPosition(line, position)
      break
    }
    
    return NSLocationInRange(index, targetRange)
  }
}
