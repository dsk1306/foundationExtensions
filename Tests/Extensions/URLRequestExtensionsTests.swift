@testable import FoundationExtensions
import XCTest

final class URLRequestExtensionsTests: XCTestCase {

    // MARK: - Tests

    func test_appendingHeaders() {
        let request = Mock.request.appendingHeader(
            value: Mock.value1,
            forKey: Mock.key1
        )

        XCTAssertEqual(request.allHTTPHeaderFields, Mock.headers1)
    }

    func test_appendingHeadersArray() {
        let request = Mock.request.appendingHeaders(Mock.headers2)

        XCTAssertEqual(request.allHTTPHeaderFields, Mock.headers2)
    }

    func test_withMethod_get() {
        let request = Mock.request.withMethod(.get)

        XCTAssertEqual(request.httpMethod, "GET")
    }

    func test_withMethod_post() {
        let request = Mock.request.withMethod(.post)

        XCTAssertEqual(request.httpMethod, "POST")
    }

}

// MARK: - Mock

private extension URLRequestExtensionsTests {

    enum Mock {

        static let request = URLRequest(url: URL(string: "example.com")!)
        static let value1 = "Accept-Encoding"
        static let value2 = "Accept"
        static let key1 = "gzip, deflate, br"
        static let key2 = "*/*"
        static let headers1 = [key1: value1]
        static let headers2 = [key1: value1, key2: value2]

    }

}
