@testable import FoundationExtensions
import XCTest

final class StringExtensionsTests: XCTestCase {

    // MARK: - Tests

    func test_trimmedOrNil() {
        let string1 = "String"
        let string2 = "String\n"
        let string3 = "\nString\n"
        let string4 = " String "
        let string5 = ""
        let string6 = "\n"

        XCTAssertEqual(string1, string1.trimmedOrNil)
        XCTAssertEqual(string1, string2.trimmedOrNil)
        XCTAssertEqual(string1, string3.trimmedOrNil)
        XCTAssertEqual(string1, string4.trimmedOrNil)
        XCTAssertNil(string5.trimmedOrNil)
        XCTAssertNil(string6.trimmedOrNil)
    }

}
