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
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    var model: QuizModel!
    
    @IBAction func prepareForUnwindToHowOld(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if model == nil {
            model = QuizModel()
        }
        self.hideKeyboardWhenTappedAround()
        AppData.shared.isEditScreenExists = true
        nextBtn.imageEdgeInsets = UIEdgeInsetsMake(25, 25, 12, 20)
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(25, 20, 12, 25)
        
        ageTxtField.delegate = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if model.age != 0 {
            ageTxtField.text = String(describing: model.age)
        }
    }

    @IBAction func nextBtnWasPressed(_ sender: Any) {
        
        if let age = ageTxtField.text, ageTxtField.text != "", let intAge = Int(age), intAge > 0, intAge < 150 {
            //CurrentUserData.instance.age = intAge
            model.age = intAge
            self.performSegue(withIdentifier: "toWhereYouLive", sender: nil)
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        
        if AppData.shared.isWelcomeExists {
            self.performSegue(withIdentifier: "toSettings", sender: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
            AppData.shared.isEditScreenExists = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WhereLiveVC {
            vc.model = self.model
        }
        guard let tabBarVC = segue.destination as? UITabBarController else { return }
        tabBarVC.selectedIndex = 0
    }
}

extension HowOldAreYouVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
