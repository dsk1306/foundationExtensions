import Foundation

public extension URLRequest {

    func withMethod(_ method: Method) -> URLRequest {
        var request = self
        request.httpMethod = method.rawValue
        return request
    }

    func appendingHeaders(_ headers: [String: String]) -> URLRequest {
        var request = self
        headers.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        return request
    }

    func appendingHeader(value: String, forKey key: String) -> URLRequest {
        var request = self
        request.addValue(value, forHTTPHeaderField: key)
        return request
    }

}

// MARK: - Method

public extension URLRequest {

    ///HTTP method
    ///
    ///[Online Reference](https://www.rfc-editor.org/rfc/rfc9110.html).
    enum Method: String {

        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
        case head = "HEAD"
        case options = "OPTIONS"
        case trace = "TRACE"
        case connect = "CONNECT"

    }

}
