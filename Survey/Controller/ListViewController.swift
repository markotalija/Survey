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
        
        usernameLabel.text = "\(DataManager.sharedInstance.currentUser.name!) \(DataManager.sharedInstance.currentUser.lastName!)"
        
        WebServiceManager.getSurveyList(fromUserID: DataManager.sharedInstance.currentUser.id!) {
            self.tableView.reloadData()
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
