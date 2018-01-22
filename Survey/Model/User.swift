//
//  User.swift
//  Survey
//
//  Created by Marko Rankovic on 1/22/18.
//  Copyright © 2018 marko.rankovic. All rights reserved.
//

import Foundation

struct Record: Decodable {
    
    //MARK: - Properties
    var records: [User]
}

class User: Codable {

    //MARK: - Properties
    var id: String?
    var name: String?
    var lastName: String?
    var companyName: String?
    var evaluationNumber: String?
    var status: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name = "ime"
        case lastName = "prezime"
        case companyName = "naziv_kompanije"
        case evaluationNumber = "broj_ocena"
        case status
    }
}

