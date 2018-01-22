//
//  LoginViewController.swift
//  Survey
//
//  Created by Marko Rankovic on 1/22/18.
//  Copyright © 2018 marko.rankovic. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    //MARK: - Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var checkboxButton: UIButton!
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureForgotPasswordButton()
    }
    
    //MARK: - Public API
    
    func configureForgotPasswordButton() {
        
        let attributes = [NSAttributedStringKey.underlineStyle: 1,
                          NSAttributedStringKey.foregroundColor: UIColor.black] as [NSAttributedStringKey : Any]
        let attributedString = NSAttributedString(string: "Zaboravili ste šifru?", attributes: attributes)
        forgotPasswordButton.setAttributedTitle(attributedString, for: .normal)
        
    }
    
    //MARK: - Actions
    
    @IBAction func rememberMeButtonTapped() {
        
        checkboxButton.isSelected = !checkboxButton.isSelected
    }
    
    @IBAction func checkboxTapped(sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func signUpButtonTapped() {
    
        guard nameTextField.text != nil, nameTextField.text != "" else {
            let alert = Utilities.presentLoginErrorAlert(withTitle: "Molimo Vas upišite Vaše ime i prezime", message: "")
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard passwordTextField.text != nil, passwordTextField.text != "" else {
            let alert = Utilities.presentLoginErrorAlert(withTitle: "Molimo Vas upišite lozinku", message: "")
            present(alert, animated: true, completion: nil)
            return
        }
        
        WebServiceManager.makePostRequest(withURL: BASE_LOGIN_URL, parameters: "email=\(nameTextField.text!)&lozinka=\(passwordTextField.text!)")
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return false
    }
}

