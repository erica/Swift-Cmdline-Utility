import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Swift_Cmdline_UtilityTests.allTests),
    ]
}
#endif
