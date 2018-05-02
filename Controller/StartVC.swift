//
//  StartVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 29.01.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit
import Firebase

class StartVC: UIViewController {
    
    
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var loginTextField: LoginTextField!
    @IBOutlet weak var passwordTextField: LoginTextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        turnOffSpinner()
        errorLbl.isHidden = true
        self.hideKeyboardWhenTappedAround()
        if Auth.auth().currentUser != nil {
            turnOnSpinner()
            signInBtn.isEnabled = false
            DataService.instance.checkIfCurrentUserHaveQuizCompleted(handler: { (success) in
                self.turnOffSpinner()
                self.signInBtn.isEnabled = true
                if success {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                } else {
                    self.performSegue(withIdentifier: "toWelcome", sender: nil)
                }
            })
        }
    }
    
    func turnOnSpinner() {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        
    }
    
    func turnOffSpinner() {
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
    }
    
    @IBAction func createAccountWasPressed(_ sender: Any) {
        performSegue(withIdentifier: "toCreateLogin", sender: nil)
    }
    
    @IBAction func forgotThePasswordBtnWasPressed(_ sender: Any) {
        
        if let text = loginTextField.text {
            self.performSegue(withIdentifier: "toEnterEmail", sender: text)
        } else {
            self.performSegue(withIdentifier: "toEnterEmail", sender: nil)
        }
        
    }
    
    @IBAction func signInBtnWasPressed(_ sender: Any) {
        
        signInBtn.isEnabled = false
        errorLbl.isHidden = true
        if loginTextField.text != nil && passwordTextField.text != nil {
            turnOnSpinner()
            CurrentUserData.instance.email = loginTextField.text
            CurrentUserData.instance.password = passwordTextField.text
            
            AuthService.instance.loginUser(email: loginTextField.text!, password: passwordTextField.text!, handler: { (success, error) in
                if success {
                    DataService.instance.checkIfCurrentUserHaveQuizCompleted(handler: { (success) in
                        self.turnOffSpinner()
                        if success {
                            self.performSegue(withIdentifier: "toTabBar", sender: nil)
                        } else {
                            self.performSegue(withIdentifier: "toWelcome", sender: nil)
                        }
                    })
                    
                } else {
                    self.turnOffSpinner()
                    self.errorLbl.text = error?.localizedDescription
                    self.errorLbl.isHidden = false
                }
            })
            signInBtn.isEnabled = true
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UITabBarController {
            vc.selectedIndex = 1
        } else {
            if let vc = segue.destination as? EnterEmailVC, let text = sender as? String {
                vc.configureVC(text: text)
            }
        }
    }
}
