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
    let locale: String
    let eventDescription: String
    let coordinate: CLLocationCoordinate2D
    
    init(locale: String, eventDescription: String, coordinate: CLLocationCoordinate2D) {
        
        self.locale = locale
        self.eventDescription = eventDescription
        self.coordinate = coordinate
        
        super.init()
    }
}
