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

class ViewController: UIViewController, CLLocationManagerDelegate, tableViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    var startingPoint: CLLocation?
//    let annotation = MKPointAnnotation()
    let geocoder = CLGeocoder()
    
    var pinPoints: [EventLocation] = []
    
    
    @IBAction func segueToListView(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toListView", sender: sender)
    }
    
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let tableViewController = navigationController.topViewController as! TableViewController
        tableViewController.delegate = self
        tableViewController.passedInLocations = pinPoints
        
    }
    
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
    
    func retrieveThePoints() {
        
        
        
        let FBtoken: String = "EAAbDO1iQ2IUBAOpggSiNZAQhaXi0qSDyk6iGKU4ZAhhWRzAZAP2pFCsvw9a9oTnayj11La4x8AAVoN4qz5TbWTrlCd0VAZBI36zBZCaSuOAdeprZAZCq5dQ6hRUWvxzImxRHCecxwNPu1kLmayZA4rTZBmT2iS8LFAAC8fokePfmDWpFBefAJXR9exTnmjGP2Fx0ZD"
        
        let urlString = "https://graph.facebook.com/search?q=91504&type=event&distance=1000&access_token=" + FBtoken
        
        guard let requestUrl = URL(string:urlString) else { return }
        let request = URLRequest(url:requestUrl)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error == nil {
                do {
                    if let data = data {
                        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                        let events = json?["data"] as? [[String: Any]]
                        
                        for event in events! {
                            print("****************")
                            
                            
                            print(event["name"]!)
                            print(event["start_time"]!)
                            print(event["end_time"]!)
                            if let location = event["place"] as? [String: Any] {
                                print(location["name"]!)
                                
                                var point: [String:Double] = [
                                    "lat": 0,
                                    "lng": 0
                                ]
                                
                                let Gtooken: String = "AIzaSyBYZVo3dC-d-MOkgEkchiKCQ9sRNDyhVYo"
                                let GrawString = "https://maps.googleapis.com/maps/api/geocode/json?address=\(String(describing: location["name"]!))&key=\(Gtooken)"
                                
                                // let  = "https://maps.googleapis.com/maps/api/geocode/json?address=Cinecert+LLC+2840+N+Lima+St+Burbank,+CA+91504&key=AIzaSyBYZVo3dC-d-MOkgEkchiKCQ9sRNDyhVYo"
                                
                                
                                
                                let GurlString = GrawString.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
                                print(GurlString)
                                guard let requestGurl = URL(string:GurlString) else { return }
                                let Grequest = URLRequest(url: requestGurl)
                                let Gtask = URLSession.shared.dataTask(with: Grequest) {
                                    ( data, response, error ) in
                                    if error == nil {
                                        // You have Data
                                        // Data Format
                                        do {
                                            if let data = data {
                                                if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                                                    if let results = json["results"] {
                                                        let resultArray = results as! NSArray
                                                        if let object = resultArray.firstObject as? NSDictionary {
                                                            if let geoLocation = object["geometry"] as? NSDictionary {
                                                                if let locale = geoLocation["location"] as? NSDictionary {
                                                                    print("this after JSON Serialization: \(locale)")
                                                                    point["lat"] = locale["lat"]! as? Double
                                                                    point["lng"] = locale["lng"]! as? Double
                                                                    print("this is our point\(point)")
                                                                    
                                                                    let mainEvent = EventLocation(title: (event["name"]! as AnyObject).string, eventDescription: (event["description"]! as AnyObject).string, coordinate: CLLocationCoordinate2D(latitude: Double(point["lat"]!), longitude: Double(point["lng"]!)))
                                            
                                    
                                                                    self.mapView.addAnnotation(mainEvent)
                                                                    
                                                                    
                                                                    
                                                                    
                                                                    print("*******")
                                                                }
                                                                
                                                            }
                                                            
                                                        }
                                                    }
                                                }
                                            }
                                            
                                        } catch {
                                            print("\(error)")
                                        }
                                    } else  {
                                        print("\(String(describing: error))")
                                    }
                                }
                                Gtask.resume()
                                
                            }
                        }
                    }
                } catch {
                    print("Error deserializing JSON: \(error)")
                }
            }
        }
        task.resume()
        
        
        
        
//        var lati = 21.283921
//        var longi = -157.831661
//        for _ in 0...10 {
//            let mainEvent = EventLocation(title: "Farm", eventDescription: "Nothing but fun and games at the farm", coordinate: CLLocationCoordinate2D(latitude: lati, longitude: longi))
//            pinPoints.append(mainEvent)
//            lati += 5
//            longi += 5
//        }
//        
//        
//        
        
    
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self

        retrieveThePoints()
        mapView.addAnnotations(pinPoints)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
        centerMapOnLocation(location: startingPoint!)
        print("This is pinPoints ", pinPoints)
        self.mapView.addAnnotations(pinPoints)
        
    }
    
    func cancelbuttonPressed(by controller: TableViewController) {
        dismiss(animated: true, completion: nil)
    }
    

}

