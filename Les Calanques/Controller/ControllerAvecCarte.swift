//
//  ControllerAvecCarte.swift
//  Les Calanques
//
//  Created by Mathias Bouillon on 18/05/2020.
//  Copyright © 2020 Mathias Bouillon. All rights reserved.
//

import UIKit
import MapKit

class ControllerAvecCarte: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    
    var calanques: [Calanque] = CalanqueCollection().all()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        addAnnotations()
        NotificationCenter.default.addObserver(self, selector: #selector(notifDetail), name: Notification.Name("detail"), object: nil)
    }
    
    
    func toDetail(calanque: Calanque) {
        performSegue(withIdentifier: "Detail", sender: calanque)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail"{
            if let controller = segue.destination as? DetailController{
                controller.calanqueRecue = sender as? Calanque
            }
        }
    }
    
    func addAnnotations() {
        for calanque in calanques {
            
            //annotation de base
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = calanque.coordonee
//            annotation.title = calanque.nom
//            mapView.addAnnotation(annotation)
            
            
            //annotation custom
            let annotation = MonAnnotation(calanque)
            mapView.addAnnotation(annotation)
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "reuseID"
        
        //Vérifier que ce ne soit pas l'utilisateur
        if annotation.isKind(of: MKUserLocation.self){
            return nil
        }
        
        if let anno = annotation as? MonAnnotation{
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
           
            if annotationView == nil{
                
            //Override
                //annotationView = MonAnnotationView(annotation: anno, reuseIdentifier: reuseIdentifier)
                
                annotationView = MonAnnotationView(controller: self, annotation: anno, reuseIdentifier: reuseIdentifier)
                
                
            //Version classique
//                annotationView = MKAnnotationView(annotation: anno, reuseIdentifier: reuseIdentifier)
//                annotationView?.image = UIImage(named: "placeholder")
//                annotationView?.canShowCallout = true
                return annotationView
            } else {
                return annotationView
            }
        }
        
        return nil
    }
    
    
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: mapView.mapType = MKMapType.standard
        case 1 : mapView.mapType = .satellite
        case 2: mapView.mapType = .hybrid
        default: break
        }
    }
    @IBAction func getPosition(_ sender: Any) {
    }
    
    
    @objc func notifDetail(notification: Notification) {
        if let calanque = notification.object as? Calanque {
            print("J'ai une calanque")
            toDetail(calanque: calanque)
        }
    }
    
}
