import Foundation

extension DecodingError {

    static func expectedISO8601DateStringError<C>(
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
