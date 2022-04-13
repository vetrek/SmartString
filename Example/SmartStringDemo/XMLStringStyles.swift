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
    case body
    case subtitle
    
    var style: SmartStringStyle {
        switch self {
        case .primary:
            return SmartStringStyle { style in
                style.font = .boldSystemFont(ofSize: 24)
                style.color = .blue
                style.link = URL(string: "https://google.com")
            }
        case .secondary:
            return SmartStringStyle { style in
                style.font = .boldSystemFont(ofSize: 24)
                style.color = .black
                style.backgroundColor = .systemPink
            }
        case .body:
            return SmartStringStyle { style in
                style.font = .italicSystemFont(ofSize: 16)
            }
        case .subtitle:
            return SmartStringStyle { style in
                style.font = .italicSystemFont(ofSize: 16)
            }
        }
    }
    
    static func setXmlSmartStringStyles() {
        XMLStrinStyles.allCases.forEach {
            SmartStringXMLStyles.styles[$0.rawValue] = $0.style
        }
    }
}

extension String {
    func tagged(with style: XMLStrinStyles) -> String {
        "<\(style.rawValue)>...\(style.rawValue)"
    }
    
    var title: SmartString {
        style(XMLStrinStyles.body.style)
    }
}
