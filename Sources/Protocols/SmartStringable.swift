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
    
    func background(_ color: UIColor) -> SmartString
    func background(closure: () -> UIColor) -> SmartString
    
    // MARK: - Font

    func font(_ font: UIFont) -> SmartString
    func font(closure: () -> UIFont) -> SmartString
    
    func bold() -> SmartString
    
    func underline() -> SmartString
    
    func italic() -> SmartString
    
    // MARK: - Shadow
    
    func shadow(_ shadow: SmartShadow) -> SmartString
    func shadow(closure: () -> SmartShadow) -> SmartString
    
    // MARK: - Link
    
    func link(_ url: URL) -> SmartString
    func link(closure: () -> URL) -> SmartString
    
    // MARK: - Tap Handler
    func onTap(closure: @escaping (String) -> Void) -> SmartString
}
