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
    public var backgroundColor: UIColor?
    public var font: UIFont?
    public var shadow: SmartShadow?
    public var link: URL?
    public var onTap: ((String) -> Void)?
    public var underlined: Bool = false
    
    public init(completion: (inout Self) -> Void) {
        var style = SmartStringStyle()
        completion(&style)
        self = style
    }
        
    init() { }
}
