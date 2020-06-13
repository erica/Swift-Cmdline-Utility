//  Copyright © 2020 Erica Sadun. All rights reserved.

import Foundation

/// A stream that transforms its content through a custom closure
public struct TransformativeOutputStream: TextOutputStream {
    
    init(_ closure: @escaping (String) -> String) {
        self.transformationClosure = closure
    }
    
    /// Conformance to `TextOutputStream`
    public func write(_ string: String) {
        print(transformationClosure(string))
    }

    /// A transforming closure
    private let transformationClosure: (String) -> String
}
