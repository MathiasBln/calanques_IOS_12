//
//  MonAnnotationView.swift
//  Les Calanques
//
//  Created by Mathias Bouillon on 20/05/2020.
//  Copyright © 2020 Mathias Bouillon. All rights reserved.
//

import UIKit
import MapKit

class MonAnnotationView: MKAnnotationView {
    
    var controller: ControllerAvecCarte?
    
    //initialiser le controlleur pour utiliser un Segue
    init(controller: ControllerAvecCarte,annotation: MKAnnotation?, reuseIdentifier: String?) {
        self.controller = controller
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupAnnotation()
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupAnnotation()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAnnotation()
    }
    
    func setupAnnotation() {
        image = UIImage(named:"placeholder")
        canShowCallout = true
        
        
        //vue accesoire qu'on rajoute dans le pop-up
        leftCalloutAccessoryView = setupLeft()
        rightCalloutAccessoryView = setupRight()
        detailCalloutAccessoryView = setupCenter()
    }
    
    func setupLeft() -> UIButton{
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.setImage(UIImage(named: "distance"), for: .normal)
        button.addTarget(self, action: #selector(gps), for: .touchUpInside)
        return button
    }
    
    func setupRight() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.setImage(UIImage(named: "detail"), for: .normal)
        button.addTarget(self, action: #selector(detail), for: .touchUpInside)
        return button
    }
    
    func setupCenter() -> UIView? {
        guard let anno = annotation as? MonAnnotation else { return nil }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 125, height: 125))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 125).isActive = true
        view.heightAnchor.constraint(equalToConstant: 125).isActive = true
        
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = anno.calanque.image
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        return view
    }
    
    
    @objc func detail(){
        guard let anno = annotation as? MonAnnotation else { return }
        
        //controller?.toDetail(calanque: anno.calanque)
        
        NotificationCenter.default.post(name: Notification.Name("detail"), object: anno.calanque)
    }
    
    //Gestion du gps avec map
    @objc func gps(){
        guard let anno = annotation as? MonAnnotation else { return }
        let placemark = MKPlacemark(coordinate: anno.coordinate)
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        let map = MKMapItem(placemark: placemark)
        map.openInMaps(launchOptions: options)
    }
    
}
