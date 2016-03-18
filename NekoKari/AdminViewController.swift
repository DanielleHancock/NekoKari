//
//  AdminViewController.swift
//  NekoKari
//
//  Created by Lisa Sun on 3/16/16.
//  Copyright © 2016 Lisa Sun. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AdminViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    @IBAction func logOutDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("adminToLogin", sender: self)
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    var previousLocation : CLLocation!
    
    var latitude = 0.0;
    var longitude = 0.0;
    
    //Declare Class Variable
    
    let shareData = ShareData.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //On loading the screen the map kit view is shown and the current location is found and is being updated.
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        
        let status = CLLocationManager.authorizationStatus()
        if status == .NotDetermined || status == .Denied || status == .AuthorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.mapType = MKMapType(rawValue: 0)!
        mapView.userTrackingMode = MKUserTrackingMode(rawValue: 2)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        mapView.mapType = MKMapType(rawValue: 0)!
    }
    
    override func viewWillAppear(animated: Bool) {
        //updates the location
        locationManager.startUpdatingHeading()
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillDisappear(animated: Bool) {
        locationManager.stopUpdatingHeading()
        locationManager.stopUpdatingLocation()
    }
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
       
        self.latitude = newLocation.coordinate.latitude
        self.longitude = newLocation.coordinate.longitude
        
        self.shareData.someString = "\(self.latitude)" + "," + "\(self.longitude)"
        print(self.shareData.someString)
//        print(self.latitude)
        
//        //This is the part where the polyline is suppose to draw the line. Takes the old location and new location to define the distance between the points and from that it calls the function mapLocation to draw the line.
//        if let oldLocationNew = oldLocation as CLLocation?{
//            let oldCoordinates = oldLocationNew.coordinate
//            let newCoordinates = newLocation.coordinate
//            var area = [oldCoordinates, newCoordinates]
//            let polyline = MKPolyline(coordinates: &area, count: area.count)
//            mapView.addOverlay(polyline)
//        }
        
        
        
//        //this places the annotation on the map every 5 meters of distance changed.
//        if let _ = previousLocation as CLLocation?{
//            //case if previous location exists
//            if previousLocation.distanceFromLocation(newLocation) > 5 {
//                addAnnotationsOnMap(newLocation)
//                previousLocation = newLocation
//            }
//        }else{
//            //case if previous location doesn't exists
//            addAnnotationsOnMap(newLocation)
//            previousLocation = newLocation
//        }
        
        
    }
    
//    //this specifies the line should be overlaid on the map. The line is suppose to have a stroke color of blue with a width of 10
//    //Other people's code that I looked at that had the same code as below are Jimmy Jose and Ravi Shankar
//    func mapLocation(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
//        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
//        
//        if overlay is MKPolyline {
//            
//            polylineRenderer.strokeColor = UIColor.blueColor()
//            polylineRenderer.lineWidth = 10
//            return polylineRenderer
//        }
//        
//        return nil
//    }
    
//    //this adds the annotation on the map.
//    func addAnnotationsOnMap(locationToPoint : CLLocation){
//        
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = locationToPoint.coordinate
//        let geoCoder = CLGeocoder ()
//        geoCoder.reverseGeocodeLocation(locationToPoint, completionHandler: { (placemarks, error) -> Void in
//            if let placemarks = placemarks as [CLPlacemark]! where placemarks.count > 0 {
//                let placemark = placemarks[0]
//                var addressDictionary = placemark.addressDictionary;
//                annotation.title = addressDictionary!["Name"] as? String
//                self.mapView.addAnnotation(annotation)
//            }
//        })
//    }

    

}
