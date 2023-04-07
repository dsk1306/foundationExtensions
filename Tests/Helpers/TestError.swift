import Foundation

enum TestError: LocalizedError {

    case stringToData

    var errorDescription: String? {
        switch self {
        case .stringToData:
            return "Could not create Data object from string"
        }
    }

}
