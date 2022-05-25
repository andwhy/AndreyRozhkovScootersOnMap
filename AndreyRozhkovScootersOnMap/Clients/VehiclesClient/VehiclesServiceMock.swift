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
    
    private let vehiclesSubject = PassthroughSubject<Vehicles, Error>()
    
    public var vehicles: AnyPublisher<Vehicles, Error> {
        vehiclesSubject.eraseToAnyPublisher()
    }
    
    init() {
        vehiclesSubject.send(vehiclesMock)
    }
}
