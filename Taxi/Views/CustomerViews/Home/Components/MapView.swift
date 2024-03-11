//
//  MapView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 27.02.24.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var startCoordinate: CLLocationCoordinate2D?
    @Binding var endCoordinate: CLLocationCoordinate2D?
    @Binding var distance: CLLocationDistance

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        // Entferne alte Overlays
        uiView.removeOverlays(uiView.overlays)
        
        // Entferne alte Stecknadeln
        uiView.removeAnnotations(uiView.annotations)
        
        
        let directionRequest = MKDirections.Request()
        
        if let startCoordinate = startCoordinate {
            let sourcePlacemark = MKPlacemark(coordinate: startCoordinate)
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            
            directionRequest.source = sourceMapItem
        } else {
            return
        }
        
        if let endCoordinate = endCoordinate {
            let destinationPlacemark = MKPlacemark(coordinate: endCoordinate)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            directionRequest.destination = destinationMapItem
        } else {
            return
        }

        directionRequest.transportType = .automobile

        let directions = MKDirections(request: directionRequest)
        directions.calculate { [self] (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Error getting directions: \(error.localizedDescription)")
                }
                return
            }

            let route = response.routes[0]
            uiView.addOverlay(route.polyline, level: .aboveRoads)

            let rect = route.polyline.boundingMapRect
            uiView.setRegion(MKCoordinateRegion(rect), animated: true)

            // Berechne die Distanz zwischen den Koordinaten und aktualisiere die Entfernung
            self.calculateDistance(start: startCoordinate!, end: endCoordinate!)
        }

        // Füge Stecknadeln für Start- und Zielpunkt hinzu
        let startAnnotation = MKPointAnnotation()
        startAnnotation.coordinate = startCoordinate!
        startAnnotation.title = "Start"
        uiView.addAnnotation(startAnnotation)

        let endAnnotation = MKPointAnnotation()
        endAnnotation.coordinate = endCoordinate!
        endAnnotation.title = "Ziel"
        uiView.addAnnotation(endAnnotation)
    }

    func calculateDistance(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D) {
        let startLocation = CLLocation(latitude: start.latitude, longitude: start.longitude)
        let endLocation = CLLocation(latitude: end.latitude, longitude: end.longitude)
        let distanceInMeters = startLocation.distance(from: endLocation)
        distance = distanceInMeters
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 5.0
            return renderer
        }
    }
}
