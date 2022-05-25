//
//  VehicleMock.swift
//  AndreyRozhkovScootersOnMap
//
//  Created by an.rozhkov on 25.05.2022.
//

import Foundation

extension Vehicle {
    static var mock: Vehicle {
        Vehicle(id: "1", attributes: Attributes(batteryLevel: 10, lat: 52.475785, lng: 13.326359, maxSpeed: 20, vehicleType: .escooter, hasHelmetBox: false))
    }
}
