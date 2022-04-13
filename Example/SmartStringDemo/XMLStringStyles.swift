//
//  XMLStringStyles.swift
//  SmartStringDemo
//
//  Created by Valerio Sebastianelli on 4/11/22.
//

import Foundation
import SmartString

enum XMLStrinStyles: String, CaseIterable {
    case primary
    case secondary
    
    var style: SmartStringStyle{
        switch self {
        case .primary:
            return SmartStringStyle { style in
                style.font = .boldSystemFont(ofSize: 24)
                style.color = .white
            }
        case .secondary:
            return SmartStringStyle { style in
                style.font = .boldSystemFont(ofSize: 24)
                style.color = .black
                style.backgroundColor = .systemPink
            }
        }
    }
    
    static func setXmlSmartStringStyles() {
        XMLStrinStyles.allCases.forEach {
            SmartStringXMLStyles.styles[$0.rawValue] = $0.style
        }
    }
}
