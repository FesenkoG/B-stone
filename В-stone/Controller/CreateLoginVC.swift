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
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var emailTextField: LoginTextField!
    @IBOutlet weak var acceptedBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
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
        nextBtn.isEnabled = false
        if accepted, emailTextField.text != nil, passwordTextField.text != nil, loginTextField.text != nil {
            AuthService.instance.registerUser(email: emailTextField.text!, password: passwordTextField.text!, username: loginTextField.text!, handler: { (success, error) in
                if success {
                    self.nextBtn.isEnabled = true
                    AuthService.instance.loginUser(email: self.emailTextField.text!, password: self.passwordTextField.text!, handler: { (completion, error) in
                        self.performSegue(withIdentifier: "toWelcome", sender: nil)
                    })
                } else {
                    self.errorLbl.isHidden = false
                    self.errorLbl.text = error?.localizedDescription
                    self.nextBtn.isEnabled = true
                }
            })
        }
    }
}


