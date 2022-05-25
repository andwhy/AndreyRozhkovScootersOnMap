//
//  VehiclesMapView.swift
//  AndreyRozhkovScootersOnMap
//
//  Created by an.rozhkov on 23.05.2022.
//

import SwiftUI
import Combine
import MapKit

struct VehiclesMapView: View {
    
    let model: VehiclesViewModel
    @State var vehicles: [Vehicle] = []
    @State var showingSheet = false
    @State var nearesVehicle: Vehicle?
    
    var body: some View {
            MapViewUI(vehicle: vehicles)
            .ignoresSafeArea()
            .onAppear() {
                if model.locationAuthStatus == .notDetermined { // TODO: Do it more elegant way=)
                    model.requestLocationAuth()
                }
            }
            .onReceive(model.$vehicles) { vehicles in
                self.vehicles = vehicles
            }
            .onReceive(model.$nearestVehicle) { vehicle in
                nearesVehicle = vehicle
                showingSheet = vehicle != nil
            }
            .toast(isShowing: $showingSheet, contentView: {
                    return VehicleDetailView(vehicle: $nearesVehicle)
                }()
            )

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let vehicleServiceMock = VehiclesServiceMock()
        let locationClientMock = LocationClientMock()

        VehiclesMapView(model: VehiclesViewModel(environment: VehiclesViewModelEnvironment(
            vehiclesPublisher: vehicleServiceMock.vehicles,
            locationAuthStatus: locationClientMock.authorisationStatus,
            userLocation: locationClientMock.userLocation,
            requestLocationAuth: locationClientMock.requestLocationAuth)
        ))
    }
}
