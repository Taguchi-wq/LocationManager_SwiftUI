//
//  SplashView.swift
//  LocationManager_SwiftUI
//
//  Created by cmStudent on 2021/10/23.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isLoading = true
    @ObservedObject private var locationManager = LocationManager()
    
    var body: some View {
        if isLoading {
            VStack {
                Text("SplashView")
                    .padding()
            }
            .background(Color.red)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
//                        isLoading = false
                        locationManager.checkLocationServicesEnabled()
                    }
                }
            }
            .onReceive(locationManager.$authorizationStatus) { value in
                if value != 0 {
                    isLoading = false
                }
            }
        } else {
            ContentView()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
