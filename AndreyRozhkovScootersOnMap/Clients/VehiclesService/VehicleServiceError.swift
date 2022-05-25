//
//  VehicleServiceError.swift
//  AndreyRozhkovScootersOnMap
//
//  Created by an.rozhkov on 25.05.2022.
//

import Foundation

enum VehicleServiceError: Error {
    case notConnectedToInternet
    case decodingFailed
    case requestFailed
}
