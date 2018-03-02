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
    var text: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let txt = text {
            emailTxtField.text = txt
        }
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: emailTxtField.text!) { (error) in
            if let error = error {
                self.errorLbl.text = error.localizedDescription
                self.errorLbl.isHidden = false
            } else {
                self.errorLbl.isHidden = true
                guard let blankVC = self.storyboard?.instantiateViewController(withIdentifier: "ItWasSentVC") as? ItWasSentVC else { return }
                self.presentDetail(blankVC)
            }
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func configureVC(text: String) {
        self.text = text
    }
}
