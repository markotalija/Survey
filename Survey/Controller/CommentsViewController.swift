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
}
