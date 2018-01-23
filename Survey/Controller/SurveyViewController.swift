//
//  SurveyViewController.swift
//  Survey
//
//  Created by Marko Rankovic on 1/23/18.
//  Copyright © 2018 marko.rankovic. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController {

    //MARK: - Properties
    var currentSurvey: Survey!
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(currentSurvey.evaluations!)
    }
}
