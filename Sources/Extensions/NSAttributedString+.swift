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

public extension NSAttributedString {
    var smartString: SmartString {
        SmartString(attributedString: self)
    }
}

extension NSAttributedString {
    func computeStringHeight(width: CGFloat) -> CGFloat {
        var height: CGFloat = 0
        // Create the framesetter with the attributed string.
        let framesetter = CTFramesetterCreateWithAttributedString(self as CFAttributedString)
        
        let path = UIBezierPath(
            rect: CGRect(
                x: 0,
                y: 0,
                width: width,
                height: .greatestFiniteMagnitude
            )
        )
        
        // Create a frame for this column and draw it.
        let frame = CTFramesetterCreateFrame(
            framesetter,
            CFRangeMake(0, length),
            path.cgPath,
            nil
        )
        
        let lines = CTFrameGetLines(frame)
        let lineCount = CFArrayGetCount(lines)
        
        var h: CGFloat = 0
        var ascent: CGFloat = 0
        var descent: CGFloat = 0
        var leading: CGFloat = 0
        
        for index in 0..<lineCount {
            let currentLine = unsafeBitCast(CFArrayGetValueAtIndex(lines, index), to: CTLine.self)
            CTLineGetTypographicBounds(currentLine, &ascent, &descent, &leading)
            h = ascent + descent + leading;
            height += h
        }
        
        return height + 1
    }
}
