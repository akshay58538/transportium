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

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var locationManager : CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startStandardLocationUpdate() {
        if (nil == locationManager){
            locationManager = CLLocationManager()
        }
        locationManager!.delegate = self
        locationManager!.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager!.distanceFilter = 50
        locationManager!.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var location : CLLocation = locations.last as CLLocation
        var eventDate : NSDate = location.timestamp
        var timeFromNow : NSTimeInterval = eventDate.timeIntervalSinceNow
        if (abs(timeFromNow) < 15.0){
            NSLog("latitude %+.6f, longitude %+.6f, course %@\n", location.coordinate.latitude, location.coordinate.longitude, location.course.description);
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        NSLog("Error: %@", error)
    }

}

