//
//  MKMapWrapper.swift
//  AndreyRozhkovScootersOnMap
//
//  Created by an.rozhkov on 24.05.2022.
//

import SwiftUI
import MapKit

struct MapViewUI: UIViewRepresentable {

    //MARK: Constants
    
    private let regionRadius: CLLocationDistance = 2000
    private let coordinator = MapViewUICoordinator()

    let vehicle: [Vehicle]
    
    // MARK: UIViewRepresentable
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(
            MKCoordinateRegion(center: vehicle.averageСoordinate,
                               latitudinalMeters: regionRadius,
                               longitudinalMeters: regionRadius
                              ),
            animated: false)
        mapView.addAnnotations(vehicle)
        mapView.delegate = coordinator
        mapView.showsUserLocation = true
        mapView.isRotateEnabled = false
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.addAnnotations(vehicle)
        mapView.setRegion(
            MKCoordinateRegion(center: vehicle.averageСoordinate,
                               latitudinalMeters: regionRadius,
                               longitudinalMeters: regionRadius
                              ),
            animated: false)
        mapView.showsUserLocation = true
        mapView.delegate = coordinator
    }
}
