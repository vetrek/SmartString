//
//  File.swift
//
//  Copyright (c) 2021 Vetrek (valerio.alsebas@gmail.com)
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

extension String {
    var escaped: String {
        let charactersToEscape = [
            ["&", "&amp;"],
            ["<", "&lt;"],
            [">", "&gt;"],
            ["\"", "&quot;"],
            ["'", "&#39;"],
        ]
        return charactersToEscape.reduce(self) {
            $0.replacingOccurrences(of: $1[0], with: $1[1], options: .literal, range: nil)
        }
    }
}


// MARK: - XMLStringParserError
struct XMLStringParserError: Error {
    public let parserError: Error
    public let line: Int
    public let column: Int
}

// MARK: - XMLStringParser
class XMLStringParser: NSObject, XMLParserDelegate {
    
    // MARK: Private Properties
    private static let rootTag = "root"
    
    /// Parser engine.
    private var xmlParser: XMLParser
    
    /// Flag which indicates if we add a defualt <root> tag to the string
    /// Default to true
    private var useRootTag: Bool
    
    /// Final SmartString
    private var smartString = SmartString()
    
    private var styles: [SmartStringStyle] = []
    
    // The XML parser sometimes splits strings, which can break localization-sensitive
    // string transforms. Work around this by using the currentString variable to
    // accumulate partial strings, and then reading them back out as a single string
    // when the current element ends, or when a new one is started.
    var currentString: String?
    
    // MARK: - Initialization
    public init(string: String, useRootTag: Bool = true) {
        
        //        let xmlString = string.escaped
        //        let xml = (styleXML.xmlParsingOptions.contains(.doNotWrapXML) ? xmlString : "<\(XMLStringBuilder.topTag)>\(xmlString)</\(XMLStringBuilder.topTag)>")
        let xml = "<\(XMLStringParser.rootTag)>\(string)</\(XMLStringParser.rootTag)>"
        guard let data = xml.data(using: String.Encoding.utf8) else {
            fatalError("Unable to convert to UTF8")
        }
        
        self.useRootTag = useRootTag
        self.xmlParser = XMLParser(data: data)
        
        super.init()
        
        xmlParser.shouldProcessNamespaces = false
        xmlParser.shouldReportNamespacePrefixes = false
        xmlParser.shouldResolveExternalEntities = false
        xmlParser.delegate = self
    }
    
    /// Parse and generate attributed string.
    public func parse() throws -> SmartString {
        guard xmlParser.parse() else {
            let line = xmlParser.lineNumber
            let shiftColumn = line == 1
            let shiftSize = XMLStringParser.rootTag.lengthOfBytes(using: String.Encoding.utf8) + 2
            let column = xmlParser.columnNumber - (shiftColumn ? shiftSize : 0)
            
            throw XMLStringParserError(parserError: xmlParser.parserError!, line: line, column: column)
        }
        
        return smartString
    }
    
    // MARK: XMLParserDelegate
    
    @objc public func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String: String]
    ) {
        styleNewString()
        guard
            elementName != XMLStringParser.rootTag,
            let style = SmartStringXMLStyles[element: elementName]
        else {
            return
        }
        styles.append(style)
    }
    
    @objc public func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        styleNewString()
        guard elementName != XMLStringParser.rootTag else {
            return
        }
        
        styles.removeLast()
    }
    
    @objc public func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentString = (currentString ?? "").appending(string)
    }
    
    // MARK: Private Methods
    
    func styleNewString() {
        guard currentString?.isEmpty == false else { return }
        smartString += styles.reduce(into: SmartString(string: currentString ?? "", hasXML: false)) {
            $0.style($1)
        }
        currentString = nil
    }
    
}
