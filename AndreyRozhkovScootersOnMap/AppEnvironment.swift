//
//  AppEnvironment.swift
//  AndreyRozhkovScootersOnMap
//
//  Created by an.rozhkov on 25.05.2022.
//

import Foundation

struct AppEnvironment { // TODO: use some builder for init
    public let vehicleService = VehiclesService()
    public let locationClient = LocationClient()
}
