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

class User: NSObject, Codable, NSCoding {

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
    
    //MARK: - NSCoding Protocol
    
    required init?(coder aDecoder: NSCoder) {
        
        id = aDecoder.decodeObject(forKey: "id") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        lastName = aDecoder.decodeObject(forKey: "lastName") as? String
        companyName = aDecoder.decodeObject(forKey: "companyName") as? String
        evaluationNumber = aDecoder.decodeObject(forKey: "evaluationNumber") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(companyName, forKey: "companyName")
        aCoder.encode(evaluationNumber, forKey: "evaluationNumber")
        aCoder.encode(status, forKey: "status")
    }
}

