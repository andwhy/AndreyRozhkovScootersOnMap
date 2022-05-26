//
//  VehiclesViewModel.swift
//  AndreyRozhkovScootersOnMap
//
//  Created by an.rozhkov on 24.05.2022.
//

import Foundation
import Combine
import CoreLocation

final class VehiclesViewModel: ObservableObject {
    
    let environment: VehiclesViewModelEnvironment
    private var cancellables = Set<AnyCancellable>()

    // MARK: Interface
    
    @Published var vehicles: [Vehicle] = []
    @Published var locationAuthStatus: CLAuthorizationStatus
    @Published var nearestVehicle: Vehicle?
    @Published var error: VehicleMapViewError?
    
    public func requestLocationAuth() {
        environment.requestLocationAuth()
    }

    // MARK: Lifecycle
    
    init(environment: VehiclesViewModelEnvironment) {
        self.environment = environment
        self.locationAuthStatus = environment.locationAuthStatus
        
        listenForVehiclesUpdate()
        processNearestVehicleUpdate()
    }
    
    private func listenForVehiclesUpdate() {
        environment.vehiclesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = VehicleMapViewError(serviceError: error)
                default:
                    break
                }
            } receiveValue: { [weak self] vehiclesObject in
                guard let self = self else { return }
                self.vehicles = vehiclesObject.data
        }
        .store(in: &cancellables)
    }
    
    private func processNearestVehicleUpdate() {
        Publishers.CombineLatest(
            $vehicles,
            environment.$userLocation
        )
        .throttle(for: .seconds(10), scheduler: DispatchQueue.main, latest: true)
        .receive(on: DispatchQueue.main)
        .sink { [weak self] vehicles, userLocation2D  in
            guard let self = self, let userLocation2D = userLocation2D else { return }
            let userLocation = CLLocation(latitude: userLocation2D.latitude, longitude: userLocation2D.longitude)
            let sortedVehicles = self.vehicles.map { vehicle in
                    VehicleWithDistance(vehicle: vehicle,
                                        distance: userLocation.distance(from: CLLocation(latitude: vehicle.attributes.lat, longitude: vehicle.attributes.lng))
                    )
                }
            self.nearestVehicle = sortedVehicles.first?.vehicle
        }
        .store(in: &cancellables)
    }
}

struct VehicleWithDistance {
    let vehicle: Vehicle
    let distance: Double
}
