//
//  Utilities.swift
//  Survey
//
//  Created by Marko Rankovic on 1/22/18.
//  Copyright © 2018 marko.rankovic. All rights reserved.
//

import UIKit
import CoreLocation

class Utilities {
    
    //MARK: - Helper methods
    
    static func presentLoginErrorAlert(withTitle title: String, message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        return alert
    }
    
    static func presentAlertMessage(withTitle title: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        return alert
    }
    
    static func setTimer() {
        
        let currentDate = Date()
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .minute, value: 30, to: currentDate) {
            UserDefaults.standard.set(newDate, forKey: WAITING_DATE)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func checkIfTimerExpired() -> Bool {
        
        if let waitingDate = UserDefaults.standard.value(forKey: WAITING_DATE) as? Date {
            let currentDate = Date()
            if currentDate.compare(waitingDate) == .orderedDescending {
                return true
            }
        }
        
        return false
    }
}
