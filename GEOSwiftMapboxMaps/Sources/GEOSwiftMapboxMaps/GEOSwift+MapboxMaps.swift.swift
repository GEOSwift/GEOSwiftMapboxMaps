import Foundation
import GEOSwift
import MapboxMaps

public extension CLLocationCoordinate2D {
    init(_ point: GEOSwift.Point) {
        self.init(latitude: point.y, longitude: point.x)
    }
}
