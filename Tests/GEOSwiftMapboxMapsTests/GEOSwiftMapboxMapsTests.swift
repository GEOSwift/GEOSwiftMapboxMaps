import XCTest
import MapboxMaps
import GEOSwiftMapboxMaps
import GEOSwift
@testable import GEOSwiftMapboxMaps

final class GEOSwiftMapboxMapsTests: XCTestCase {
    
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
    
    // MultiPoint
    func testCreatTurfMultiPointFromGEOSwiftMultiPoint() {
        let geoSwiftMultiPoint = GEOSwift.MultiPoint(points: [Point(x: 1, y: 6), Point(x: 8, y: 6)])
        let turfMultiPoint = Turf.MultiPoint(multiPoint: geoSwiftMultiPoint)
        XCTAssertEqual(geoSwiftMultiPoint.points.first?.x, turfMultiPoint.coordinates.first?.longitude)
        XCTAssertEqual(geoSwiftMultiPoint.points.last?.x, turfMultiPoint.coordinates.last?.longitude)
        XCTAssertEqual(geoSwiftMultiPoint.points.first?.y, turfMultiPoint.coordinates.first?.latitude)
        XCTAssertEqual(geoSwiftMultiPoint.points.first?.y, turfMultiPoint.coordinates.first?.latitude)
    }
    
