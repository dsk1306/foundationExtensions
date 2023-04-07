@testable import FoundationExtensions
import XCTest

final class KeyedDecodingContainerExtensionsTests: XCTestCase {

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
            from: Mock.collectionWrongJSON1
        ))
        XCTAssertThrowsError(try decode(
            type: CollectionSafelyModel.self,
            from: Mock.collectionWrongJSON2
        ))
    }

    // MARK: - Tests - Decode Collection Safely If Present

    func test_decodeCollectionSafelyIfPresent_success() throws {
        let decoded = try decode(
            type: CollectionSafelyIfPresentModel.self,
            from: Mock.collectionJSON1
        )

        XCTAssertEqual(decoded.array, Mock.collection1)
    }

    func test_decodeCollectionSafelyIfPresent_partialSuccess() throws {
        let decoded = try decode(
            type: CollectionSafelyIfPresentModel.self,
            from: Mock.collectionJSON2
        )

        XCTAssertEqual(decoded.array, Mock.collection2)
    }

    func test_decodeCollectionSafelyIfPresent_fail() throws {
        XCTAssertTrue(try decode(type: CollectionSafelyIfPresentModel.self, from: Mock.collectionWrongJSON2).array.isEmpty)
        XCTAssertThrowsError(try decode(
            type: CollectionSafelyIfPresentModel.self,
            from: Mock.collectionWrongJSON1
        ))
    }

    // MARK: - Tests - Decode Not Empty String

    func test_decodeNotEmptyString_success() throws {
        let decoded = try decode(
            type: NotEmptyStringModel.self,
            from: Mock.stringJSON1
        )

        XCTAssertEqual(decoded.firstString, Mock.stringJSONFirstString)
        XCTAssertEqual(decoded.secondString, Mock.stringJSONSecondString)
        XCTAssertEqual(decoded.thirdString, Mock.stringJSONThirdString)
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

    // MARK: - Tests - Decode Not Empty String If Present

    func test_decodeNotEmptyStringIfPresent_success() throws {
        let decoded = try decode(
            type: NotEmptyStringIfPresentModel.self,
            from: Mock.stringJSON1
        )

        XCTAssertEqual(decoded.firstString, Mock.stringJSONFirstString)
        XCTAssertEqual(decoded.secondString, Mock.stringJSONSecondString)
        XCTAssertEqual(decoded.thirdString, Mock.stringJSONThirdString)
    }

    func test_decodeNotEmptyStringIfPresent_partialSuccess() throws {
        let decoded = try decode(
            type: NotEmptyStringIfPresentModel.self,
            from: Mock.stringWrongJSON1
        )

        XCTAssertEqual(decoded.firstString, Mock.stringJSONFirstString)
        XCTAssertEqual(decoded.secondString, Mock.stringJSONSecondString)
        XCTAssertNil(decoded.thirdString)
    }

    func test_decodeNotEmptyStringIfPresent_fail() {
        XCTAssertThrowsError(try decode(
            type: NotEmptyStringIfPresentModel.self,
            from: Mock.stringWrongJSON4
        ))
    }

    // MARK: - Tests - Decode ISO8601 Date

    func test_decodeISO8601DateString_success() throws {
        let decoded = try decode(
            type: ISO8601DateStringModel.self,
            from: Mock.dateJSON1
        )

        XCTAssertEqual(decoded.firstDate, Mock.dateJSONFirstDate)
        XCTAssertEqual(decoded.secondDate, Mock.dateJSONSecondDate)
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

    // MARK: - Tests - Decode ISO8601 Date If Present

    func test_decodeISO8601DateStringIfPresent_success() throws {
        let decoded = try decode(
            type: ISO8601DateStringIfPresentModel.self,
            from: Mock.dateJSON1
        )

        XCTAssertEqual(decoded.firstDate, Mock.dateJSONFirstDate)
        XCTAssertEqual(decoded.secondDate, Mock.dateJSONSecondDate)
    }

    func test_decodeISO8601DateStringIfPresent_partialSuccess() throws {
        let decoded = try decode(
            type: ISO8601DateStringIfPresentModel.self,
            from: Mock.dateWrongJSON1
        )

        XCTAssertEqual(decoded.firstDate, Mock.dateJSONFirstDate)
        XCTAssertNil(decoded.secondDate)
    }

    func test_decodeISO8601DateStringIfPresent_fail() {
        XCTAssertThrowsError(try decode(
            type: ISO8601DateStringIfPresentModel.self,
            from: Mock.dateWrongJSON2
        ))
    }

}

// MARK: - Helpers

private extension KeyedDecodingContainerExtensionsTests {

    func decode<Base: Decodable>(
        type: Base.Type,
        from json: String
    ) throws -> Base {
        guard let data = json.data(using: .utf8) else {
            throw TestError.stringToData
        }
        return try JSONDecoder().decode(Base.self, from: data)
    }

}

// MARK: - Mock

private extension KeyedDecodingContainerExtensionsTests {

    enum Mock {

        static let collectionJSON1 = #" { "array": [1,2,3,4,5,6,7,8,9] } "#
        static let collectionJSON2 = #" { "array": [1,2,3,"some",5,6,7,[1,2,3],9] } "#
        static let collectionWrongJSON1 = #" { "array": "some" } "#
        static let collectionWrongJSON2 = #" { "notThatArray": [1,2,3,"some",5,6,7,[1,2,3],9] } "#

        static let collection1 = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        static let collection2 = [1, 2, 3, 5, 6, 7, 9]

        static let stringJSON1 = #" { "firstString": "First String Value", "secondString": "Second String Value", "thirdString": "Third String Value" } "#
        static let stringWrongJSON1 = #" { "firstString": "First String Value", "secondString": "Second String Value" } "#
        static let stringWrongJSON2 = #" { "firstString": "First String Value", "secondString": "", "thirdString": "Third String Value" } "#
        static let stringWrongJSON3 = #" { "firstString": "First String Value", "thirdString": "" } "#
        static let stringWrongJSON4 = #" { "firstString": "First String Value", "thirdString": 6 } "#

        static let stringJSONFirstString = "First String Value"
        static let stringJSONSecondString = "Second String Value"
        static let stringJSONThirdString = "Third String Value"

        static let dateJSON1 = #" { "firstDate": "2020-06-12T18:15:56Z", "secondDate": "2002-12-12T09:35:56Z" } "#

        static let dateWrongJSON1 = #" { "firstDate": "2020-06-12T18:15:56Z" } "#
        static let dateWrongJSON2 = #" { "firstDate": "2020-06-12T18:15:56Z", "secondDate": "2002-12-12 09:35:56 +0000" } "#

        static let dateJSONFirstDate = Date(timeIntervalSinceReferenceDate: 613678556)
        static let dateJSONSecondDate = Date(timeIntervalSinceReferenceDate: 61378556)

    }

}

// MARK: - Collection Safely Model

private extension KeyedDecodingContainerExtensionsTests {

    struct CollectionSafelyModel: Decodable {

        enum CodingKeys: String, CodingKey {
            case array
        }

        let array: [Int]

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            array = try container.decodeCollectionSafely(forKey: .array)
        }

    }

}

