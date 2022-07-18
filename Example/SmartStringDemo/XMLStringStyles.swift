//
//  XMLStringStyles.swift
//
//  Copyright (c) 2021 Valerio69 (valerio.alsebas@gmail.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import SmartString

enum XMLStringStyles: String, CaseIterable {
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
        XMLStringStyles.allCases.forEach {
            SmartStringXMLStyles.styles[$0.rawValue] = $0.style
        }
    }
}

extension String {
    func tag(with style: XMLStringStyles) -> String {
        tag(style)
    }
    
    var title: SmartString {
        style(XMLStringStyles.body.style)
    }
}
