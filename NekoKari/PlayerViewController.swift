//
//  PlayerViewController.swift
//  NekoKari
//
//  Created by Lisa Sun on 3/16/16.
//  Copyright © 2016 Lisa Sun. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class PlayerViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let admin = "032adce6-9477-47a7-a763-75b5b3f80663"
    var userid = ""
    let ref = Firebase(url: "https://nekokari.firebaseio.com")
    

    @IBAction func logOutButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("playerToLogin", sender: self)
    }
    
    
    @IBAction func catBookButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("playerToCatBook", sender: self)
    }
    
    
    @IBAction func foundCatButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("playerToQR", sender: self)
    }

    
    @IBOutlet weak var signal: UILabel!
    //@IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var colorSignal: UIImageView!
    
    var red: CGFloat = 0.0
    //variable the green value of the color. preset to 0 in order to produce black as the first color the user has.
    var green: CGFloat = 0.0
    //variable the blue value of the color. preset to 0 in order to produce black as the first color the user has.
    var blue: CGFloat = 0.0
    
    let colors: [(CGFloat, CGFloat, CGFloat)] = [
        (0, 0, 0),
        (105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0),
        (1.0, 0, 0),
        (0, 0, 1.0),
        (51.0 / 255.0, 204.0 / 255.0, 1.0),
        (102.0 / 255.0, 204.0 / 255.0, 0),
        (102.0 / 255.0, 1.0, 0),
        (160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0),
        (1.0, 102.0 / 255.0, 0),
        (1.0, 1.0, 0),
        (225.0/255.0, 0, 255.0/255.0) ,
        (127.0/255.0, 0, 255.0/255.0)
    ]
    
    
    var locationManager: CLLocationManager!
    var previousLocation : CLLocation!
    
    var latitude = 0.0 ;
    var longitude = 0.0 ;
    //var catLatitude = 36.1335588461261 ;
    //var catLongitude = -80.276644411 ;
    //var catLatitude = 36.1373008881101 ;
    //var catLongitude = -80.28249998 ;
    //var catLatitude = 36.1335385565801 ;
    //var catLongitude = -80.276527090 ;
//    var catLatitude = 36.1335118653831 ;
//    var catLongitude = -80.2765731970 ;
    var catLatitude = [Double](count: 5, repeatedValue: 0.0)
    var catLongitude = [Double](count: 5, repeatedValue: 0.0)
    var lookingForCatLat = 0.0
    var lookingForCatLong = 0.0

    override func viewDidLoad() {
        ref.observeAuthEventWithBlock({ authData in
            if authData != nil {
                // user authenticated
                self.userid = authData.uid
                print("uid" + self.userid)
            } else {
                // No user is signed in
            }
        })
    }
    
    override func viewWillAppear(animated: Bool) {
    
        
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
                     
                            self.catLatitude[i] = Double(latlong[0])!
                            self.catLongitude[i] = Double(latlong[1])!
                        print(String(self.catLatitude) + "," + String(self.catLongitude))
                        
                    }
                    
                }
                }, withCancelBlock: { error in
                    print(error.description)
            })
            
        }
        
        lookingForCatLat = catLatitude[0]
        lookingForCatLong = catLongitude[0]
        
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
        
        //mapView.delegate = self
        //mapView.showsUserLocation = true
        //mapView.mapType = MKMapType(rawValue: 0)!
        //mapView.userTrackingMode = MKUserTrackingMode(rawValue: 2)!
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //mapView.mapType = MKMapType(rawValue: 0)!
    }
    
    override func viewDidAppear(animated: Bool) {
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
        //print(String(self.latitude))
        //print (String(abs(self.latitude - catLatitude)))
        
        //print(String(lookingForCatLong))
        for i in 0...3 {
            if (self.latitude - lookingForCatLat < self.latitude - catLatitude[i+1]) {
                if (self.longitude - lookingForCatLong < self.longitude - catLongitude[i+1]) {
                }
            }
            else {
                lookingForCatLat = catLatitude[i+1]
                lookingForCatLong = catLongitude[i+1]
            }
        }
        //print("Latitude" + String(lookingForCatLat))
        //print("Longitude" + String(lookingForCatLong))
        //2 meters or 6 feet
        if (abs(self.latitude - lookingForCatLat) <= 0.000020 || abs(self.longitude - lookingForCatLong) <= 0.00020) {
            signal.text = "Flaming Hot"
            colorSignal.backgroundColor = UIColor(red: 255.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1.0)
        }
            //4 meters or 13 feet = .00004
            //8 meters or 26 feet = .00007
        else if (abs(self.latitude - lookingForCatLat) <= 0.000070 || abs(self.longitude - lookingForCatLong) <= 0.000070) {
            signal.text = "Hot"
            colorSignal.backgroundColor = UIColor(red: 255.0/255, green: 75.0/255, blue: 75.0/255, alpha: 1.0)
        }
            //8 meters or 26 feet = .00007
            //17 meters or 55 feet = .00015
        else if (abs(self.latitude - lookingForCatLat) <= 0.000150 || abs(self.longitude - lookingForCatLong) <= 0.000150) {
            signal.text = "Warm"
            colorSignal.backgroundColor = UIColor(red: 255.0/255, green: 175.0/255, blue: 175.0/255, alpha: 1.0)
        }
            //11 meters or 36 feet = .00010
            //22 meters or 75 feet = .00020
        else if (abs(self.latitude - lookingForCatLat) <= 0.000200 || abs(self.longitude - lookingForCatLong) <= 0.000200) {
            signal.text = "Chilly"
            colorSignal.backgroundColor = UIColor(red: 175.0/255, green: 175.0/255, blue: 255.0/255, alpha: 1.0)
        }
            // 16 meters or 52 feet = .00014
            // 30 meters or 100 feet = .00027
        else if (abs(self.latitude - lookingForCatLat) <= 0.000270 || abs(self.longitude - lookingForCatLong) <= 0.000270) {
            signal.text = "Cold"
            colorSignal.backgroundColor = UIColor(red: 75.0/255, green: 75.0/255, blue: 255.0/255, alpha: 1.0)
        }
        else {
            signal.text = "Ice Cold"
            colorSignal.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 255.0/255, alpha: 1.0)
        }

        
        
    }


}
