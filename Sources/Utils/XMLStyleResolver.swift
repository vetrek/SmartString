//
//  File.swift
//  
//
//  Created by Valerio Sebastianelli on 3/26/22.
//

import Foundation
import libxml2 

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
