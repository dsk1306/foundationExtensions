import Foundation

public extension KeyedDecodingContainer {

    // MARK: Collection

    func decodeCollectionSafely<Element>(
        forKey key: KeyedDecodingContainer.Key
    ) throws -> [Element] where Element: Decodable {
        try decode([SafeDecodable<Element>].self, forKey: key)
            .compactMap { $0.value }
    }

    func decodeCollectionSafelyIfPresent<Element>(
        forKey key: KeyedDecodingContainer.Key
    ) throws -> [Element] where Element: Decodable {
        guard let collection = try decodeIfPresent([SafeDecodable<Element>].self, forKey: key) else { return [] }
        return collection.compactMap { $0.value }
    }

    // MARK: Not Empty String

    func decodeNotEmptyString(
        forKey key: KeyedDecodingContainer.Key
    ) throws -> String {
        guard let string = try decode(String.self, forKey: key).trimmedOrNil else {
            throw DecodingError.dataCorruptedError(
                forKey: key,
                in: self,
                debugDescription: "Decoded string should not be empty"
            )
        }
        return string
    }

    func decodeNotEmptyStringIfPresent(
        forKey key: KeyedDecodingContainer.Key
    ) throws -> String? {
        try decodeIfPresent(String.self, forKey: key)?.trimmedOrNil
    }

    // MARK: - ISO8601 Date String

    func decodeISO8601DateString(forKey key: KeyedDecodingContainer.Key) throws -> Date {
        let dateString = try decodeNotEmptyString(forKey: key)
        guard let date = ISO8601DateFormatter().date(from: dateString) else {
            throw DecodingError.expectedISO8601DateString(for: key, in: self)
        }
        return date
    }

    func decodeISO8601DateStringIfPresent(forKey key: KeyedDecodingContainer.Key) throws -> Date? {
        guard let dateString = try decodeNotEmptyStringIfPresent(forKey: key) else { return nil }
        guard let date = ISO8601DateFormatter().date(from: dateString) else {
            throw DecodingError.expectedISO8601DateString(for: key, in: self)
        }
        return date
    }

}

// MARK: - DecodingError Ext

private extension DecodingError {

    static func expectedISO8601DateString<C>(
        for key: C.Key,
        in container: C
    ) -> DecodingError where C : KeyedDecodingContainerProtocol {
        dataCorruptedError(
            forKey: key,
            in: container,
            debugDescription: "Expected ISO8601 date string"
        )
    }

}
