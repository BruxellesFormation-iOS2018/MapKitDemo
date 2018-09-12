//
//  ViewController.swift
//  MapKitDemo
//
//  Created by Florian Praile on 12/09/2018.
//  Copyright © 2018 Underside. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapview: MKMapView!
    
    let geoCoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapview.delegate = self
        
        self.addMapAnnotation(fromCoordinate: CLLocationCoordinate2D(latitude: 50.476925, longitude: 4.868806))
        
        
        let address = "Rue Royale 67, 1000 Bruxelles, Belgium"
        
        
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error{
                print(error)
            }else if let placemark = placemarks?.first, let coordinate = placemark.location?.coordinate{
                print(placemark)
                self.addMapAnnotation(fromCoordinate: coordinate)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addMapAnnotation(fromCoordinate coordinate: CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapview.addAnnotation(annotation)
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let coordinate = view.annotation?.coordinate else{
            return
        }
     
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error{
                print(error)
            }else if let placemark = placemarks?.first{
                print(placemark)
            }
        }
        
    }
    
    
    
    
}

