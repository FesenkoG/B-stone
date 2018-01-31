//
//  CreateLoginVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 29.01.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class CreateLoginVC: UIViewController {

    @IBOutlet weak var loginTextField: LoginTextField!
    @IBOutlet weak var passwordTextField: LoginTextField!
    @IBOutlet weak var emailTextField: LoginTextField!
    @IBOutlet weak var acceptedBtn: UIButton!
    
    var accepted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func acceptedBtnWasPressed(_ sender: Any) {
        if accepted == false {
            accepted = true
            acceptedBtn.setImage(UIImage(named: "ChooseCircleTrue"), for: .normal)
        } else {
            accepted = false
            acceptedBtn.setImage(UIImage(named: "ChooseCircleFalse"), for: .normal)
        }
    }
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        if accepted, emailTextField.text != nil, passwordTextField.text != nil, loginTextField.text != nil {
            AuthService.instance.registerUser(email: emailTextField.text!, password: passwordTextField.text!, username: loginTextField.text!, handler: { (success) in
                if success {
                    //Перейти на следующий экран
                    guard let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeVC") as? WelcomeVC else {
                        return
                    }
                    self.presentDetail(welcomeVC)
                } else {
                    //Сказать пользователю, что что-то не так
                }
            })
        }
    }
}


