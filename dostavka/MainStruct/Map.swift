//
//  Map.swift
//  dostavka
//
//  Created by Artem Vorobev on 21.06.2022.
//

import SwiftUI
import UIKit
import RealmSwift
import YandexMapsMobile
import CoreLocation



class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {

    // Publish the user's location so subscribers can react to updates
    @Published var lastKnownLocation: CLLocation? = nil
    private let manager = CLLocationManager()

    override init() {
        super.init()
        self.manager.delegate = self
        self.manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Notify listeners that the user has a new location
        self.lastKnownLocation = locations.last
    }
}


    
struct Map: UIViewRepresentable {
    
    @ObservedObject var locationManager = LocationManager()
    
    func makeUIView(context: Context) -> YMKMapView {
        
        YMKMapKit.setApiKey("141a58ff-85cc-45c5-82f1-7e39122782bc")
        YMKMapKit.sharedInstance().onStart()
        
        
        let mapView = YMKMapView()
        
        mapView.mapWindow.map.move(
            with: YMKCameraPosition.init(target: YMKPoint(latitude: 59.953570, longitude: 30.264660), zoom: 15, azimuth: 0, tilt: 0),
                animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
                cameraCallback: nil)
        
//        let userLocationViewController = UserLocationViewController()
//
//                let mapKit = YMKMapKit.sharedInstance()
//        let userLocationLayer = mapKit.createUserLocationLayer(with: (mapView?.mapWindow)!)
//                userLocationLayer.setVisibleWithOn(true)
//                userLocationLayer.isHeadingEnabled = true
//                userLocationLayer.setObjectListenerWith(userLocationViewController)
        
        
        return mapView

    }
    
    
    func updateUIView(_ mapView: YMKMapView, context: Context) {
        if let myLocation = locationManager.lastKnownLocation {
                   centerMapLocation(target: YMKPoint(latitude: myLocation.coordinate.latitude, longitude: myLocation.coordinate.longitude), map: mapView )
                   print("User's location: \(myLocation)")
               }
        
        func centerMapLocation(target location: YMKPoint?, map: YMKMapView) {
               guard let location = location else { print("Failed to get user location"); return }
               
               map.mapWindow.map.move(
                   with: YMKCameraPosition(target: location, zoom: 18, azimuth: 0, tilt: 0),
                   animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5)
               )
    }
  
}
}

