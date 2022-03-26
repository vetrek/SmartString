//
//  File.swift
//  
//
//  Created by Valerio Sebastianelli on 3/24/22.
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
            let yMin = floor(lineOrigin.y - ascent)
            let yMax = ceil(lineOrigin.y + descent)
            
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
