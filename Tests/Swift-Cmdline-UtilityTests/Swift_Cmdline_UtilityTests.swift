import XCTest
@testable import Swift_Cmdline_Utility

final class Swift_Cmdline_UtilityTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Swift_Cmdline_Utility().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
