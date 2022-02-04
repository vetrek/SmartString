//
//  File.swift
//  
//
//  Created by Valerio Sebastianelli on 2/3/22.
//

import Foundation
import UIKit

public struct SmartShadow {
    public var offset: CGSize
    public var radius: CGFloat
    public var color: UIColor
    
    public init(
        offset: CGSize,
        radius: CGFloat,
        color: UIColor
    ) {
        self.offset = offset
        self.radius = radius
        self.color = color
    }
    
    func toNSShadow() -> NSShadow {
        let shadow = NSShadow()
        shadow.shadowOffset = offset
        shadow.shadowBlurRadius = radius
        shadow.shadowColor = color
        return shadow
    }
    
    public static var `default`: SmartShadow {
        .init(offset: .init(width: 1, height: 1), radius: 3, color: .black)
    }
}
