//
//  StartVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 29.01.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class StartVC: UIViewController {
    
    
    @IBOutlet weak var loginTextField: LoginTextField!
    @IBOutlet weak var passwordTextField: LoginTextField!
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
    }

    @IBAction func createAccountWasPressed(_ sender: Any) {
        guard let createLoginVC = storyboard?.instantiateViewController(withIdentifier: "CreateLoginVC") as? CreateLoginVC else { return }
        presentDetail(createLoginVC)
    }
    
    @IBAction func forgotThePasswordBtnWasPressed(_ sender: Any) {
        guard let blankVC = storyboard?.instantiateViewController(withIdentifier: "ItWasSentVC") as? ItWasSentVC else { return }
        presentDetail(blankVC)
    }
    
    @IBAction func signInBtnWasPressed(_ sender: Any) {
        if loginTextField.text != nil && passwordTextField.text != nil {
            AuthService.instance.loginUser(email: loginTextField.text!, password: passwordTextField.text!, handler: { (success) in
                if success {
                    
                    //войти на следующий экран
                } else {
                    //показать пользователю, что он ввел некорректный пароль
                }
            })
        }
    }
    
    
    
    
}
