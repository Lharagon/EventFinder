//
//  ViewController.swift
//  geoLocationProj
//
//  Created by Luis Garcia on 7/13/17.
//  Copyright © 2017 GT. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    var startingPoint: CLLocation?
    let annotation = MKPointAnnotation()
    let geocoder = CLGeocoder()
    var locations: [String] = ["711 Country Club Dr, Burbank, CA 91501-1123, United States", "Wildwood Canyon Park  1701 Wildwood Canyon, Burbank, CA. 91501"]
    var pinPoints: [CLLocationCoordinate2D] = []
    
    
    
//    let geoCoder = CLGeocoder().geocodeAddressString(String, completionHandler: <#T##CLGeocodeCompletionHandler##CLGeocodeCompletionHandler##([CLPlacemark]?, Error?) -> Void#>)
//    let currentLoxation =
    
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius + 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    var locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 1
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            let initialLocation = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
            startingPoint = initialLocation
            
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let lastLocation = locations.last!
//        print("This is the lat ", lastLocation.coordinate.latitude)
//        print("This is the long ", lastLocation.coordinate.longitude)
//        
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for location in locations {
            var counter = ""
            print(location)
        geocoder.geocodeAddressString(location) {
            (placemarks, error) in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            print("Lat: \(String(describing: lat)), Lon: \(String(describing: lon))")
            
//            guard let lati = lat else { return }
//            guard let long = lon else { return }
////          
//            if lati is CLLocation && long is Double {
            self.annotation.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
            self.mapView.addAnnotation(self.annotation)
            counter += "Second"
            print(counter)
            
//                self.pinPoints.append(self.annotation.coordinate)
////            }`
//            self.annotation.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
//            self.pinPoints.append(self.annotation.coordinate)
        }
            counter += "First"
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
        centerMapOnLocation(location: startingPoint!)
        
    }
//
    
    let address = "1 Infinite Loop, Cupertino, CA 95014"

}

