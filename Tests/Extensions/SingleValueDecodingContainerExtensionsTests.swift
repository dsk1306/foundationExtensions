@testable import FoundationExtensions
import XCTest

final class SingleValueDecodingContainerExtensionsTests: XCTestCase {

    // MARK: - Tests - Decode Collection Safely

    func test_decodeCollectionSafely_success() throws {
        let decoded = try Self.decode(type: MockCollectionSafelyModel.self, from: Mock.collectionJSON1)

        XCTAssertEqual(decoded.array, Mock.collection1)
    }

    func test_decodeCollectionSafely_partialSuccess() throws {
        let decoded = try Self.decode(type: MockCollectionSafelyModel.self, from: Mock.collectionJSON2)

        XCTAssertEqual(decoded.array, Mock.collection2)
    }

    func test_decodeCollectionSafely_fail() {
        XCTAssertThrowsError(try Self.decode(type: MockCollectionSafelyModel.self, from: Mock.collectionWrongJSON1))
    }

    // MARK: - Tests - Decode Not Empty String

    func test_decodeNotEmptyString_success() throws {
        let decoded = try Self.decode(type: MockNotEmptyStringModel.self, from: Mock.stringJSON)

        XCTAssertEqual(decoded.string, Mock.stringJSONFirstString)
    }

    func test_decodeNotEmptyString_fail() {
        XCTAssertThrowsError(try Self.decode(type: MockNotEmptyStringModel.self, from: Mock.stringWrongJSON1))
        XCTAssertThrowsError(try Self.decode(type: MockNotEmptyStringModel.self, from: Mock.stringWrongJSON2))
        XCTAssertThrowsError(try Self.decode(type: MockNotEmptyStringModel.self, from: Mock.stringWrongJSON3))
        XCTAssertThrowsError(try Self.decode(type: MockNotEmptyStringModel.self, from: Mock.stringWrongJSON4))
    }

    // MARK: - Tests - Decode ISO8601 Date

    func test_decodeISO8601Date_success() throws {
        let decoded = try Self.decode(type: MockISO8601DateModel.self, from: Mock.dateJSON)

        XCTAssertEqual(decoded.date, Mock.dateJSONFirstDate)
    }

    func test_decodeISO8601Date_fail() {
        XCTAssertThrowsError(try Self.decode(type: MockISO8601DateModel.self, from: Mock.dateWrongJSON1))
        XCTAssertThrowsError(try Self.decode(type: MockISO8601DateModel.self, from: Mock.dateWrongJSON2))
    }

}

// MARK: - Helpers

private extension SingleValueDecodingContainerExtensionsTests {

    static func decode<Base: Decodable>(type: Base.Type, from json: String) throws -> Base {
        guard let data = json.data(using: .utf8) else {
            throw TestError.nilData
        }
        return try JSONDecoder().decode(Base.self, from: data)
    }

}

// MARK: - Mock

private extension SingleValueDecodingContainerExtensionsTests {

    enum Mock {

        static let collectionJSON1 = #" [1,2,3,4,5,6,7,8,9] "#
        static let collectionJSON2 = #" [1,2,3,"some",5,6,7,[1,2,3],9] "#
        static let collectionWrongJSON1 = #" "some" "#

        static let collection1 = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        static let collection2 = [1, 2, 3, 5, 6, 7, 9]

        static let stringJSON = #" "First String Value" "#
        static let stringWrongJSON1 = #" { "firstString": "First String Value", "secondString": "Second String Value" } "#
        static let stringWrongJSON2 = #" "" "#
        static let stringWrongJSON3 = #" 1 "#
        static let stringWrongJSON4 = #" false "#

        static let stringJSONFirstString = "First String Value"

        static let dateJSON = #" "2020-06-12T18:15:56Z" "#

        static let dateWrongJSON1 = #" { "firstDate": "2020-06-12T18:15:56Z" } "#
        static let dateWrongJSON2 = #" "2002-12-12 09:35:56 +0000" "#

        static let dateJSONFirstDate = Date(timeIntervalSinceReferenceDate: 613678556)
        static let dateJSONSecondDate = Date(timeIntervalSinceReferenceDate: 61378556)

    }

}

// MARK: - Test Error

private extension SingleValueDecodingContainerExtensionsTests {

    enum TestError: Error {

        case nilData

    }

}

// MARK: - Mock Collection Safely Model

private extension SingleValueDecodingContainerExtensionsTests {

    struct MockCollectionSafelyModel: Decodable {

        let array: [Int]

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            array = try container.decodeCollectionSafely()
        }

    }

}

// MARK: - Mock Not Empty String Model

private extension SingleValueDecodingContainerExtensionsTests {

    struct MockNotEmptyStringModel: Decodable {

        let string: String

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            string = try container.decodeNotEmptyString()
        }

    }

}

// MARK: - Mock ISO8601 Date Model

private extension SingleValueDecodingContainerExtensionsTests {

    struct MockISO8601DateModel: Decodable {

        let date: Date

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            date = try container.decodeISO8601DateString()
        }

    }

}
