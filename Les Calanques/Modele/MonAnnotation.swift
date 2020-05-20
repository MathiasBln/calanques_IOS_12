//
//  MonAnnotation.swift
//  Les Calanques
//
//  Created by Mathias Bouillon on 20/05/2020.
//  Copyright © 2020 Mathias Bouillon. All rights reserved.
//

import UIKit
import MapKit

class MonAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var calanque: Calanque
    var title: String?
    
    init(_ calanque: Calanque) {
        self.calanque = calanque
        coordinate = self.calanque.coordonee
        title = self.calanque.nom
    }
    
    
}
