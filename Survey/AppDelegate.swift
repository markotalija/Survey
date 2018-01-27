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
        
        //Dobijanje ID-a uređaja
        let deviceID = Utilities.getDeviceID()
        DataManager.sharedInstance.deviceID = deviceID
        
        //30-minutni tajmer za lokaciju
        if let _ = UserDefaults.standard.value(forKey: WAITING_DATE) as? Date {
            if Utilities.checkIfTimerExpired() {
                configureLocationManager()
            }
        } else {
            configureLocationManager()
        }
        
        //Dobijanje područja uređaja
        getLocationName { (placemark) in
            if let place = placemark {
                if let locality = place.locality {
                    DataManager.sharedInstance.userLocality = locality
                }
            }
        }
        
        //Ako je korisnik sačuvan, preći na ekran sa listom anketa
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
        locationManager.requestLocation()
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
            DataManager.sharedInstance.userLocality = "Konjarnik"
            completionHandler(nil)
        }
    }
    
    //MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Location manager error: \(error.localizedDescription)")
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.count > 0 {
            if let location = locations.last {
                DataManager.sharedInstance.deviceLocation = location
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: LOCATION_DETERMINED), object: nil)
            }
        }
    }
}

