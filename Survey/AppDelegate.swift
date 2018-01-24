//
//  AppDelegate.swift
//  Survey
//
//  Created by Marko Rankovic on 1/22/18.
//  Copyright © 2018 marko.rankovic. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    //MARK: - Properties
    var window: UIWindow?
    var locationManager: CLLocationManager!

    //MARK: - UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        configureLocationManager()
        
        if let data = UserDefaults.standard.data(forKey: USER) {
            let user = NSKeyedUnarchiver.unarchiveObject(with: data) as! User
            DataManager.sharedInstance.currentUser = user
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "ListViewController")
            
            window?.rootViewController = initialViewController
            window?.makeKeyAndVisible()
        }
        
        return true
    }
    
    //MARK: - Public API
    
    func configureLocationManager() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getLocationName(completionHandler: @escaping (CLPlacemark?) -> Void) {
        
        if let lastLocation = locationManager.location {
            let geocoder = CLGeocoder()
            
            geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                } else {
                    print("Error fetching location: \(String(describing: error?.localizedDescription))")
                    completionHandler(nil)
                }
            })
        } else {
            print("No location available")
            completionHandler(nil)
        }
    }
    
    //MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Location manager error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.count > 0 {
            if let location = locations.last {
                DataManager.sharedInstance.deviceLocation = location
                getLocationName { (placemark) in
                    if let place = placemark {
                        if let locality = place.locality {
                            DataManager.sharedInstance.userLocality = locality
                        }
                    }
                }
            }
        }
    }
}

