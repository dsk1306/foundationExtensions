import Foundation

public extension String {

    /// Returns the string with trimmed whitespaces and newlines.
    /// If the string is empty after trimming, returns `nil`.
    var trimmedOrNil: String? {
        let string = trimmingCharacters(in: .whitespacesAndNewlines)
        return string.isEmpty ? nil : string
    }

}
