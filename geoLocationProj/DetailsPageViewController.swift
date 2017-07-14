//
//  DetailsPageViewController.swift
//  geoLocationProj
//
//  Created by Luis Garcia on 7/14/17.
//  Copyright © 2017 GT. All rights reserved.
//

import UIKit
import MapKit

class DetailsPageViewController: UITableViewController {
    var locationManager = CLLocationManager()
    
    var delegate: tableViewDelegate?
    var thisLocation: EventLocation?

    @IBOutlet weak var locationView: MKMapView!
    
    @IBOutlet weak var detailsLabel: UILabel!
    @IBAction func returnToMap(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    let regionRadius: CLLocationDistance = 100
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius + 2.0, regionRadius * 2.0)
        locationView.setRegion(coordinateRegion, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: (thisLocation?.coordinate.latitude)!, longitude: (thisLocation?.coordinate.longitude)!)
        centerMapOnLocation(location: initialLocation)
        self.locationView.addAnnotation(thisLocation)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
