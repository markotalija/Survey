//
//  ListViewController.swift
//  Survey
//
//  Created by Marko Rankovic on 1/23/18.
//  Copyright © 2018 marko.rankovic. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: - Properties
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var selectedSurvey: Survey!
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForNotifications()
        //print(DataManager.sharedInstance.deviceLocation.coordinate.latitude)
        //print(DataManager.sharedInstance.deviceLocation.coordinate.longitude)
        
        usernameLabel.text = "\(DataManager.sharedInstance.currentUser.name!) \(DataManager.sharedInstance.currentUser.lastName!)"
        
        WebServiceManager.getSurveyList(fromUserID: DataManager.sharedInstance.currentUser.id!) {
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Public API
    
    func registerForNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNoSurveysError(notification:)), name: NSNotification.Name(rawValue: NO_SURVEYS), object: nil)
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: LOCATION_DETERMINED), object: nil, queue: OperationQueue.main) { (note) in
            WebServiceManager.sendDeviceLocationToDatabase()
        }
    }
    
    @objc func handleNoSurveysError(notification: Notification) {
        
        DispatchQueue.main.async {
            if let errorMessage = notification.userInfo as? [String: String] {
                if let noSurveysError = errorMessage["message"] {
                    let alert = Utilities.presentLoginErrorAlert(withTitle: noSurveysError, message: "")
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    //MARK: - Segue Management
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? SurveyViewController {
            destination.currentSurvey = selectedSurvey
        }
    }
    
    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if DataManager.sharedInstance.surveysArray.count > 0 {
            return DataManager.sharedInstance.surveysArray.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath)
        let survey = DataManager.sharedInstance.surveysArray[indexPath.row]
        cell.textLabel?.text = survey.name
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let survey = DataManager.sharedInstance.surveysArray[indexPath.row]
        selectedSurvey = survey
        
        performSegue(withIdentifier: SURVEY_SEGUE, sender: self)
    }
}
