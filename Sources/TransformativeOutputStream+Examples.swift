//  Copyright © 2020 Erica Sadun. All rights reserved.

import Foundation

public extension TransformativeOutputStream {
    /// Ascii transformation
    static var ascii = TransformativeOutputStream({ string in
        let items = string.unicodeScalars.map({ char in
            char == "\n" ? "\n" : char.escaped(asASCII: true)
        })
        return items.joined()
    })
    
    /// Italian translation
    static var italian = TransformativeOutputStream({ string in
        if let translated = Translate.translate(string, to: "it") {
            return translated
        }
        return string
    })
}

enum Translate {
    /// Translates a string from English to a destination language
    /// - Caution: Bring your own implementation. Do not use this one.
    fileprivate static func translate(_ string: String, from sourceLanguage: String = "en", to language: String) -> String?
    {
        guard
            !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            let escaped = string.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            else  { return nil }
        
        // Caution. For sample use only. Do not use in production code or for any purpose
        // other than to demonstrate a streaming transformation.
        let requestString = "https://translate.googleapis.com/"
            + "translate_a/single?client=gtx&sl=\(sourceLanguage)"
            + "&tl=\(language)&dt=t&q=\(escaped)"
        
        guard
            let url = URL(string: requestString),
            let data = try? Utility.requestSynchronousData(URLRequest(url: url)),
            let rawstring = String(data: data, encoding: .utf8)
            else { return nil }
        
        // Don't look at this code. Your eyes will bleed.
        // Sample return data:
        // ```
        // [[["Ciao","hello",null,null,1]
        // ]
        // ,null,"en",null,null,null,null,[]
        // ]
        // ```
        let components = String(rawstring.dropFirst(4))
            .components(separatedBy: CharacterSet(charactersIn: "\""))
        return components[0]
    }
}
