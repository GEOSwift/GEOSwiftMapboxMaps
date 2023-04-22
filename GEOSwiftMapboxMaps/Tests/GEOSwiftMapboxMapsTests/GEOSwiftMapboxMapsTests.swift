import XCTest
import MapboxMaps
import GEOSwiftMapboxMaps
import GEOSwift
@testable import GEOSwiftMapboxMaps

final class GEOSwiftMapboxMapsTests: XCTestCase {
    func testCreateCLLocationCoordinate2DFromPoint() {
        let point = Point(x: 45, y: 9)

        let coordinate = CLLocationCoordinate2D(point)

        XCTAssertEqual(coordinate, CLLocationCoordinate2D(latitude: 9, longitude: 45))
    }
}
