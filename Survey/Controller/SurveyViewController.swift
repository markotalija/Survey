//
//  SurveyViewController.swift
//  Survey
//
//  Created by Marko Rankovic on 1/23/18.
//  Copyright © 2018 marko.rankovic. All rights reserved.
//

import UIKit
import SDWebImage

class SurveyViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var answerLabel1: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var answerLabel2: UILabel!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var answerLabel3: UILabel!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var answerLabel4: UILabel!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var answerLabel5: UILabel!
    @IBOutlet weak var button5: UIButton!
    var currentSurvey: Survey!
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSurveyLayout()
    }
    
    //MARK: - Public API
    
    func configureSurveyLayout() {
        
        //Odraditi return slucajeve u guardovima
        
        if let background = currentSurvey.background, background != "" {
            if let url = URL(string: background) {
                backgroundImageView.sd_setImage(with: url, completed: nil)
            }
        }
        
        guard let iconsArray = currentSurvey.iconURLs, iconsArray.count != 0 else { return }
        
        var buttonsArray = [UIButton]()
        buttonsArray.append(button1)
        buttonsArray.append(button2)
        buttonsArray.append(button3)
        buttonsArray.append(button4)
        buttonsArray.append(button5)
        
        for index in 0..<iconsArray.count {
            let urlString = iconsArray[index]
            let button = buttonsArray[index]
            guard let url = URL(string: urlString) else { return }
            button.sd_setBackgroundImage(with: url, for: .normal, completed: nil)
        }
        
        
        if let question = currentSurvey.question {
            questionLabel.text = question
        } else {
            questionLabel.text = "Nema pitanja"
        }
        
        guard let evaluationString = currentSurvey.evaluations else { return }
        let gradesArray = evaluationString.components(separatedBy: ",")
        
        var labelsArray = [UILabel]()
        labelsArray.append(answerLabel1)
        labelsArray.append(answerLabel2)
        labelsArray.append(answerLabel3)
        labelsArray.append(answerLabel4)
        labelsArray.append(answerLabel5)
        
        for index in 0..<labelsArray.count {
            let label = labelsArray[index]
            label.text = gradesArray[index]
        }
    }
    
    //MARK: - Segue Management
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? CommentsViewController {
            destination.survey = currentSurvey
        }
    }
    
    //MARK: - Actions
    
    @IBAction func answerButtonTapped(sender: UIButton) {
        
        DataManager.sharedInstance.chosenGrade = "\(sender.tag)"
        
        performSegue(withIdentifier: COMMENT_SEGUE, sender: self)
    }
}
