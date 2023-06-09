import Foundation
import GEOSwift
import MapboxMaps

public extension CLLocationCoordinate2D {
    init(_ point: GEOSwift.Point) {
        self.init(latitude: point.y, longitude: point.x)
    }
}

// Point
public extension GEOSwift.Point {
    init(longitude: Double, latitude: Double) {
        self.init(x: longitude, y: latitude)
    }

    init(_ coordinate: CLLocationCoordinate2D) {
        self.init(x: coordinate.longitude, y: coordinate.latitude)
    }
}

// MultiPoint
public extension Turf.MultiPoint {
    init(multiPoint: GEOSwift.MultiPoint) {
        let points = multiPoint.points.map { point in
            LocationCoordinate2D(latitude: point.y, longitude: point.x)
        }
        self.init(points)
    }
}

public extension GEOSwift.MultiPoint {
    init(multiPoint: Turf.MultiPoint) {
        let points = multiPoint.coordinates.map { point in
            GEOSwift.Point(longitude: point.longitude, latitude: point.latitude)
        }
        self.init(points: points)
    }
}

// LineString
public extension Turf.LineString {
    init(lineString: GEOSwift.LineString) {
        let points = lineString.points
        let coordinates = points.map { point in
            LocationCoordinate2D(point)
        }
        self.init(coordinates)
    }
}

public extension GEOSwift.LineString {
    init(lineString: Turf.LineString) throws {
        let coordinates = lineString.coordinates
        let points = coordinates.map { coordinate in
            GEOSwift.Point(longitude: coordinate.longitude, latitude: coordinate.latitude)
        }
        try self.init(points: points)
    }
}

// MultiLineString
public extension Turf.MultiLineString {
    init(multiLineString: GEOSwift.MultiLineString) {
        let locationCordinatesArray = multiLineString.lineStrings.map { lineString in
            let coordinates = lineString.points.map { point in
                LocationCoordinate2D(point)
            }
            return coordinates
        }
        self.init(locationCordinatesArray)
    }
}

public extension GEOSwift.MultiLineString {
    init(multiLineString: Turf.MultiLineString) throws {
        let lineStringArray = try multiLineString.coordinates.map { coordinates in
            let points = coordinates.map { coordinate in
                GEOSwift.Point(coordinate)
            }
            return try GEOSwift.LineString(points: points)
        }
        self.init(lineStrings: lineStringArray)
    }
}

// Polygon
public extension Turf.Polygon {
    init(polygon: GEOSwift.Polygon) {
        let exteriorPoints = polygon.exterior.points.map { point in
            LocationCoordinate2D(point)
        }
        let interiorPoints = polygon.holes.map { interiorRing in
            let coordinates = interiorRing.points.map { point in
                LocationCoordinate2D(point)
            }
            return Ring(coordinates: coordinates)
        }
        self.init(outerRing: Ring(coordinates: exteriorPoints), innerRings: interiorPoints)
    }
    init(linerRing: GEOSwift.Polygon.LinearRing) {
        let coordinates = linerRing.points.map { point in
            LocationCoordinate2D(point)
        }
        self.init([coordinates])
    }
}

public extension GEOSwift.Polygon {
    init(polygon: Turf.Polygon) throws {
        let exteriorPoints = polygon.outerRing.coordinates.map { point in
            Point(longitude: point.longitude, latitude: point.latitude)
        }
        let interiorPoints = try polygon.innerRings.map { interiorRing in
            let coordinates = interiorRing.coordinates.map { coorinate in
                Point(longitude: coorinate.longitude, latitude: coorinate.latitude)
            }
            return try LinearRing(points: coordinates)
        }
        self.init(exterior: try LinearRing(points: exteriorPoints), holes: interiorPoints)
    }
}

// MultiPolygon
public extension Turf.MultiPolygon {
    init(polygon: GEOSwift.MultiPolygon) {
        let geoSwiftMultiPolygon = polygon.polygons.map { polygon in
            Turf.Polygon(polygon: polygon)
        }
        self.init(geoSwiftMultiPolygon)
    }
}

public extension GEOSwift.MultiPolygon {
    init(polygon: Turf.MultiPolygon) throws {
        let turfMultiPolygon = try polygon.polygons.map { polygon in
            try GEOSwift.Polygon(polygon: polygon)
        }
        self.init(polygons: turfMultiPolygon)
    }
}


public extension PointAnnotation {
    init(point: GEOSwift.Point) {
        let coordinate = CLLocationCoordinate2D(point)
        self.init(coordinate: coordinate)
    }
}

public extension GEOSwift.Polygon {
    // swiftlint:disable:next force_try
    static let world = try! GEOSwift.Polygon(
        exterior: Polygon.LinearRing(
            points: [
                Point(x: -180, y: 90),
                Point(x: -180, y: -90),
                Point(x: 180, y: -90),
                Point(x: 180, y: 90),
                Point(x: -180, y: 90)]))
}
