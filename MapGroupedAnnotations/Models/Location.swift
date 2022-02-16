//
//  Location.swift
//  MapGroupedAnnotations
//
//  Created by Snow Lukin on 26.01.2022.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
    let name: String
    let description: String
    let coordinates: CLLocationCoordinate2D
    
    var isChosenForClustering = false
    // Array of annotations for cluster
    var annotationsToCluster: [Location] = []
    
    // Identifiable
    let id = UUID().uuidString
    
    // Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
