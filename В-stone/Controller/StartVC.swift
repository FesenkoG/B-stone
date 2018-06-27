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
    
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    @IBOutlet weak var createAccountBtn: UIButton!

    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    
    var model: QuizModel!
    let localDataService: LocalDataService = LocalDataService()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        passwordTextField.delegate = self
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        turnOffSpinner()
        errorLbl.isHidden = true
        hideKeyboardWhenTappedAround()
        disableInterface()
        turnOnSpinner()
        if Auth.auth().currentUser != nil {
            checkQuiz { (success, model) in
                if success {
                    self.localDataService.saveQuizData(model: model!, handler: { (_) in
                        
                    })
                    self.checkBluetooth(handler: { (blSuccess) in
                        if blSuccess {
                            CurrentUserData.instance.selectedIndex = 1
                            self.performSegue(withIdentifier: "toTabBar", sender: nil)
                            self.turnOffSpinner()
                            self.enableInterface()
                        } else {
                            CurrentUserData.instance.selectedIndex = 2
                            self.performSegue(withIdentifier: "toTabBar", sender: nil)
                            self.turnOffSpinner()
                            self.enableInterface()
                        }
                    })
                } else {
                    self.turnOffSpinner()
                    self.enableInterface()
                    self.performSegue(withIdentifier: "toWelcome", sender: nil)
                }
            }
        } else {
            self.enableInterface()
            self.turnOffSpinner()
        }
    }
    

    
    func checkBluetooth(handler: @escaping (Bool) -> Void) {
        DataService.instance.checkIfCurrentUserHaveBluetoothData(handler: handler)
    }
    func checkQuiz(handler: @escaping (Bool, QuizModel?) -> Void) {
        DataService.instance.checkIfCurrentUserHaveQuizCompleted(handler: handler)
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
        CurrentUserData.instance.selectedIndex = 2
    }
    
    @IBAction func forgotThePasswordBtnWasPressed(_ sender: Any) {
        
        if let text = loginTextField.text {
            self.performSegue(withIdentifier: "toEnterEmail", sender: text)
        } else {
            self.performSegue(withIdentifier: "toEnterEmail", sender: nil)
        }
        
    }
    
    func disableInterface() {
        self.signInBtn.isEnabled = false
        self.forgotPasswordBtn.isEnabled = false
        self.createAccountBtn.isEnabled = false
        self.passwordTextField.isEnabled = false
        self.loginTextField.isEnabled = false
    }
    
    func enableInterface() {
        self.signInBtn.isEnabled = true
        self.forgotPasswordBtn.isEnabled = true
        self.createAccountBtn.isEnabled = true
        self.passwordTextField.isEnabled = true
        self.loginTextField.isEnabled = true
    }
    
    @IBAction func signInBtnWasPressed(_ sender: Any) {
        
        self.disableInterface()
        if loginTextField.text != nil && passwordTextField.text != nil {
            turnOnSpinner()
            CurrentUserData.instance.email = loginTextField.text
            AuthService.instance.loginUser(email: loginTextField.text!, password: passwordTextField.text!, handler: { (success, error) in
                if success {
                    DataService.instance.checkIfCurrentUserHaveQuizCompleted(handler: { (success, model)  in
                        self.turnOffSpinner()
                        if success {
                            self.model = model
                            self.checkBluetooth(handler: { (success) in
                                self.turnOffSpinner()
                                self.enableInterface()
                                if success {
                                    CurrentUserData.instance.selectedIndex = 1
                                } else {
                                    CurrentUserData.instance.selectedIndex = 2
                                }
                                self.performSegue(withIdentifier: "toTabBar", sender: nil)
                            })
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
            self.enableInterface()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UITabBarController {
            vc.selectedIndex = CurrentUserData.instance.selectedIndex
            guard let settingsVC = vc.viewControllers?[0] as? SettingsVC else { return }
            settingsVC.localDataService = localDataService
            guard let homeVC = vc.viewControllers?[1] as? HomeVC else { return }
            homeVC.localDataService = localDataService
            guard let bluetoothVC = vc.viewControllers?[2] as? BluetoothVC else { return }
            bluetoothVC.localDataService = localDataService
            guard let adviceVC = vc.viewControllers?[3] as? AdviceVC else { return }
            adviceVC.localDataService = localDataService
        } else {
            if let vc = segue.destination as? EnterEmailVC, let text = sender as? String {
                vc.configureVC(text: text)
            } else {
                if let vc = segue.destination as? CreateLoginVC, let email = loginTextField.text {
                    vc.email = email
                }
            }
        }
    }
}

extension StartVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
