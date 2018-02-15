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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
    }

    @IBAction func createAccountWasPressed(_ sender: Any) {
        guard let createLoginVC = storyboard?.instantiateViewController(withIdentifier: "CreateLoginVC") as? CreateLoginVC else { return }
        presentDetail(createLoginVC)
    }
    
    @IBAction func forgotThePasswordBtnWasPressed(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: loginTextField.text!) { (error) in
            if let error = error {
                self.errorLbl.text = error.localizedDescription
            } else {
                guard let blankVC = self.storyboard?.instantiateViewController(withIdentifier: "ItWasSentVC") as? ItWasSentVC else { return }
                self.presentDetail(blankVC)
            }
        }
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
                            // входим на экран
                            print("я тут")
                            print(CurrentUserData.instance.habitSport)
                        } else {
                            guard let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeVC") as? WelcomeVC else {
                                return
                            }
                            self.presentDetail(welcomeVC)
                        }
                    })
                    
//                    if quiz {
//                        // входим на экран
//                        print("я тут")
//                        print(CurrentUserData.instance.habitSport)
//                    } else {
//
//                        guard let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeVC") as? WelcomeVC else {
//                            return
//                        }
//                        self.presentDetail(welcomeVC)
//                    }
                } else {
                    self.errorLbl.text = error?.localizedDescription
                }
            })
            signInBtn.isEnabled = true
        }
    }
}
