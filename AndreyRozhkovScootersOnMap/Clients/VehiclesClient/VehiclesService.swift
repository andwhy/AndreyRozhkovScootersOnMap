//
//  VehiclesService.swift
//  AndreyRozhkovScootersOnMap
//
//  Created by an.rozhkov on 23.05.2022.
//

import Foundation
import Combine
import MapKit

class VehiclesService: ObservableObject {
    
    // MARK: Properties
    
    // TODO: Pass url as a property
    private let url = URL(string: "https://takehometest-production-takehometest.s3.eu-central-1.amazonaws.com/public/take_home_test_data.json")!
    
    private var cancellables = Set<AnyCancellable>() //TODO: Remove
    
    // MARK: Interface
    
    public var vehicles: AnyPublisher<Vehicles, Error> {
        fetchData(url: url)
    }
    
    // MARK: Network Request
    
    private func fetchData(url: URL) -> AnyPublisher<Vehicles, Error> { // TODO: Handle errors, use separate network service
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Vehicles.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
