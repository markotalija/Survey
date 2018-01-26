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
        
        configureCommentsSection()
    }
    
    //MARK: - Public API
    
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