    func testCreatGEOSwiftMultiPointFromTurfMultiPoint() {
        let coordinates = [
            LocationCoordinate2D(latitude: 0, longitude: 4),
            LocationCoordinate2D(latitude: 41, longitude: 2),
            LocationCoordinate2D(latitude: 3, longitude: 2),
            LocationCoordinate2D(latitude: 3, longitude: -1),
            LocationCoordinate2D(latitude: 4, longitude: 0)
        ]
        let turfMultiPoint = Turf.MultiPoint(coordinates)
        let geoSwiftMultiPoint = GEOSwift.MultiPoint(multiPoint: turfMultiPoint)
        XCTAssertEqual(geoSwiftMultiPoint.points.first?.x, turfMultiPoint.coordinates.first?.longitude)
        XCTAssertEqual(geoSwiftMultiPoint.points.last?.x, turfMultiPoint.coordinates.last?.longitude)
        XCTAssertEqual(geoSwiftMultiPoint.points.first?.y, turfMultiPoint.coordinates.first?.latitude)
        XCTAssertEqual(geoSwiftMultiPoint.points.first?.y, turfMultiPoint.coordinates.first?.latitude)
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
        let coordinates = [
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
    
    // MultiLineString
    func testCreateTurfMultiLineStringFromGEOSwiftMultiLineString() throws {
        let wkt = "MULTILINESTRING ((30 10, 40 40, 20 40), (10 20, 30 30, 40 10))"
        let geoSwiftMultiLineString = try GEOSwift.MultiLineString(wkt: wkt)
        
        let turfMultiLineString = Turf.MultiLineString(multiLineString: geoSwiftMultiLineString)
        
        XCTAssertEqual(geoSwiftMultiLineString.lineStrings.first?.firstPoint.x, turfMultiLineString.coordinates.first?.first?.longitude)
        XCTAssertEqual(geoSwiftMultiLineString.lineStrings.last?.firstPoint.x, turfMultiLineString.coordinates.last?.first?.longitude)
        XCTAssertEqual(geoSwiftMultiLineString.lineStrings.first?.lastPoint.x, turfMultiLineString.coordinates.first?.last?.longitude)
        XCTAssertEqual(geoSwiftMultiLineString.lineStrings.last?.lastPoint.x, turfMultiLineString.coordinates.last?.last?.longitude)
        XCTAssertEqual(geoSwiftMultiLineString.lineStrings.first?.firstPoint.y, turfMultiLineString.coordinates.first?.first?.latitude)
        XCTAssertEqual(geoSwiftMultiLineString.lineStrings.last?.firstPoint.y, turfMultiLineString.coordinates.last?.first?.latitude)
        XCTAssertEqual(geoSwiftMultiLineString.lineStrings.first?.lastPoint.y, turfMultiLineString.coordinates.first?.last?.latitude)
        XCTAssertEqual(geoSwiftMultiLineString.lineStrings.last?.lastPoint.y, turfMultiLineString.coordinates.last?.last?.latitude)
    }
    
    func testCreateGEOSwiftMultiLineStringFromTurfMultiLineString() throws {
        let coordinates1 = [
            LocationCoordinate2D(latitude: 0, longitude: 4),
            LocationCoordinate2D(latitude: 1, longitude: -3),
            LocationCoordinate2D(latitude: 2, longitude: 2),
            LocationCoordinate2D(latitude: -3, longitude: 1),
            LocationCoordinate2D(latitude: 4, longitude: 0)
        ]
        let coordinates2 = [
            LocationCoordinate2D(latitude: 0, longitude: 4),
            LocationCoordinate2D(latitude: 41, longitude: 2),
            LocationCoordinate2D(latitude: 3, longitude: 2),
            LocationCoordinate2D(latitude: 3, longitude: -1),
            LocationCoordinate2D(latitude: 4, longitude: 0)
        ]
        let turfMultiLineString = Turf.MultiLineString([coordinates1, coordinates2])
        let geoSwiftMultiLineString = try GEOSwift.MultiLineString(multiLineString: turfMultiLineString)
        
        XCTAssertEqual(geoSwiftMultiLineString.lineStrings.first?.firstPoint.x, turfMultiLineString.coordinates.first?.first?.longitude)
        XCTAssertEqual(geoSwiftMultiLineString.lineStrings.last?.firstPoint.x, turfMultiLineString.coordinates.last?.first?.longitude)
        XCTAssertEqual(geoSwiftMultiLineString.lineStrings.first?.lastPoint.x, turfMultiLineString.coordinates.first?.last?.longitude)
        XCTAssertEqual(geoSwiftMultiLineString.lineStrings.last?.lastPoint.x, turfMultiLineString.coordinates.last?.last?.longitude)
        XCTAssertEqual(geoSwiftMultiLineString.lineStrings.first?.firstPoint.y, turfMultiLineString.coordinates.first?.first?.latitude)
        XCTAssertEqual(geoSwiftMultiLineString.lineStrings.last?.firstPoint.y, turfMultiLineString.coordinates.last?.first?.latitude)
        XCTAssertEqual(geoSwiftMultiLineString.lineStrings.first?.lastPoint.y, turfMultiLineString.coordinates.first?.last?.latitude)
        XCTAssertEqual(geoSwiftMultiLineString.lineStrings.last?.lastPoint.y, turfMultiLineString.coordinates.last?.last?.latitude)
    }
    
    // Polygon
    func testCreateTurfPolygonFromGEOSwiftPolygon() {
        let geoSwiftPolygon = try! Polygon(wkt: "POLYGON ((30 10, 40 40, 20 40, 10 20, 30 10), (20 30, 35 35, 30 20, 20 30))")
        
        let turfPolygon = Polygon(polygon: geoSwiftPolygon)
        
        XCTAssertEqual(geoSwiftPolygon.exterior.points.first?.y, turfPolygon.outerRing.coordinates.first?.latitude)
        XCTAssertEqual(geoSwiftPolygon.holes.first?.points.first?.x, turfPolygon.innerRings.first?.coordinates.first?.longitude)
    }
    
    func testCreateTurfPolygonFromGEOSwiftPolygonLinearRing() throws {
        let points = [Point(x: 45, y: 9), Point(x: 43, y: 3214), Point(x: 432, y: 423), Point(x: 4223, y: 7564), Point(x: 45, y: 9)]
        let linearRing = try GEOSwift.Polygon.LinearRing(points: points)
        
        let turfPolygon = Polygon(linerRing: linearRing)
        XCTAssertEqual(linearRing.points.first?.x, turfPolygon.coordinates.first?.first?.longitude)
        XCTAssertEqual(linearRing.points.last?.y, turfPolygon.coordinates.first?.last?.latitude)
        XCTAssertEqual(linearRing.points.last?.x, turfPolygon.coordinates.first?.last?.longitude)
        XCTAssertEqual(linearRing.points.last?.y, turfPolygon.coordinates.first?.last?.latitude)
    }
    
    func testCreateGEOSwiftPolygonFromTurfPolygon() {
        let turfPolygon = Polygon(
            [[CLLocationCoordinate2D(latitude: 10.0, longitude: 30.0), CLLocationCoordinate2D(latitude: 40.0, longitude: 40.0), CLLocationCoordinate2D(latitude: 40.0, longitude: 20.0), CLLocationCoordinate2D(latitude: 20.0, longitude: 10.0), CLLocationCoordinate2D(latitude: 10.0, longitude: 30.0)], [CLLocationCoordinate2D(latitude: 30.0, longitude: 20.0), CLLocationCoordinate2D(latitude: 35.0, longitude: 35.0), CLLocationCoordinate2D(latitude: 20.0, longitude: 30.0), CLLocationCoordinate2D(latitude: 30.0, longitude: 20.0)]])
        
        let geoSwiftPolygon = try! Polygon(polygon: turfPolygon)
        
        XCTAssertEqual(geoSwiftPolygon.exterior.points.first?.y, turfPolygon.outerRing.coordinates.first?.latitude)
        XCTAssertEqual(geoSwiftPolygon.holes.first?.points.first?.x, turfPolygon.innerRings.first?.coordinates.first?.longitude)
    }
    
    // MultiPolygon
    func testCreateTurfMultiPolygonFromGEOSwiftMultiPolygon() throws {
        let geoSwiftPolygon1 = try! Polygon(wkt: "POLYGON ((30 10, 40 40, 20 40, 10 20, 30 10), (20 30, 35 35, 30 20, 20 30))")
        let geoSwiftPolygon2 = try! Polygon(wkt: "POLYGON ((30 234, 40 44, 20 334, 10 20, 30 234), (20 30, 5432 234, 30 4234, 20 30))")
        let geoSwiftMultiPolygon = GEOSwift.MultiPolygon(polygons: [geoSwiftPolygon1, geoSwiftPolygon2])
        
        let turfMultiPolygon = Turf.MultiPolygon(polygon: geoSwiftMultiPolygon)
        
        XCTAssertEqual(geoSwiftMultiPolygon.polygons.first?.exterior.points.first?.x, turfMultiPolygon.polygons.first?.outerRing.coordinates.first?.longitude)
        XCTAssertEqual(geoSwiftMultiPolygon.polygons.last?.exterior.points.first?.x, turfMultiPolygon.polygons.last?.outerRing.coordinates.first?.longitude)
        XCTAssertEqual(geoSwiftMultiPolygon.polygons.first?.exterior.points.last?.x, turfMultiPolygon.polygons.first?.outerRing.coordinates.last?.longitude)
        XCTAssertEqual(geoSwiftMultiPolygon.polygons.last?.exterior.points.last?.x, turfMultiPolygon.polygons.last?.outerRing.coordinates.last?.longitude)
        XCTAssertEqual(geoSwiftMultiPolygon.polygons.first?.exterior.points.first?.y, turfMultiPolygon.polygons.first?.outerRing.coordinates.first?.latitude)
        XCTAssertEqual(geoSwiftMultiPolygon.polygons.last?.exterior.points.first?.y, turfMultiPolygon.polygons.last?.outerRing.coordinates.first?.latitude)
        XCTAssertEqual(geoSwiftMultiPolygon.polygons.first?.exterior.points.last?.y, turfMultiPolygon.polygons.first?.outerRing.coordinates.last?.latitude)
        XCTAssertEqual(geoSwiftMultiPolygon.polygons.last?.exterior.points.last?.y, turfMultiPolygon.polygons.last?.outerRing.coordinates.last?.latitude)
    }
    
    func testCreateGEOSwiftMultiPolygonFromTurfMultiPolygon() throws {
        let turfPolygon1 = Polygon(
            [[CLLocationCoordinate2D(latitude: 10.0, longitude: 30.0), CLLocationCoordinate2D(latitude: 40.0, longitude: 40.0), CLLocationCoordinate2D(latitude: 40.0, longitude: 20.0), CLLocationCoordinate2D(latitude: 20.0, longitude: 10.0), CLLocationCoordinate2D(latitude: 10.0, longitude: 30.0)], [CLLocationCoordinate2D(latitude: 30.0, longitude: 20.0), CLLocationCoordinate2D(latitude: 35.0, longitude: 35.0), CLLocationCoordinate2D(latitude: -20.0, longitude: 30.0), CLLocationCoordinate2D(latitude: 30.0, longitude: 20.0)]])
        let turfPolygon2 = Polygon(
            [[CLLocationCoordinate2D(latitude: 10.0, longitude: 30.0), CLLocationCoordinate2D(latitude: 40.0, longitude: 40.0), CLLocationCoordinate2D(latitude: 40.0, longitude: 20.0), CLLocationCoordinate2D(latitude: 21.0, longitude: 10.0), CLLocationCoordinate2D(latitude: 10.0, longitude: 30.0)], [CLLocationCoordinate2D(latitude: 30.0, longitude: 20.0), CLLocationCoordinate2D(latitude: -35.0, longitude: 35.0), CLLocationCoordinate2D(latitude: 20.0, longitude: 30.0), CLLocationCoordinate2D(latitude: 30.0, longitude: 20.0)]])
        let turfMultiPolygon = Turf.MultiPolygon([turfPolygon1, turfPolygon2])
        
        let geoSwiftMultiPolygon = try GEOSwift.MultiPolygon(polygon: turfMultiPolygon)
        
        XCTAssertEqual(geoSwiftMultiPolygon.polygons.first?.exterior.points.first?.x, turfMultiPolygon.polygons.first?.outerRing.coordinates.first?.longitude)
        XCTAssertEqual(geoSwiftMultiPolygon.polygons.last?.exterior.points.first?.x, turfMultiPolygon.polygons.last?.outerRing.coordinates.first?.longitude)
        XCTAssertEqual(geoSwiftMultiPolygon.polygons.first?.exterior.points.last?.x, turfMultiPolygon.polygons.first?.outerRing.coordinates.last?.longitude)
        XCTAssertEqual(geoSwiftMultiPolygon.polygons.last?.exterior.points.last?.x, turfMultiPolygon.polygons.last?.outerRing.coordinates.last?.longitude)
        XCTAssertEqual(geoSwiftMultiPolygon.polygons.first?.exterior.points.first?.y, turfMultiPolygon.polygons.first?.outerRing.coordinates.first?.latitude)
        XCTAssertEqual(geoSwiftMultiPolygon.polygons.last?.exterior.points.first?.y, turfMultiPolygon.polygons.last?.outerRing.coordinates.first?.latitude)
        XCTAssertEqual(geoSwiftMultiPolygon.polygons.first?.exterior.points.last?.y, turfMultiPolygon.polygons.first?.outerRing.coordinates.last?.latitude)
        XCTAssertEqual(geoSwiftMultiPolygon.polygons.last?.exterior.points.last?.y, turfMultiPolygon.polygons.last?.outerRing.coordinates.last?.latitude)
    }
    
    func testCreateCLLocationCoordinate2DFromPoint() {
        let point = Point(x: 45, y: 9)

        let coordinate = CLLocationCoordinate2D(point)

        XCTAssertEqual(coordinate, CLLocationCoordinate2D(latitude: 9, longitude: 45))
    }
    
    func testWorldPolygon() {
        // just make sure it doesn't crash
        _ = GEOSwift.Polygon.world
    }
    
    func testCreatePointAnnotationFromPoint() {
        let point = Point(x: 45, y: 9)

        let annotation = PointAnnotation(point: point)
        

        guard case let .point(annotationGeometry) = annotation.geometry else {
            XCTFail("Incorrect geometry type.")
            return
        }

        XCTAssertEqual(annotationGeometry.coordinates, CLLocationCoordinate2D(latitude: 9, longitude: 45))
    }
}
