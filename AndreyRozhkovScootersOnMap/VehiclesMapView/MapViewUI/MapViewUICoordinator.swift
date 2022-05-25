//
//  MKMapCoordinator.swift
//  AndreyRozhkovScootersOnMap
//
//  Created by an.rozhkov on 25.05.2022.
//

import Foundation
import MapKit

final class MapViewUICoordinator: NSObject, MKMapViewDelegate {

    enum ClusterReuseIdentifier: String {
        case ebicycle = "ebicycle"
        case emoped = "emoped"
        case escooter = "escooter"
        
        init(vehicleType: VehicleType) {
            switch vehicleType {
            case .ebicycle: self = .ebicycle
            case .emoped: self = .emoped
            case .escooter: self = .escooter
            }
        }
    }
    
    enum AnnotationReuseIdentifier: String {
        case cluster = "cluster"
        case vehicle = "vehicle"
    }
    
    // MARK: MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        switch annotation {
        case let cluster as MKClusterAnnotation:
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationReuseIdentifier.cluster.rawValue) as? MKMarkerAnnotationView
            ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: AnnotationReuseIdentifier.cluster.rawValue)
            
            for clusterAnnotation in cluster.memberAnnotations {
              if let vehicle = clusterAnnotation as? Vehicle {
                  annotationView.markerTintColor = vehicle.attributes.vehicleType.color
                  break
              }
            }
            annotationView.titleVisibility = .visible
            return annotationView
            
        case let vehicle as Vehicle:
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationReuseIdentifier.vehicle.rawValue) as? MKMarkerAnnotationView
            ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: AnnotationReuseIdentifier.vehicle.rawValue)
            
            setupVehicleAnnotationView(annotationView, vehicle: vehicle)
            return annotationView
        default:
            return nil
        }
    }
    
    //MARK: Private
    
    private func setupVehicleAnnotationView(_ annotation: MKMarkerAnnotationView, vehicle: Vehicle) {
        annotation.canShowCallout = true
        annotation.glyphImage = vehicle.attributes.vehicleType.glyphImage
        annotation.clusteringIdentifier = ClusterReuseIdentifier(vehicleType: vehicle.attributes.vehicleType).rawValue
        annotation.markerTintColor = vehicle.attributes.vehicleType.color
        annotation.titleVisibility = .visible
        annotation.subtitleVisibility = .adaptive
    }
}
