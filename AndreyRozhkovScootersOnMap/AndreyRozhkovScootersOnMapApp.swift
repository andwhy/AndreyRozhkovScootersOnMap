//
//  AndreyRozhkovScootersOnMapApp.swift
//  AndreyRozhkovScootersOnMap
//
//  Created by an.rozhkov on 23.05.2022.
//

import SwiftUI

@main
struct AndreyRozhkovScootersOnMapApp: App {
    
    let appEnvironment = AppEnvironment()
    
    var body: some Scene {
        WindowGroup {
            VehiclesMapView(model: VehiclesViewModel(environment: VehiclesViewModelEnvironment(
                vehiclesPublisher: appEnvironment.vehicleService.vehicles,
                locationAuthStatus: appEnvironment.locationClient.authorisationStatus,
                userLocation: appEnvironment.locationClient.userLocation,
                requestLocationAuth: appEnvironment.locationClient.requestAuthorisation)
            ))
        }
    }
}
