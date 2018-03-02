//
//  HowOldAreYouVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 29.01.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class HowOldAreYouVC: UIViewController {

    @IBOutlet weak var ageTxtField: LoginTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if CurrentUserData.instance.age != nil {
            ageTxtField.text = String(describing: CurrentUserData.instance.age!)
        }
    }

    @IBAction func nextBtnWasPressed(_ sender: Any) {
        
        if let age = ageTxtField.text, ageTxtField.text != "", let intAge = Int(age), intAge > 0, intAge < 150 {
            CurrentUserData.instance.age = intAge
            guard let whereLiveVC = storyboard?.instantiateViewController(withIdentifier: "WhereLiveVC") as? WhereLiveVC else { return }
            presentDetail(whereLiveVC)
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    

}
