//
//  MapKitAppMVC.swift
//  MapKitApplication
//
//  Created by Kairat on 02.04.17.
//  Copyright © 2017 Kairat. All rights reserved.
//

import UIKit
import MapKit

class MapKitAppMVC{
    var listOfPlaces: [AnnotationOfPlace] = []
}

class AnnotationOfPlace{
    var nameOfPlace: String?
    var titleOfPlace: String?
    var coordinateOfPlace: CLLocationCoordinate2D
    init(name : String, title : String, coordinate : CLLocationCoordinate2D) {
        self.nameOfPlace = name
        self.titleOfPlace = title
        self.coordinateOfPlace = coordinate
    }
    
}
