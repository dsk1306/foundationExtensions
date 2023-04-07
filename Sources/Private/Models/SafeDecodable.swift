import Foundation

struct SafeDecodable<Base: Decodable>: Decodable {

    // MARK: - Properties

    let value: Base?

    // MARK: - Initialization

    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            value = try container.decode(Base.self)
        } catch {
            value = nil
        }
    }

}
