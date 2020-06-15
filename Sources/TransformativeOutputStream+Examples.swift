//  Copyright © 2020 Erica Sadun. All rights reserved.

import Foundation
import GeneralUtility

public extension TransformativeOutputStream {
    /// Passthrough
    static let passthrough = TransformativeOutputStream({ $0 })
    
    /// Ascii transformation
    static var ascii = TransformativeOutputStream({ string in
        let items = string.unicodeScalars.map({ char in
            char == "\n" ? "\n" : char.escaped(asASCII: true)
        })
        return items.joined()
    })
    
    /// Constructs an instance that translates to another language
    ///
    /// Example:
    ///
    /// ```
    /// var german = TransformativeOutputStream.translating(to: "de")
    /// print("\"I am a jelly donut.\"", to: &german)
    /// ```
    /// - Parameter countryCode: a 2-character country code suitable for communicating with Google
    /// - Returns: A translated string or the original when translation fails
    static func translating(to countryCode: String) -> Self {
        guard !countryCode.isEmpty
            else { return TransformativeOutputStream.passthrough }
        return TransformativeOutputStream({ string in
            if let translated = Translate.translate(string, to: countryCode) {
                return translated
            }
            return string
        })
    }
    
    /// Italian translation
    static var italian = Self.translating(to: "it")
}

public enum Translate {
    /// Translates a string from English to a destination language
    ///
    /// - Caution: Bring your own implementation. Do not use this one. This one is bad.
    public static func translate(_ string: String, from sourceLanguage: String = "en", to language: String) -> String?
    {
        let replacement = "__"
        let noquotes = string.replacingOccurrences(of: "\"", with: replacement)
        
        guard
            !noquotes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            let escaped = noquotes.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
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
        return components[0].replacingOccurrences(of: replacement, with: "\"")
    }
}
