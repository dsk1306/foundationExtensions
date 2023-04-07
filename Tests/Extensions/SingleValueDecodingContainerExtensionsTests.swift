@testable import FoundationExtensions
import XCTest

final class SingleValueDecodingContainerExtensionsTests: XCTestCase {

    // MARK: - Tests - Decode Collection Safely

    func test_decodeCollectionSafely_success() throws {
        let decoded = try decode(
            type: CollectionSafelyModel.self,
            from: Mock.collectionJSON1
        )

        XCTAssertEqual(decoded.array, Mock.collection1)
    }

    func test_decodeCollectionSafely_partialSuccess() throws {
        let decoded = try decode(
            type: CollectionSafelyModel.self,
            from: Mock.collectionJSON2
        )

        XCTAssertEqual(decoded.array, Mock.collection2)
    }

    func test_decodeCollectionSafely_fail() {
        XCTAssertThrowsError(try decode(
            type: CollectionSafelyModel.self,
            from: Mock.collectionWrongJSON
        ))
    }

    // MARK: - Tests - Decode Not Empty String

    func test_decodeNotEmptyString_success() throws {
        let decoded = try decode(
            type: NotEmptyStringModel.self,
            from: Mock.stringJSON
        )

        XCTAssertEqual(decoded.string, Mock.stringJSONFirstString)
    }

    func test_decodeNotEmptyString_fail() {
        XCTAssertThrowsError(try decode(
            type: NotEmptyStringModel.self,
            from: Mock.stringWrongJSON1
        ))
        XCTAssertThrowsError(try decode(
            type: NotEmptyStringModel.self,
            from: Mock.stringWrongJSON2
        ))
        XCTAssertThrowsError(try decode(
            type: NotEmptyStringModel.self,
            from: Mock.stringWrongJSON3
        ))
        XCTAssertThrowsError(try decode(
            type: NotEmptyStringModel.self,
            from: Mock.stringWrongJSON4
        ))
    }

    // MARK: - Tests - Decode ISO8601 Date

    func test_decodeISO8601DateString_success() throws {
        let decoded = try decode(
            type: ISO8601DateStringModel.self,
            from: Mock.dateJSON
        )

        XCTAssertEqual(decoded.date, Mock.dateJSONFirstDate)
    }

    func test_decodeISO8601DateString_fail() {
        XCTAssertThrowsError(try decode(
            type: ISO8601DateStringModel.self,
            from: Mock.dateWrongJSON1
        ))
        XCTAssertThrowsError(try decode(
            type: ISO8601DateStringModel.self,
            from: Mock.dateWrongJSON2
        ))
    }

}

// MARK: - Helpers

private extension SingleValueDecodingContainerExtensionsTests {

    func decode<Base: Decodable>(type: Base.Type, from json: String) throws -> Base {
        guard let data = json.data(using: .utf8) else {
            throw TestError.stringToData
        }
        return try JSONDecoder().decode(Base.self, from: data)
    }

}

// MARK: - Mock

private extension SingleValueDecodingContainerExtensionsTests {

    enum Mock {

        static let collectionJSON1 = #" [1,2,3,4,5,6,7,8,9] "#
        static let collectionJSON2 = #" [1,2,3,"some",5,6,7,[1,2,3],9] "#
        static let collectionWrongJSON = #" "some" "#

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

// MARK: - Collection Safely Model

private extension SingleValueDecodingContainerExtensionsTests {

    struct CollectionSafelyModel: Decodable {

        let array: [Int]

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            array = try container.decodeCollectionSafely()
        }

    }

}

// MARK: - Not Empty String Model

private extension SingleValueDecodingContainerExtensionsTests {

    struct NotEmptyStringModel: Decodable {

        let string: String

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            string = try container.decodeNotEmptyString()
        }

    }

}

// MARK: - ISO8601 Date String Model

private extension SingleValueDecodingContainerExtensionsTests {

    struct ISO8601DateStringModel: Decodable {

        let date: Date

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            date = try container.decodeISO8601DateString()
        }

    }

}
