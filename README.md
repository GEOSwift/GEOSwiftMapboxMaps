# GEOSwiftMapboxMaps
Mapbox Maps support for GEOSwift

See [GEOSwift](https://github.com/GEOSwift/GEOSwift) for full details

## Requirements

* iOS 11.0+
* Swift 5.3+
* [MapboxMaps 10+](https://github.com/mapbox/mapbox-maps-ios/)

## Installation

### Swift Package Manager


## Usage

```swift

import GEOSwift
import Mapbox
import GEOSwiftMapboxMaps

...

let point = Point(longitude: 10, latitude: 45)
let polygon = try! Polygon(wkt: "POLYGON((35 10, 45 45.5, 15 40, 10 20, 35 10),(20 30, 35 35, 30 20, 20 30))")

let coordinate = CLLocationCoordinate2D(point)

        let turfPolygon = Polygon(linerRing: linearRing)
...

```
Easily convert between equivalent types in GEOSwift and MapboxMaps (Turf) with convenience initializers that accept
the corresponding GEOSwift type.

| GEOSwift | MapboxMaps (Turf) |
|:-------------:|:-----------------:|
| `Point` | `Point` |
| `LineString` | `LineString` |
| `Polygon` | `Polygon` |
| `MultiPoint` | `MultiPoint` |
| `MultiLineString` | `MultiLineString` |
| `MultiPolygon` | `MultiPolygon` |

## Contributing

To make a contribution:

* Fork the repo
* Start from the `main` branch and create a branch with a name that describes
  your contribution
* Follow the Mapbox Maps SDK [installation
  instructions](https://docs.mapbox.com/ios/maps/guides/install/) to configure
  your `~/.netrc` file.
* Install with SPM
* Make your changes.
* Push your branch and create a pull request to `main`
* One of the maintainers will review your code and may request changes
* If your pull request is accepted, one of the maintainers should update the
  changelog before merging it.
* Due to the need for a secret Mapbox token to install the Mapbox SDK, CI will
  not run for PRs from forks. Maintainers should be sure to run the test suite
  locally before accepting any changes.

## Maintainer

* Patrick Leonard ([@pjleonard37](https://github.com/pjleonard37))

## GEOSwift Maintainers (current and former

* Andrew Hershberger ([@macdrevx](https://github.com/macdrevx))
* Virgilio Favero Neto ([@vfn](https://github.com/vfn))
* Andrea Cremaschi ([@andreacremaschi](https://twitter.com/andreacremaschi))
  (original author)

## License

* GEOSwiftMapboxMaps was released by Patrick
  ([@pjleonard37](https://twitter.com/pj_leonard)) under a MIT license.
  See LICENSE for more information.
* GEOSwift was released by Andrea Cremaschi
  ([@andreacremaschi](https://twitter.com/andreacremaschi)) under a MIT license.
