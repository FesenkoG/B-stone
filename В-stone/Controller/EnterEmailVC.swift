//
//  EnterEmailVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 21.02.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit
import Firebase

class EnterEmailVC: UIViewController {

    @IBOutlet weak var emailTxtField: LoginTextField!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    var text: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.imageEdgeInsets = UIEdgeInsetsMake(25, 25, 0, 0)
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(25, 0, 0, 25)
        if let txt = text {
            emailTxtField.text = txt
        }
        emailTxtField.delegate = self
        
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: emailTxtField.text!) { (error) in
            if let error = error {
                self.errorLbl.text = error.localizedDescription
                self.errorLbl.isHidden = false
            } else {
                self.errorLbl.isHidden = true
                self.performSegue(withIdentifier: "toItWasSent", sender: nil)
            }
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureVC(text: String) {
        self.text = text
    }
}

extension EnterEmailVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
