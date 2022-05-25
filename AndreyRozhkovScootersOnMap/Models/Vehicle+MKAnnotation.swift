//
//  VehiclesObjectWrap.swift
//  AndreyRozhkovScootersOnMap
//
//  Created by an.rozhkov on 25.05.2022.
//

import Foundation
import MapKit

extension Vehicle: MKAnnotation {
    var title: String? { attributes.vehicleType.rawValue.capitalized }
    var subtitle: String? { "Battery: \(attributes.batteryLevel)%" }
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: attributes.lat,
            longitude: attributes.lng
        )
    }
}

extension Array where Element == Vehicle {
    var averageСoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: getAverage(map { $0.attributes.lat }),
            longitude: getAverage(map { $0.attributes.lng }))
        
    }
    
    private func getAverage(_ locationDegrees: [Double]) -> Double {
        locationDegrees.reduce(0.0) {
            return $0 + $1/Double(locationDegrees.count)
        }
    }
}

extension VehicleType {
    var color: UIColor {
        switch self {
        case .ebicycle:
            return UIColor.green
        case .emoped:
            return UIColor.red
        case .escooter:
            return UIColor.blue
        }
    }
    
    var symbolName: String {
        switch self {
        case .ebicycle:
            return "bicycle"
        case .emoped:
            return "speedometer"
        case .escooter:
            return "scooter"
        }
    }
    
    var glyphImage: UIImage {
        UIImage(systemName: symbolName)!
    }
}
