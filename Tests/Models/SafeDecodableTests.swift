@testable import FoundationExtensions
import XCTest

final class SafeDecodableTests: XCTestCase {

    // MARK: - Tests

    func test_value_success() throws {
        let json = #"{ "firstValue": "test1", "secondValue": "test2" }"#
        let decoded = try decodeValue(json: json)

        XCTAssertEqual(decoded?.firstValue, "test1")
        XCTAssertEqual(decoded?.secondValue, "test2")
    }

    func test_value_partialSuccess() throws {
        let json = #"{ "firstValue": "test1" }"#
        let decoded = try decodeValue(json: json)

        XCTAssertNil(decoded)
    }

    func test_value_fail() throws {
        let json = #" 1 "#
        let decoded = try decodeValue(json: json)

        XCTAssertNil(decoded)
    }

}

// MARK: - Helpers

private extension SafeDecodableTests {

    func decodeValue(json: String) throws -> MockModel? {
        guard let data = json.data(using: .utf8) else {
            throw TestError.stringToData
        }
        return try JSONDecoder().decode(SafeDecodable<MockModel>.self, from: data).value
    }

}

// MARK: - Mock Model

private extension SafeDecodableTests {

    struct MockModel: Decodable {

        let firstValue: String
        let secondValue: String

    }

}
