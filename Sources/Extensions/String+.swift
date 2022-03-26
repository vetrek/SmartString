//
//  File.swift
//  
//
//  Created by Valerio Sebastianelli on 2/3/22.
//

import Foundation
import UIKit

// MARK: - Public Properties

public extension String {
    var smartString: SmartString {
        SmartString(string: self)
    }
}

// MARK: - Public Methods

extension String: SmartStringable {
 
    // MARK: - Style
    
    public func style(_ smartStyle: SmartStringStyle) -> SmartString {
        SmartString(string: self).style(smartStyle)
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
    /// SwifterSwift: Safely subscript string within a given range.
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
