//
//  File.swift
//  
//
//  Created by Valerio Sebastianelli on 2/3/22.
//

import Foundation
import UIKit

public struct SmartStringStyle {
    public var color: UIColor?
    public var font: UIFont?
    public var shadow: SmartShadow?
    
    public init(
        color: UIColor?,
        font: UIFont? = nil,
        shadow: SmartShadow? = nil
    ) {
        self.color = color
        self.font = font
        self.shadow = shadow
    }
    
    public init(
        font: UIFont?,
        color: UIColor? = nil,
        shadow: SmartShadow? = nil
    ) {
        self = .init(color: color, font: font, shadow: shadow)
    }
    
    public init(
        shadow: SmartShadow?,
        color: UIColor? = nil,
        font: UIFont? = nil
    ) {
        self = .init(color: color, font: font, shadow: shadow)
    }
}
