//
//  CommentsViewController.swift
//  Survey
//
//  Created by Marko Rankovic on 1/24/18.
//  Copyright © 2018 marko.rankovic. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController, UITextViewDelegate {

    //MARK: - Properties
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendButton: RoundedButton!
    var survey: Survey!
    var isTextWritten = false
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForNotifications()
        configureCommentsSection()
    }
    
    //MARK: - Public API
    
    func registerForNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleCommentsError(notification:)), name: NSNotification.Name(rawValue: COMMENTS_ERROR), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleSentCommentMessage(notification:)), name: NSNotification.Name(rawValue: SENT_COMMENT_RESPONSE), object: nil)
    }
    
    func configureCommentsSection() {
        
        if survey.commentsCount == "0" {
            textView.isHidden = true
            sendButton.isHidden = true
        } else {
            textView.becomeFirstResponder()
            setTimer()
        }
    }
    
    func setTimer() {
        
        //Sklanjanje view controller-a nakon 10 sekundi
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            if !self.isTextWritten {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func handleCommentsError(notification: Notification) {
        
        DispatchQueue.main.async {
            if let error = notification.userInfo as? [String: String] {
                if let httpError = error["error"] {
                    let alert = Utilities.presentLoginErrorAlert(withTitle: "Komentar ne može da se pošalje", message: httpError)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func handleSentCommentMessage(notification: Notification) {
        
        DispatchQueue.main.async {
            if let messageDictionary = notification.userInfo as? [String: String] {
                if let message = messageDictionary["message"] {
                    let alert = Utilities.presentAlertMessage(withTitle: message)
                    self.present(alert, animated: true, completion: nil)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        alert.dismiss(animated: true, completion: nil)
                    })
                }
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func sendButtonTapped() {
        
        guard textView.text != nil else { return }
        
        //Tip izabrane ocene
        guard let gradeType = DataManager.sharedInstance.chosenGrade else { return }
        
        //Datum i vreme
        let currentDate = Date()
        let formatter = DateFormatter()
        let calendar = Calendar.current
        formatter.dateFormat = "yyyy-MM-dd"
        
        let date = formatter.string(from: currentDate)
        
        let hour = calendar.component(.hour, from: currentDate)
        let minute = calendar.component(.minute, from: currentDate)
        
        let time = "\(hour):\(minute)"
        
        //ID uredjaja
        let deviceID = DataManager.sharedInstance.deviceID!
        
        //ID ankete
        guard let surveyID = survey.id else { return }
        
        //Lokacija
        let location = DataManager.sharedInstance.userLocality!
        
        //Komentar
        let comment = textView.text!
        
        let parameters = "tip=\(gradeType)&vreme=\(time)&datum=\(date)&id_uredjaja=\(deviceID)&id_ankete=\(surveyID)&lokacija=\(location)&komentar=\(comment)"
        
        //Slanje komentara i ostalih parametara na servis
        WebServiceManager.sendCommentToServer(withParameters: parameters)
    }
    
    //MARK: - UITextViewDelegate
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        isTextWritten = true
    }
}
