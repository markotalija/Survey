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
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    var rememberMe = false
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Nastaviti dalje
        
        //Ispisati komentare
        //Proveriti layout na svim uredjajima
        
        registerForNotifications()
        configureForgotPasswordButton()
    }
    
    //MARK: - Public API
    
    func configureForgotPasswordButton() {
        
        let attributes = [NSAttributedStringKey.underlineStyle: 1,
                          NSAttributedStringKey.foregroundColor: UIColor.black] as [NSAttributedStringKey : Any]
        let attributedString = NSAttributedString(string: "Zaboravili ste šifru?", attributes: attributes)
        forgotPasswordButton.setAttributedTitle(attributedString, for: .normal)
        
    }
    
    func registerForNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleLoginError(notification:)), name: NSNotification.Name(rawValue: WRONG_LOGIN_PARAMS), object: nil)
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: LOCATION_DETERMINED), object: nil, queue: OperationQueue.main) { (note) in
            WebServiceManager.sendDeviceLocationToDatabase()
        }
    }
    
    @objc func handleLoginError(notification: Notification) {
        
        DispatchQueue.main.async {
            self.spinnerView.stopAnimating()
            
            if let errorMessage = notification.userInfo as? [String: String] {
                if let loginError = errorMessage["message"] {
                    let alert = Utilities.presentLoginErrorAlert(withTitle: loginError, message: "")
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func rememberMeButtonTapped() {
        
        checkboxButton.isSelected = !checkboxButton.isSelected
        rememberMe = !rememberMe
    }
    
    @IBAction func checkboxTapped(sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        rememberMe = !rememberMe
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
        
        spinnerView.startAnimating()
        
        WebServiceManager.createUserFromHTTPRequest(withURL: BASE_LOGIN_URL, parameters: "email=\(nameTextField.text!)&lozinka=\(passwordTextField.text!)") {
            self.spinnerView.stopAnimating()
            
            if self.rememberMe {
                let data = NSKeyedArchiver.archivedData(withRootObject: DataManager.sharedInstance.currentUser)
                UserDefaults.standard.set(data, forKey: USER)
                UserDefaults.standard.synchronize()
            }
            
            self.performSegue(withIdentifier: LIST_SEGUE, sender: self)
        }
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

