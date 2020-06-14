//  Copyright © 2020 Erica Sadun. All rights reserved.

import Foundation

/// A wrapper to convert an `UnsafeMutablePointer<FILE>` to a `TextOutputStream`
///
/// Supply your own file pointer or use the provided `stderr` and `stdout`. For example:
///
/// ```
/// print(err, to: &OutputStream.stderr)
/// ```
public class OutputStream: TextOutputStream {
    /// Wraps the provided stream to conform to `TextOutputStream`
    public init(_ outputStream: UnsafeMutablePointer<FILE>) {
        self.outputStream = outputStream
    }
    
    /// Wraps a file path to convorm to `TextOutputStream`
    public init?(filePath: String, append: Bool = false) {
        #if canImport(Darwin)
        // Cocoa platforms only. No Linux
        let filePath = (filePath as NSString).expandingTildeInPath
        #endif
        fflush(Foundation.stdout)
        self.filePath = filePath
        outputStream = append ? fopen(filePath, "a") : fopen(filePath, "w")
    }
    
    /// Conform to `TextOutputStream` by writing to an `UnsafeMutablePointer<FILE>`
    public func write(_ string: String) { fputs(string, outputStream) }
    
    /// `stderr` affordance
    public static var stderr = OutputStream(Foundation.stderr)
    
    /// `stdout` affordance
    public static var stdout = OutputStream(Foundation.stdin)
    
    /// Wrapped output stream for writing
    private let outputStream: UnsafeMutablePointer<FILE>
    
    /// Output path if used
    var filePath: String?
    
    // Clean up open FILE
    deinit { if filePath != nil { fclose(outputStream)} }
}
