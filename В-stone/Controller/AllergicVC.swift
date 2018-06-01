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
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var allergic: Allergic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.imageEdgeInsets = UIEdgeInsetsMake(25, 25, 12, 20)
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(25, 20, 12, 25)
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
            
            DataService.instance.uploadUserData(handler: { (success) in
                if success {
                    if AppData.shared.isHomeExists {
                        AppData.shared.isEditScreenExists = false
                        self.performSegue(withIdentifier: "unwindToHome", sender: nil)
                    } else {
                        self.performSegue(withIdentifier: "finishedEditing", sender: nil)
                    }
                }
            })
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "backToInflamations", sender: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UITabBarController {
            vc.selectedIndex = CurrentUserData.instance.selectedIndex
        }
    }

}
