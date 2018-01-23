//
//  Survey.swift
//  Survey
//
//  Created by Marko Rankovic on 1/23/18.
//  Copyright © 2018 marko.rankovic. All rights reserved.
//

import UIKit

struct SurveyRecord: Codable {
    
    //MARK: - Properties
    var records: [Survey]?
}

struct Icon: Codable {
    
    //MARK: - Properties
    var urlsArray: [String]?
    
    enum CodingKeys: String, CodingKey {
        case urlsArray = "ikonice"
    }
}

class Survey: NSObject, Codable {

    //MARK: - Properties
    var id: String?
    var name: String?
    var question: String?
    var status: String?
    var commentsCount: String?
    var background: String?
    var userID: String?
    var evaluations: String?
    var iconURLs: [Icon]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "ime"
        case question = "pitanje"
        case status
        case commentsCount = "komentari"
        case background = "pozadina"
        case userID = "id_korisnika"
        case evaluations = "ocene"
        case iconURLs = "ikonice"
    }
}
