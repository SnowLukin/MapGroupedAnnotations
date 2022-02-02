//
//  LocationsDataService.swift
//  MapGroupedAnnotations
//
//  Created by Snow Lukin on 26.01.2022.
//

import Foundation
import MapKit

class LocationsDataSevice {
    
    static let shared = [
        Location(name: "ONE", description: "one",
                 coordinates: CLLocationCoordinate2D(latitude: 59.9398,
                                                     longitude: 30.326)),
        Location(name: "TWO", description: "two",
                 coordinates: CLLocationCoordinate2D(latitude: 59.9368,
                                                     longitude: 30.3146)),
        Location(name: "THREE", description: "three",
                 coordinates: CLLocationCoordinate2D(latitude: 59.9398,
                                                     longitude: 30.3146)),
        Location(name: "FOUR", description: "four",
                 coordinates: CLLocationCoordinate2D(latitude: 59.9338,
                                                     longitude: 30.3246)),
        Location(name: "FIVE", description: "five",
                 coordinates: CLLocationCoordinate2D(latitude: 59.9498,
                                                     longitude: 30.3146))
    ]
    
    private init() {}
}
