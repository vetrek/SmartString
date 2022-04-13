//
//  File.swift
//  
//
//  Created by Valerio Sebastianelli on 3/26/22.
//

import Foundation

public enum SmartStringXMLStyles {
    public static var styles: [String: SmartStringStyle] = [:]
    
    static subscript(element tag: String) -> SmartStringStyle? {
        return Self.styles[tag]
    }
}
