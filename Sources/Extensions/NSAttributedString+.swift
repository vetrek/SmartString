//
//  File.swift
//  
//
//  Created by Valerio Sebastianelli on 3/8/22.
//

import Foundation
import UIKit

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
