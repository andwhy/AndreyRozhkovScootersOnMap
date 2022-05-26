//
//  VehiclesServiceMock.swift
//  AndreyRozhkovScootersOnMap
//
//  Created by an.rozhkov on 25.05.2022.
//

import Foundation
import Combine

class VehiclesServiceMock: ObservableObject {
    
    private let vehiclesMock = Vehicles(data: [Vehicle.mock])
    
    private let vehiclesSubject = PassthroughSubject<Vehicles, VehicleServiceError>()
    
    public var vehicles: AnyPublisher<Vehicles, VehicleServiceError> {
        vehiclesSubject.eraseToAnyPublisher()
    }
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            guard let self = self else { return }
            self.vehiclesSubject.send(self.vehiclesMock)
        }
    }
}
