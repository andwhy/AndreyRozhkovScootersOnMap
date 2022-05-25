//
//  VehicleDetailsView.swift
//  AndreyRozhkovScootersOnMap
//
//  Created by an.rozhkov on 25.05.2022.
//

import Foundation
import SwiftUI

struct VehicleDetailView: View {
    
    @Binding var vehicle: Vehicle?
    
    var body: some View {
        Group {
            HStack {
                Spacer()
                VStack {
                    if let vehicle = vehicle {
                        Image(systemName: vehicle.attributes.vehicleType.symbolName)
                            .font(Font.system(size: 30))
                            .frame(width: 30, height: 30)
                        Text("Nearest vehicle")
                            .font(.caption)
                            .foregroundColor(.gray)
                    } else {
                        EmptyView()
                    }
                }
                .padding()
                Spacer()
                VStack {
                    
                    Group {
                        if let vehicle = vehicle {
                            attributesText(text: "\(vehicle.attributes.vehicleType.rawValue.capitalized)", key: "vehicle type")
                            attributesText(text: "\(vehicle.attributes.batteryLevel)%", key: "battery level")
                            attributesText(text: "\(vehicle.attributes.maxSpeed) km/h" , key: "max speed")
                            Text(vehicle.attributes.hasHelmetBox ? "Has helmet": "Has no helmet")
                        } else {
                            EmptyView()
                        }
                    }
                }
                Spacer()
            }
            
            .padding()
        }
    }
    
    private func attributesText(text: String, key: String) -> some View {
        HStack {
            Text(key)
                .font(.caption)
                .foregroundColor(.gray)
            Text(text)
        }
        .padding(.bottom, 0.1)
    }
}
