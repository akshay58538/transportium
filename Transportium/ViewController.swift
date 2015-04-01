//
//  ViewController.swift
//  Transportium
//
//  Created by Goel, Akshay on 4/1/15.
//  Copyright (c) 2015 Goel, Akshay. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager = CLLocationManager()
    var gmsMapView : GMSMapView?
    var coordinate : CLLocationCoordinate2D?
    var heading : CLLocationDirection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startStandardLocationUpdate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func startStandardLocationUpdate() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        if(CLLocationManager.headingAvailable()){
            locationManager.headingFilter = 5
            locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var location : CLLocation = locations.last as CLLocation
        var eventDate : NSDate = location.timestamp
        var timeFromNow : NSTimeInterval = eventDate.timeIntervalSinceNow
        if (abs(timeFromNow) < 15.0){
            NSLog("latitude %+.6f, longitude %+.6f, course %@\n", location.coordinate.latitude, location.coordinate.longitude, location.course.description);
            self.coordinate = location.coordinate
        }
        self.updateMapDisplay()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        if (newHeading.headingAccuracy < 0){
            return;
        }
        var headingNew : CLLocationDirection = newHeading.trueHeading > 0 ? newHeading.trueHeading : newHeading.magneticHeading
        self.heading = headingNew
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        NSLog("Error: %@", error)
    }
    
    func updateMapDisplay() {
        var camera : GMSCameraPosition = GMSCameraPosition(target: self.coordinate!, zoom: 18.0, bearing: 0.0, viewingAngle: 90.0)
        self.gmsMapView = GMSMapView(frame: CGRectZero)
        self.gmsMapView?.camera = camera
        self.gmsMapView?.myLocationEnabled = true
        self.view = self.gmsMapView
        
        var marker : GMSMarker = GMSMarker(position: self.coordinate!)
        marker.title = "Harmony Renaissance"
        marker.snippet = "Chennai"
        marker.map = self.gmsMapView
    }

}

