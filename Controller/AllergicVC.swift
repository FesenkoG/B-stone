//
//  AllergicVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 01.02.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit
import Firebase

class AllergicVC: UIViewController {

    @IBOutlet weak var haveNotKnowBtn: UIButton!
    @IBOutlet weak var haveKnowBtn: UIButton!
    @IBOutlet weak var notHaveBtn: UIButton!
    @IBOutlet weak var notKnowBtn: UIButton!
    
    var allergic: Allergic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let alrgc = CurrentUserData.instance.allergic {
            allergic = alrgc
            setChoise(choise: allergic!)
        }
        

    }
    
    @IBAction func haveNotKnowBtnWasPressed(_ sender: Any) {
        setChoise(choise: .haveNotKnow)
        
    }
    
    @IBAction func haveKnowBtnWasPressed(_ sender: Any) {
        setChoise(choise: .haveKnow)
    }
    
    @IBAction func notHaveBtnWasPressed(_ sender: Any) {
        setChoise(choise: .notHave)
    }
    
    @IBAction func notKnowBtnWasPressed(_ sender: Any) {
        setChoise(choise: .notKnow)
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        
        if let allerg = allergic {
            CurrentUserData.instance.allergic = allerg
        }
        
        AuthService.instance.loginUser(email: CurrentUserData.instance.email!, password: CurrentUserData.instance.password!) { (success, error) in
            if success {
                DataService.instance.uploadUserData(handler: { (success) in
                    if success {
                        //Это не работает!!
                        guard let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as? HomeVC else { return }
                        
                        self.presentDetail(homeVC)
                        //Не работает!!
                    }
                })
            }

        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func setChoise(choise: Allergic) {
        
        haveNotKnowBtn.setImage(UIImage(named: "ChooseCircleFalse")!, for: .normal)
        haveKnowBtn.setImage(UIImage(named: "ChooseCircleFalse")!, for: .normal)
        notHaveBtn.setImage(UIImage(named: "ChooseCircleFalse")!, for: .normal)
        notKnowBtn.setImage(UIImage(named: "ChooseCircleFalse")!, for: .normal)
        
        allergic = choise

        switch choise {
        case .haveNotKnow:
            haveNotKnowBtn.setImage(UIImage(named: "ChooseCircleTrue")!, for: .normal)
        case .haveKnow:
            haveKnowBtn.setImage(UIImage(named: "ChooseCircleTrue")!, for: .normal)
        case .notHave:
            notHaveBtn.setImage(UIImage(named: "ChooseCircleTrue")!, for: .normal)
        case .notKnow:
            notKnowBtn.setImage(UIImage(named: "ChooseCircleTrue")!, for: .normal)
        }
    }
    

}
