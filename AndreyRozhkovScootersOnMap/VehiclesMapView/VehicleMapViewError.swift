//
//  VehicleMapViewError.swift
//  AndreyRozhkovScootersOnMap
//
//  Created by an.rozhkov on 25.05.2022.
//

import Foundation

enum VehicleMapViewError: Error {
    case noData // TODO: Improve error handling
}

extension VehicleMapViewError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noData:
            return "Can't load a vehicles"
        }
    }
}

extension VehicleMapViewError {
    init(serviceError: VehicleServiceError) {
        switch serviceError {
        default:
            self = .noData // TODO: Improve error handling
        }
    }
}
