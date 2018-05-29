//
//  InflamationsVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 30.01.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class InflamationsVC: UIViewController {
    
    
    @IBOutlet weak var foreheadBtn: UIButton!
    @IBOutlet weak var noseBtn: UIButton!
    @IBOutlet weak var cheeksBtn: UIButton!
    @IBOutlet weak var aroundBtn: UIButton!
    @IBOutlet weak var chinBtn: UIButton!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    //Constraints
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightFirstConstraint: NSLayoutConstraint!
    @IBOutlet weak var betweenFirstConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightSecondConstraint: NSLayoutConstraint!
    @IBOutlet weak var betweenSecondConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightThirdConstraint: NSLayoutConstraint!
    @IBOutlet weak var betweenThirdConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightFourthConstraint: NSLayoutConstraint!
    @IBOutlet weak var betweenFourthConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightFifthConstraint: NSLayoutConstraint!
    
    
    
    var foreheadAccepted = false
    var noseAccepted = false
    var cheeksAccepted = false
    var aroundAccepted = false
    var chinAccepted = false
    
    @IBAction func prepareForUnwindToInflamations(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
        nextBtn.imageEdgeInsets = UIEdgeInsetsMake(25, 25, 12, 20)
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(25, 20, 12, 25)
        if let c = CurrentUserData.instance.inflamationsChin, c == true {
            setImage(acceptionStatus: &chinAccepted, image: chinBtn)
        }
        if let c = CurrentUserData.instance.inflamationsNose, c == true {
            setImage(acceptionStatus: &noseAccepted, image: noseBtn)
        }
        if let c = CurrentUserData.instance.inflamationsCheeks, c == true {
            setImage(acceptionStatus: &cheeksAccepted, image: cheeksBtn)
        }
        if let c = CurrentUserData.instance.inflamationsForehead, c == true {
            setImage(acceptionStatus: &foreheadAccepted, image: foreheadBtn)
        }
        if let c = CurrentUserData.instance.inflamationsAroundNose, c == true {
            setImage(acceptionStatus: &aroundAccepted, image: aroundBtn)
        }
        
    }
    
    func configureScreen() {
        //iPhone 8
        if UIScreen.main.bounds.width == 375.0 && UIScreen.main.bounds.height == 667.0 {
            //Do smth for Iphone 8
            topConstraint.constant += 34
            
            rightFirstConstraint.constant += 12
            rightSecondConstraint.constant += 12
            rightThirdConstraint.constant += 12
            rightFourthConstraint.constant += 12
            rightFifthConstraint.constant += 12
            
            betweenFirstConstraint.constant += 8
            betweenSecondConstraint.constant += 8
            betweenThirdConstraint.constant += 4
            betweenFourthConstraint.constant += 8
        }
        //iPhone 8+
        if UIScreen.main.bounds.width == 414.0 && UIScreen.main.bounds.height == 736.0 {
            print("8+")
            topConstraint.constant += 58.2
            
            rightFirstConstraint.constant += 23
            rightSecondConstraint.constant += 23
            rightThirdConstraint.constant += 23
            rightFourthConstraint.constant += 23
            rightFifthConstraint.constant += 23
            
            betweenFirstConstraint.constant += 14
            betweenSecondConstraint.constant += 11
            betweenThirdConstraint.constant += 11
            betweenFourthConstraint.constant += 13
        }
        //iPhone X
        if UIScreen.main.bounds.width == 375.0 && UIScreen.main.bounds.height == 812.0 {
            print("X")
            topConstraint.constant += 50.2
            
            rightFirstConstraint.constant += 2
            rightSecondConstraint.constant += 2
            rightThirdConstraint.constant += 2
            rightFourthConstraint.constant += 2
            rightFifthConstraint.constant += 2
            
            betweenFirstConstraint.constant += 14
            betweenSecondConstraint.constant += 16
            betweenThirdConstraint.constant += 16
            betweenFourthConstraint.constant += 13
            
        }
    }
    
    @IBAction func foreheadBtnWasPressed(_ sender: Any) {
        setImage(acceptionStatus: &foreheadAccepted, image: foreheadBtn)
    }
    
    @IBAction func noseBtnWasPressed(_ sender: Any) {
        setImage(acceptionStatus: &noseAccepted, image: noseBtn)
    }
    
    @IBAction func cheeksBtnWasPressed(_ sender: Any) {
        setImage(acceptionStatus: &cheeksAccepted, image: cheeksBtn)
    }
    
    @IBAction func aroundBtnWasPressed(_ sender: Any) {
        setImage(acceptionStatus: &aroundAccepted, image: aroundBtn)
    }
    
    @IBAction func chinBtnWasPressed(_ sender: Any) {
        setImage(acceptionStatus: &chinAccepted, image: chinBtn)
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        
        CurrentUserData.instance.inflamationsChin = chinAccepted
        CurrentUserData.instance.inflamationsForehead = foreheadAccepted
        CurrentUserData.instance.inflamationsNose = noseAccepted
        CurrentUserData.instance.inflamationsCheeks = cheeksAccepted
        CurrentUserData.instance.inflamationsAroundNose = aroundAccepted
        
        self.performSegue(withIdentifier: "toAllergic", sender: nil)
        
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "backToWrinkles", sender: nil)
    }
    
    func setImage(acceptionStatus: inout Bool, image: UIButton) {
        if acceptionStatus == false {
            acceptionStatus = true
            image.setImage(UIImage(named: "ChooseCircleTrue"), for: .normal)
        } else {
            acceptionStatus = false
            image.setImage(UIImage(named: "ChooseCircleFalse"), for: .normal)
        }
    }
    

}
