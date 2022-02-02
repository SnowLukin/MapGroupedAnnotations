//
//  ContentView.swift
//  MapGroupedAnnotations
//
//  Created by Snow Lukin on 26.01.2022.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    
    var body: some View {
        mapLayer
            .ignoresSafeArea()
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .previewDevice("iPhone 13 Pro")
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsView {
    private var mapLayer: some View {
        Map(coordinateRegion: $viewModel.mapRegion,
            annotationItems: viewModel.filteredLocations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .shadow(radius: 10)
                    .onTapGesture {
                        print(location.coordinates)
                    }
            }
        })
            .onChange(of: viewModel.mapRegion.span.latitudeDelta) { newValue in
//                print("lat")
//                print(newValue)
                viewModel.clusterAnnotations(zoom: newValue)
            }
            .onChange(of: viewModel.mapRegion.span.longitudeDelta) { newValue in
//                print("long")
//                print(newValue)
                viewModel.clusterAnnotations(zoom: newValue)
                
            }
    }
}

// MARK: - Test 1
// 1st target = latitude: 59.9398, longitude: 30.3146
// 2nd target = latitude: 59.9368, longitude: 30.3146
// difference:
// lat: 0.0030, long: 0.0
// span to group:
// lat
// 0.042127
// long
// 0.042977

// MARK: - Test 2
// 1st target = latitude: 59.9398, longitude: 30.326
// 2nd target = latitude: 59.9338, longitude: 30.3246
// Difference:
// lat: 0.0060, long: 0.0014
// Span to group:
// lat: 0.086945
// long: 0.088721
