//  Copyright © 2020 Erica Sadun. All rights reserved.

import Foundation

/// Enables fluent side-effects by inserting passthrough into
/// call chains
public protocol Peekable {}

extension Peekable {
    /// Passes-through the instance with customizable side effects
    /// - Parameter closure: a side effect to apply to the current instance, such as printing.
    /// - Returns: the unaltered instance
    public func passthrough(applying closure: (_ instance: Self) -> ()) -> Self {
        closure(self)
        return self
    }
}
