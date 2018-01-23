//
//  DataManager.swift
//  Survey
//
//  Created by Marko Rankovic on 1/23/18.
//  Copyright © 2018 marko.rankovic. All rights reserved.
//

import Foundation

class DataManager {
    
    //MARK: - Properties
    var currentUser: User!
    var surveysArray = [Survey]()
    
    //MARK: - Singleton
    
    static let sharedInstance = DataManager()
    
}
