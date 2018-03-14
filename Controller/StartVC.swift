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
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        if Auth.auth().currentUser != nil {
            DataService.instance.checkIfCurrentUserHaveQuizCompleted(handler: { (success) in
                if success {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                } else {
                    guard let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeVC") as? WelcomeVC else {
                        return
                    }
                    self.presentDetail(welcomeVC)
                }
            })
            
        }
    }
    
    @IBAction func createAccountWasPressed(_ sender: Any) {
        guard let createLoginVC = storyboard?.instantiateViewController(withIdentifier: "CreateLoginVC") as? CreateLoginVC else { return }
        presentDetail(createLoginVC)
    }
    
    @IBAction func forgotThePasswordBtnWasPressed(_ sender: Any) {
        guard let enterEmailVC = storyboard?.instantiateViewController(withIdentifier: "EnterEmailVC") as? EnterEmailVC else { return }
        if let text = loginTextField.text {
            enterEmailVC.configureVC(text: text)
        }
        presentDetail(enterEmailVC)
    }
    
    @IBAction func signInBtnWasPressed(_ sender: Any) {
        signInBtn.isEnabled = false
        
        
        if loginTextField.text != nil && passwordTextField.text != nil {
            CurrentUserData.instance.email = loginTextField.text
            CurrentUserData.instance.password = passwordTextField.text
            
            AuthService.instance.loginUser(email: loginTextField.text!, password: passwordTextField.text!, handler: { (success, error) in
                if success {
                    DataService.instance.checkIfCurrentUserHaveQuizCompleted(handler: { (success) in
                        if success {
                            self.performSegue(withIdentifier: "toTabBar", sender: nil)
                        } else {
                            guard let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeVC") as? WelcomeVC else {
                                return
                            }
                            self.presentDetail(welcomeVC)
                        }
                    })
                    
                } else {
                    self.errorLbl.text = error?.localizedDescription
                }
            })
            signInBtn.isEnabled = true
        }
    }
}
