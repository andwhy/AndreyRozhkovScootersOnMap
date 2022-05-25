//
//  VehiclesViewModelEnvironment.swift
//  AndreyRozhkovScootersOnMap
//
//  Created by an.rozhkov on 25.05.2022.
//

import Foundation
import Combine
import CoreLocation

final class VehiclesViewModelEnvironment: ObservableObject {
    
    let vehiclesPublisher: AnyPublisher<Vehicles, VehicleServiceError>
    @Published var locationAuthStatus: CLAuthorizationStatus // TODO: Wrap it as plain object
    @Published var userLocation: CLLocationCoordinate2D? // TODO: Wrap it as plain object
    let requestLocationAuth: () -> Void
    
    init(
        vehiclesPublisher: AnyPublisher<Vehicles, VehicleServiceError>,
        locationAuthStatus: CLAuthorizationStatus,
        userLocation: CLLocationCoordinate2D?,
        requestLocationAuth: @escaping () -> Void
    ) {
        self.vehiclesPublisher = vehiclesPublisher
        self.locationAuthStatus = locationAuthStatus
        self.userLocation = userLocation
        self.requestLocationAuth = requestLocationAuth
    }
}
