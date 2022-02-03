//
//  LocationViewModel.swift
//  MapGroupedAnnotations
//
//  Created by Snow Lukin on 26.01.2022.
//

import SwiftUI
import MapKit

class LocationsViewModel: ObservableObject {
    
    // All locations
    @Published var locations: [Location]
    
    // Current location
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    // Filtered locations
    @Published var filteredLocations: [Location]
    
    @Published var mapRegion = MKCoordinateRegion()
    @Published var mapSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    private let errorLocation = Location(name: "ERROR",
                                         description: "error",
                                         coordinates: CLLocationCoordinate2D(latitude: 50,
                                                                             longitude: 30))
    
    init() {
        let locations = LocationsDataSevice.shared
        self.locations = locations
        self.filteredLocations = locations
        self.mapLocation = locations.first ?? errorLocation
        self.updateMapRegion(location: locations.first ?? errorLocation)
    }
    
}

// MARK: Cluster Annotations
extension LocationsViewModel {
    
    // TODO: - Improvement Needed
    func clusterAnnotations(zoom: CLLocationDegrees) {
        var locations = locations
        
        for locationIndex in 0..<locations.count {
            locations[locationIndex].annotationsToCluster.removeAll()
            locations[locationIndex].isChosenForClustering = false
        }
        
        for locationIndex in 0..<locations.count - 1 {
            
            if locations[locationIndex].isChosenForClustering {
                break
            }
            
            for nextLocationIndex in locationIndex + 1..<locations.count {
                if abs(locations[nextLocationIndex].coordinates.latitude - locations[locationIndex].coordinates.latitude) * 10 <= zoom &&
                    abs(locations[nextLocationIndex].coordinates.longitude - locations[locationIndex].coordinates.longitude) * 10 <= zoom {
                    
                    if !locations[nextLocationIndex].isChosenForClustering {
                        locations[nextLocationIndex].isChosenForClustering = true
                        locations[locationIndex].annotationsToCluster.append(locations[nextLocationIndex])
                        locations[nextLocationIndex].annotationsToCluster.append(locations[locationIndex])
                    }
                }
            }
        }
        
        filteredLocations.removeAll()
        clusterAnnotations(locations: locations, resultArray: &filteredLocations)
    }
    
    private func clusterAnnotations(locations: [Location], resultArray: inout [Location]) {
        
        if locations.isEmpty {
            return
        }
        
        var locations = locations
        
        // First location
        guard let location = locations.first else { return }
        
        // First's location coordinates
        var coordinates = CLLocationCoordinate2D(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude)
        
        // sum of all closed locations
        for closeLocation in location.annotationsToCluster {
            coordinates.latitude += closeLocation.coordinates.latitude
            coordinates.longitude += closeLocation.coordinates.longitude
        }
        coordinates.latitude /= Double(location.annotationsToCluster.count + 1)
        coordinates.longitude /= Double(location.annotationsToCluster.count + 1)
        
        // New location from close locations
        let newLocation = Location(name: "", description: "", coordinates: coordinates)
        
        resultArray.append(newLocation)
        locations.remove(at: 0)
        locations.removeAll(where: { location.annotationsToCluster.contains($0) })
        return clusterAnnotations(locations: locations, resultArray: &resultArray)
    }
}

// MARK: Private Methods
extension LocationsViewModel {
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan
            )
        }
    }
}
