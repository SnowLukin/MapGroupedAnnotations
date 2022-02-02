//
//  MapGroupedAnnotationsApp.swift
//  MapGroupedAnnotations
//
//  Created by Snow Lukin on 26.01.2022.
//

import SwiftUI

@main
struct MapGroupedAnnotationsApp: App {
    
    @StateObject private var viewModel = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(viewModel)
        }
    }
}