// MARK: - Collection Safely If Present Model

private extension KeyedDecodingContainerExtensionsTests {

    struct CollectionSafelyIfPresentModel: Decodable {

        enum CodingKeys: String, CodingKey {
            case array
        }

        let array: [Int]

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            array = try container.decodeCollectionSafelyIfPresent(forKey: .array)
        }

    }

}

// MARK: - Not Empty String Model

private extension KeyedDecodingContainerExtensionsTests {

    struct NotEmptyStringModel: Decodable {

        enum CodingKeys: String, CodingKey {
            case firstString
            case secondString
            case thirdString
        }

        let firstString: String
        let secondString: String
        let thirdString: String

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            firstString = try container.decodeNotEmptyString(forKey: .firstString)
            secondString = try container.decodeNotEmptyString(forKey: .secondString)
            thirdString = try container.decodeNotEmptyString(forKey: .thirdString)
        }

    }

}

// MARK: - Not Empty String If Present Model

private extension KeyedDecodingContainerExtensionsTests {

    struct NotEmptyStringIfPresentModel: Decodable {

        enum CodingKeys: String, CodingKey {
            case firstString
            case secondString
            case thirdString
        }

        let firstString: String?
        let secondString: String?
        let thirdString: String?

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            firstString = try container.decodeNotEmptyStringIfPresent(forKey: .firstString)
            secondString = try container.decodeNotEmptyStringIfPresent(forKey: .secondString)
            thirdString = try container.decodeNotEmptyStringIfPresent(forKey: .thirdString)
        }

    }

}

// MARK: - ISO8601 Date String Model

private extension KeyedDecodingContainerExtensionsTests {

    struct ISO8601DateStringModel: Decodable {

        enum CodingKeys: String, CodingKey {
            case firstDate
            case secondDate
        }

        let firstDate: Date
        let secondDate: Date

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            firstDate = try container.decodeISO8601DateString(forKey: .firstDate)
            secondDate = try container.decodeISO8601DateString(forKey: .secondDate)
        }

    }

}

// MARK: - ISO8601 Date String If Present Model

private extension KeyedDecodingContainerExtensionsTests {

    struct ISO8601DateStringIfPresentModel: Decodable {

        enum CodingKeys: String, CodingKey {
            case firstDate
            case secondDate
        }

        let firstDate: Date?
        let secondDate: Date?

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            firstDate = try container.decodeISO8601DateStringIfPresent(forKey: .firstDate)
            secondDate = try container.decodeISO8601DateStringIfPresent(forKey: .secondDate)
        }

    }

}
