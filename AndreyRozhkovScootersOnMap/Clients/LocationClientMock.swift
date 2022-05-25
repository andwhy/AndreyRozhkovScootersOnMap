//
//  LocationClientMock.swift
//  AndreyRozhkovScootersOnMap
//
//  Created by an.rozhkov on 25.05.2022.
//

import Foundation
import Combine
import CoreLocation

class LocationClientMock: ObservableObject {
    @Published var authorisationStatus: CLAuthorizationStatus = .notDetermined
    @Published var userLocation: CLLocationCoordinate2D?
    
    public func requestLocationAuth() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.authorisationStatus = .authorizedWhenInUse
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
            self?.userLocation = CLLocationCoordinate2D(latitude: 52.475785, longitude: 13.326359)
        }
    }
}
