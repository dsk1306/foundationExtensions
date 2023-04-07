import Foundation

public extension SingleValueDecodingContainer {

    func decodeCollectionSafely<Element>() throws -> [Element] where Element: Decodable {
        try decode([SafeDecodable<Element>].self)
            .compactMap { $0.value }
    }

    func decodeNotEmptyString() throws -> String {
        guard let string = try decode(String.self).trimmedOrNil else {
            throw DecodingError.dataCorruptedError(
                in: self,
                debugDescription: DecodingErrorDebugDescription.emptyString
            )
        }
        return string
    }

    func decodeISO8601DateString() throws -> Date {
        let dateString = try decodeNotEmptyString()
        guard let date = ISO8601DateFormatter().date(from: dateString) else {
            throw DecodingError.dataCorruptedError(
                in: self,
                debugDescription: DecodingErrorDebugDescription.iso8601DateString
            )
        }
        return date
    }

}
