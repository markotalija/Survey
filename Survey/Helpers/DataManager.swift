//
//  DataManager.swift
//  Survey
//
//  Created by Marko Rankovic on 1/23/18.
//  Copyright © 2018 marko.rankovic. All rights reserved.
//

import Foundation
import CoreLocation

class DataManager {
    
    //MARK: - Properties
    var currentUser: User!
    var surveysArray = [Survey]()
    var chosenGrade: String!
    var deviceLocation: CLLocation!
    var userLocality: String!
    
    //MARK: - Singleton
    
    static let sharedInstance = DataManager()
    
}
