//
//  CustomAnnotation.swift
//  EarthMap
//
//  Created by Bauyrzhan on 30.03.17.
//  Copyright © 2017 Bauyrzhan. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var bar: UIBarButtonItem?
    
    init(coordinate: CLLocationCoordinate2D, title: String!, subtitle: String!) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
