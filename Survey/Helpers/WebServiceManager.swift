//
//  WebServiceManager.swift
//  Survey
//
//  Created by Marko Rankovic on 1/22/18.
//  Copyright © 2018 marko.rankovic. All rights reserved.
//

import Foundation

struct WebServiceManager {
    
    //MARK: - POST Methods
    
    static func makePostRequest(withURL urlString: String, parameters: String) {
        
        guard let baseLoginURL = URL(string: urlString) else { return }
        
        var request = URLRequest(url: baseLoginURL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = parameters.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Custom error")")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("Status code is \(httpStatus.statusCode)")
            }
            
            let string = String(data: data, encoding: .utf8)
            print("Response: \(string ?? "No response")")
            }.resume()
    }
}
