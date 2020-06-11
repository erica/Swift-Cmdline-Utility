//  Copyright © 2020 Erica Sadun. All rights reserved.
//
// Hat tips to:
// https://viewsourcecode.org/snaptoken/kilo/02.enteringRawMode.html
// https://stackoverflow.com/questions/49748507/listening-to-stdin-in-swift

import Foundation
import Darwin

/// Raw mode handling for character-by-character input in term
public enum RawMode {
    /// Error states for raw mode entry
    public enum State: Error {
        case eof
    }
    
    /// Enable raw mode for user input
    public static func enableRawMode(fileHandle: FileHandle) -> termios {
        let pointer = UnsafeMutablePointer<termios>.allocate(capacity: 1)
            defer { pointer.deallocate() }
        var raw = pointer.pointee
        tcgetattr(fileHandle.fileDescriptor, &raw)
        let original = raw
        raw.c_lflag &= ~(UInt(ECHO | ICANON))
        tcsetattr(fileHandle.fileDescriptor, TCSAFLUSH, &raw)
        return original
    }
    
    /// Disable raw mode for user input
    public static func disableRawMode(fileHandle: FileHandle) {
        guard var term = term else { return }
        tcsetattr(fileHandle.fileDescriptor, TCSAFLUSH, &term);
        self.term = nil
    }
    
    /// The current termios
    private static var term: termios?
    
    /// Fetches a `UInt8` byte at a time.
    ///
    /// Will establish a new termios instance if one is not already available.
    ///
    /// - Returns: A single `UInt8` if available, otherwise `nil`
    /// - Throws: `State.eof` on receiving ^D
    public static func getByte() throws -> UInt8? {
        if nil == term {
            term = enableRawMode(fileHandle: FileHandle.standardInput)
        }
        var byte: UInt8 = 0
        guard read(FileHandle.standardInput.fileDescriptor, &byte, 1) == 1 else { return nil }
        if byte == 0x04 { throw State.eof }
        return byte
    }
}
