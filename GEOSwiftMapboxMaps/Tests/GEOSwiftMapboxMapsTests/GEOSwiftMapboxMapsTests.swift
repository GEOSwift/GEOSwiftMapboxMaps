import XCTest
import MapboxMaps
import GEOSwiftMapboxMaps
import GEOSwift
@testable import GEOSwiftMapboxMaps

final class GEOSwiftMapboxMapsTests: XCTestCase {
    
    // CLLocationCoordinate2D
    
    func testCreateCLLocationCoordinate2DFromPoint() {
        let point = Point(x: 45, y: 9)

        let coordinate = CLLocationCoordinate2D(point)

        XCTAssertEqual(coordinate, CLLocationCoordinate2D(latitude: 9, longitude: 45))
    }
    
    // Point
    func testCreatePointWithLatAndLong() {
        let point = Point(longitude: 1, latitude: 2)

        XCTAssertEqual(point.x, 1)
        XCTAssertEqual(point.y, 2)
    }

    func testCreatePointWithCLLocationCoordinate2D() {
        let coord = CLLocationCoordinate2D(latitude: 2, longitude: 1)

        XCTAssertEqual(Point(coord), Point(x: 1, y: 2))
    }
    
    // Polygon
    func testWorldPolygon() {
        // just make sure it doesn't crash
        _ = GEOSwift.Polygon.world
    }
    
    // PointAnnotation
    func testCreatePointAnnotationFromPoint() {
        let point = Point(x: 45, y: 9)

        let annotation = PointAnnotation(point: point)
        

        guard case let .point(annotationGeometry) = annotation.geometry else {
            XCTFail("Incorrect geometry type.")
            return
        }

        XCTAssertEqual(annotationGeometry.coordinates, CLLocationCoordinate2D(latitude: 9, longitude: 45))
    }
    
    // LineString
    func testCreateTurfLineStringFromGEOSwiftLineString() {
        let geoSwiftLineString = try! GEOSwift.LineString(wkt: "LINESTRING(3 4,10 50,20 25)")

        let turfLineString = Turf.LineString(lineString: geoSwiftLineString)

        XCTAssertEqual(geoSwiftLineString.points.count, turfLineString.coordinates.count)
        XCTAssertEqual(geoSwiftLineString.firstPoint.x, turfLineString.coordinates.first?.longitude)
        XCTAssertEqual(geoSwiftLineString.lastPoint.x, turfLineString.coordinates.last?.longitude)
    }
    
    func testCreateGEOSwiftLineStringFromTurfLineString() {
        let coordinates: [LocationCoordinate2D] = [
            LocationCoordinate2D(latitude: 0, longitude: 4),
            LocationCoordinate2D(latitude: 1, longitude: 3),
            LocationCoordinate2D(latitude: 2, longitude: 2),
            LocationCoordinate2D(latitude: 3, longitude: 1),
            LocationCoordinate2D(latitude: 4, longitude: 0)
        ]
        
        let turfLineString = Turf.LineString(coordinates)
        
        guard let geoSwiftLineString = try? GEOSwift.LineString(lineString: turfLineString) else {
            XCTFail("Conversion failed.")
            return
        }
        
        XCTAssertEqual(geoSwiftLineString.points.count, turfLineString.coordinates.count)
        XCTAssertEqual(geoSwiftLineString.firstPoint.x, turfLineString.coordinates.first?.longitude)
        XCTAssertEqual(geoSwiftLineString.lastPoint.x, turfLineString.coordinates.last?.longitude)
    }
    
    func testCreateTurfPolygonFromGEOSwiftPolygon() {
        let GEOSwiftPolygon = try! Polygon(wkt: "POLYGON ((30 10, 40 40, 20 40, 10 20, 30 10), (20 30, 35 35, 30 20, 20 30))")
        
        let TurfPolygon = Polygon(polygon: GEOSwiftPolygon)
        
        XCTAssertEqual(GEOSwiftPolygon.exterior.points.first?.y, TurfPolygon.outerRing.coordinates.first?.latitude)
        XCTAssertEqual(GEOSwiftPolygon.holes.first?.points.first?.x, TurfPolygon.innerRings.first?.coordinates.first?.longitude)
    }
    
    func testCreateGEOSwiftPolygonFromTurfPolygon() {
        let TurfPolygon = Polygon(
            [[CLLocationCoordinate2D(latitude: 10.0, longitude: 30.0), CLLocationCoordinate2D(latitude: 40.0, longitude: 40.0), CLLocationCoordinate2D(latitude: 40.0, longitude: 20.0), CLLocationCoordinate2D(latitude: 20.0, longitude: 10.0), CLLocationCoordinate2D(latitude: 10.0, longitude: 30.0)], [CLLocationCoordinate2D(latitude: 30.0, longitude: 20.0), CLLocationCoordinate2D(latitude: 35.0, longitude: 35.0), CLLocationCoordinate2D(latitude: 20.0, longitude: 30.0), CLLocationCoordinate2D(latitude: 30.0, longitude: 20.0)]])
        
        let GEOSwiftPolygon = try! Polygon(polygon: TurfPolygon)
        
        XCTAssertEqual(GEOSwiftPolygon.exterior.points.first?.y, TurfPolygon.outerRing.coordinates.first?.latitude)
        XCTAssertEqual(GEOSwiftPolygon.holes.first?.points.first?.x, TurfPolygon.innerRings.first?.coordinates.first?.longitude)
    }
}
