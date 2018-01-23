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
    
    static func createUserFromHTTPRequest(withURL urlString: String, parameters: String, completionHandler: @escaping () -> ()) {
        
        guard let baseLoginURL = URL(string: urlString) else { return }
        
        var request = URLRequest(url: baseLoginURL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = parameters.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "")")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("Status code is: \(httpStatus.statusCode)")
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    if let message = json["message"] as? String {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WRONG_LOGIN_PARAMS), object: nil, userInfo: ["message": message])
                        return
                    }
                }
            } catch let error {
                print("Error serializing JSON: \(error.localizedDescription)")
            }
            
            do {
                let record = try JSONDecoder().decode(Record.self, from: data)
                let user = record.records.first!
                DataManager.sharedInstance.currentUser = user
                
            } catch let error {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                completionHandler()
            }
            
            }.resume()
    }
}
