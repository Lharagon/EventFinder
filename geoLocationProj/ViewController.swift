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
        annotation.coordinate = CLLocationCoordinate2D(latitude: 11.12, longitude: 12.11)
        mapView.addAnnotation(annotation)
        
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


}

