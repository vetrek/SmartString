//
//  File.swift
//  
//
//  Created by Valerio Sebastianelli on 2/4/22.
//

import Foundation
import UIKit

public protocol SmartStringable {
    // MARK: - Style

    func style(_ style: SmartStringStyle) -> SmartString
    
    // MARK: - Color
    
    func color(_ color: UIColor) -> SmartString
    
    func color(closure: () -> UIColor) -> SmartString
    
    // MARK: - Font

    func font(_ font: UIFont) -> SmartString
    
    func font(closure: () -> UIFont) -> SmartString
    
    func toBold() -> SmartString
    
    // MARK: - Shadow
    
    func shadow(_ shadow: SmartShadow) -> SmartString
    
    func shadow(closure: () -> SmartShadow) -> SmartString
}
