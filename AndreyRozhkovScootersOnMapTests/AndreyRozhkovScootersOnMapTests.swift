//
//  AndreyRozhkovScootersOnMapTests.swift
//  AndreyRozhkovScootersOnMapTests
//
//  Created by an.rozhkov on 23.05.2022.
//

import XCTest
import Combine

class AndreyRozhkovScootersOnMapTests: XCTestCase {

    let expectation = XCTestExpectation()
    var cancellables = Set<AnyCancellable>()
    
    let vehicleServiceMock = VehiclesServiceMock()
    let locationClientMock = LocationClientMock()

    lazy var vehiclesViewModel = VehiclesViewModel(environment: VehiclesViewModelEnvironment(
        vehiclesPublisher: vehicleServiceMock.vehicles,
        locationAuthStatus: locationClientMock.authorisationStatus,
        userLocation: locationClientMock.userLocation,
        requestLocationAuth: locationClientMock.requestLocationAuth)
    )
    
    func testModelVehicles() throws {
        vehiclesViewModel.$vehicles
            .dropFirst()
            .eraseToAnyPublisher()
            .sink { vehicles in
            XCTAssert(vehicles == [Vehicle.mock])
            self.expectation.fulfill()
        }
        .store(in: &cancellables)
        
        vehiclesViewModel.$nearestVehicle // TODO: Test distance calculation by passing few models
            .eraseToAnyPublisher()
            .filter { $0 != nil }
            .eraseToAnyPublisher()
            .sink { nearestVehicle in
                XCTAssert(nearestVehicle! == Vehicle.mock)
                self.expectation.fulfill()
        }
        .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 15)
    }
}
