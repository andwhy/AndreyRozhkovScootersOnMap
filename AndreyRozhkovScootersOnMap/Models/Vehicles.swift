//
//  Vehicle.swift
//  AndreyRozhkovScootersOnMap
//
//  Created by an.rozhkov on 23.05.2022.
//

import Foundation
import MapKit

// MARK: - Vehicles
class Vehicles: Codable {
    let data: [Vehicle]
    
    init(data: [Vehicle]) {
        self.data = data
    }
}

// MARK: - Datum
class Vehicle: NSObject, Codable, Identifiable {
    let id: String
    let attributes: Attributes
    
    init(
        id: String,
        attributes: Attributes
    ) {
        self.id = id
        self.attributes = attributes
    }
}

// MARK: - Attributes
struct Attributes: Codable {
    let batteryLevel: Int
    let lat, lng: Double
    let maxSpeed: Int
    let vehicleType: VehicleType
    let hasHelmetBox: Bool
}

enum VehicleType: String, Codable {
    case ebicycle = "ebicycle"
    case emoped = "emoped"
    case escooter = "escooter"
}


