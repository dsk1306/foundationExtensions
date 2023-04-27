#if canImport(CoreGraphics)

@testable import FoundationExtensions
import XCTest

final class CGRectExtensionsTests: XCTestCase {

    // MARK: - Tests

    func test_topLeftCorner() {
        XCTAssertEqual(Mock.rect.topLeftCorner.x, Mock.originX)
        XCTAssertEqual(Mock.rect.topLeftCorner.y, Mock.originY)
    }

    func test_topMid() {
        XCTAssertEqual(Mock.rect.topMid.x, Mock.horizontalMid)
        XCTAssertEqual(Mock.rect.topMid.y, Mock.originY)
    }

    func test_topRightCorner() {
        XCTAssertEqual(Mock.rect.topRightCorner.x, Mock.rightX)
        XCTAssertEqual(Mock.rect.topRightCorner.y, Mock.originY)
    }

    func test_bottomLeftCorner() {
        XCTAssertEqual(Mock.rect.bottomLeftCorner.x, Mock.originX)
        XCTAssertEqual(Mock.rect.bottomLeftCorner.y, Mock.bottomY)
    }

    func test_bottomMid() {
        XCTAssertEqual(Mock.rect.bottomMid.x, Mock.horizontalMid)
        XCTAssertEqual(Mock.rect.bottomMid.y, Mock.bottomY)
    }

    func test_bottomRightCorner() {
        XCTAssertEqual(Mock.rect.bottomRightCorner.x, Mock.rightX)
        XCTAssertEqual(Mock.rect.bottomRightCorner.y, Mock.bottomY)
    }

}

// MARK: - Mock

private extension CGRectExtensionsTests {

    enum Mock {

        static let originX = CGFloat.random(in: 0...10)
        static let originY = CGFloat.random(in: 0...10)
        static let width = CGFloat.random(in: 11...20)
        static let height = CGFloat.random(in: 11...20)

        static let bottomY = height + originY
        static let rightX = width + originX
        static let horizontalMid = width / 2 + originX

        static let rect = CGRect(
            origin: .init(x: originX, y: originY),
            size: .init(width: width, height: height)
        )
    }

}

#endif
