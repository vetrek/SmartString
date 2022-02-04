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
    
    // MARK: - Font
    
    public func font(_ font: UIFont) -> SmartString {
        SmartString(string: self).font(font)
    }
    
    public func font(closure: () -> UIFont) -> SmartString {
        SmartString(string: self).font(closure: closure)
    }
    
    public func toBold() -> SmartString {
        SmartString(string: self).toBold()
    }
    
    // MARK: - Shadow
    
    public func shadow(_ shadow: SmartShadow) -> SmartString {
        SmartString(string: self).shadow(shadow)
    }
    
    public func shadow(closure: () -> SmartShadow) -> SmartString {
        SmartString(string: self).shadow(closure: closure)
    }

}

// MARK: - Public Helpers

public extension String {
    static func + (lhs: String, rhs: SmartString) -> SmartString {
        SmartString(string: lhs)
    }
}
