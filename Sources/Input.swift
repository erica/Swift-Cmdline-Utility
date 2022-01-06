//  Copyright © 2022 Erica Sadun. All rights reserved.

import Foundation
import GeneralUtility

extension Utility {
    /// Returns the complete contents of stdin passed to the utility using
    /// Swift's built-in `readLine`
    public static func contentsOfStdin() -> String {
        var input: String = ""
        while let line = readLine() {
            if !input.isEmpty { input += "\n" }
            input += line
        }
        return input
    }
}
