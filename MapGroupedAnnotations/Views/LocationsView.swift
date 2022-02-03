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
                viewModel.clusterAnnotations(zoom: newValue)
            }
            .onChange(of: viewModel.mapRegion.span.longitudeDelta) { newValue in
                viewModel.clusterAnnotations(zoom: newValue)
                
            }
    }
}
