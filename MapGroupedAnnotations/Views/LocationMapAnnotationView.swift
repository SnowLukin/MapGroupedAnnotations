//
//  LocationMapAnnotationView.swift
//  MapGroupedAnnotations
//
//  Created by Snow Lukin on 26.01.2022.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(.blue)
                .clipShape(Circle())
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 10)
                .font(.headline)
                .foregroundColor(.blue)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                // Making annotation to be right above the actual location
                .padding(.bottom, 40)
        }
    }
}

struct LocationMapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapAnnotationView()
            .environmentObject(LocationsViewModel())
    }
}
