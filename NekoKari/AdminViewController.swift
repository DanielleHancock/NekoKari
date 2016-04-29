//
//  AdminViewController.swift
//  NekoKari
//
//  Created by Lisa Sun on 3/16/16.
//  Copyright © 2016 Lisa Sun. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import CoreLocation

class AdminViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let admin = "032adce6-9477-47a7-a763-75b5b3f80663"
    let ref = Firebase(url: "https://nekokari.firebaseio.com")
    
    @IBAction func logOutDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("adminToLogin", sender: self)
    }
   
    @IBAction func newGameDidTouch(sender: AnyObject) {
        self.ref.childByAppendingPath("admin").childByAppendingPath(admin).setValue(["Snowball":"GPS Location Not Set", "Smokey":"GPS Location Not Set", "Spots":"GPS Location Not Set", "Shadow":"GPS Location Not Set", "Sunny": "GPS Location Not Set"])
        let annotationsToRemove = mapView.annotations.filter { $0 !== mapView.userLocation }
        mapView.removeAnnotations( annotationsToRemove )
        self.ref.childByAppendingPath("users").removeValue()
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
        
        var catRefArray: [AnyObject] = []
        var catNameArray: [AnyObject] = []
        
        catNameArray.append("Snowball")
        catNameArray.append("Smokey")
        catNameArray.append("Shadow")
        catNameArray.append("Spots")
        catNameArray.append("Sunny")
        
        
        for i in 0...4 {
            catRefArray.append(self.ref.childByAppendingPath("admin").childByAppendingPath(self.admin).childByAppendingPath(catNameArray[i] as! String))
        }
        
        for i in 0...4 {
            catRefArray[i].observeEventType(.Value, withBlock: { snapshot in
                if let value:String = snapshot.value as? String {
                    let latlong = value.characters.split{$0 == ","}.map(String.init)
                    let isIndexValid:Bool = latlong.indices.contains(1)
                    if isIndexValid {
                        let lat:Double? = Double(latlong[0])
                        let long:Double? = Double(latlong[1])
                        
                        let catLocation = CLLocationCoordinate2DMake(lat!,long!)
                        // Drop a pin
                        let dropPin = MKPointAnnotation()
                        dropPin.coordinate = catLocation
                        dropPin.title = catNameArray[i] as? String
                        
                        
                        self.mapView.addAnnotation(dropPin)
                    }
                    
                }
                }, withCancelBlock: { error in
                    print(error.description)
            })

        }
        
        
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
    }

}
