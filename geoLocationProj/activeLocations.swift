//
//  activeLocations.swift
//  geoLocationProj
//
//  Created by Luis Garcia on 7/13/17.
//  Copyright © 2017 GT. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class EventLocation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let eventDescription: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, eventDescription: String, coordinate: CLLocationCoordinate2D) {
        
        self.title = title
        self.eventDescription = eventDescription
        self.coordinate = coordinate
        self.subtitle = eventDescription
        
        super.init()
        
    }
}
