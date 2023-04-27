#if canImport(CoreGraphics)

import CoreGraphics
import Foundation

public extension CGRect {

    var topLeftCorner: CGPoint {
        .init(x: minX, y: minY)
    }

    var topMid: CGPoint {
        .init(x: midX, y: minY)
    }

    var topRightCorner: CGPoint {
        .init(x: maxX, y: minY)
    }

    var bottomLeftCorner: CGPoint {
        .init(x: minX, y: maxY)
    }

    var bottomMid: CGPoint {
        .init(x: midX, y: maxY)
    }

    var bottomRightCorner: CGPoint {
        .init(x: maxX, y: maxY)
    }

}

#endif
