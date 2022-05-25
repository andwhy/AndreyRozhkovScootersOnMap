//
//  LocationClient.swift
//  AndreyRozhkovScootersOnMap
//
//  Created by an.rozhkov on 25.05.2022.
//

import Foundation
import CoreLocation

final class LocationClient: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    @Published var authorisationStatus: CLAuthorizationStatus = .notDetermined
    
    @Published var userLocation: CLLocationCoordinate2D?

    
    override init() {
        super.init()
        self.locationManager.delegate = self
        startUpdatingLocation()
    }

    public func requestAuthorisation() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    private func startUpdatingLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        }
    }
}

extension LocationClient: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorisationStatus = status
        startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location?.coordinate else {
            return
        }
        userLocation = location
    }
}
