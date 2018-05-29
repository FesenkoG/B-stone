//
//  WrinklesVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 29.01.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class WrinklesVC: UIViewController {
    
    @IBOutlet weak var foreheadBtn: UIButton!
    @IBOutlet weak var interbrowBtn: UIButton!
    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var smileBtn: UIButton!
    
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    //Constraints
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftFirstConstraint: NSLayoutConstraint!
    @IBOutlet weak var betweenFirstConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftSecondConstraint: NSLayoutConstraint!
    @IBOutlet weak var betweenSecondConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdBetweenConstraint: NSLayoutConstraint!
    @IBOutlet weak var fourthLeftConstraint: NSLayoutConstraint!
    
    
    
    var foreheadAccepted = false
    var interbrowAccepted = false
    var eyeAccepted = false
    var smileAccepted = false
    
    @IBAction func prepareForUnwindToWrinkles(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
        nextBtn.imageEdgeInsets = UIEdgeInsetsMake(25, 25, 12, 20)
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(25, 20, 12, 25)
        if let c = CurrentUserData.instance.wrinklesForehead, c == true {
            setImage(acceptionStatus: &foreheadAccepted, image: foreheadBtn)
        }
        if let c = CurrentUserData.instance.wrinklesSmile, c == true {
            setImage(acceptionStatus: &smileAccepted, image: smileBtn)
        }
        if let c = CurrentUserData.instance.wrinklesUnderEye, c == true {
            setImage(acceptionStatus: &eyeAccepted, image: eyeBtn)
        }
        if let c = CurrentUserData.instance.wrinklesInterbrow, c == true {
            setImage(acceptionStatus: &interbrowAccepted, image: interbrowBtn)
        }
    }

    @IBAction func nextBtnWasPressed(_ sender: Any) {
        
        CurrentUserData.instance.wrinklesSmile = smileAccepted
        CurrentUserData.instance.wrinklesForehead = foreheadAccepted
        CurrentUserData.instance.wrinklesUnderEye = eyeAccepted
        CurrentUserData.instance.wrinklesInterbrow = interbrowAccepted
        
        self.performSegue(withIdentifier: "toInflamations", sender: nil)
    }
    
    func configureScreen() {
        //iPhone 8
        if UIScreen.main.bounds.width == 375.0 && UIScreen.main.bounds.height == 667.0 {
            //Do smth for Iphone 8
            topConstraint.constant += 40.5
            
            leftFirstConstraint.constant += 12
            leftSecondConstraint.constant += 12
            thirdLeftConstraint.constant += 12
            fourthLeftConstraint.constant += 12
            
            betweenFirstConstraint.constant += 1.5
            betweenSecondConstraint.constant += 5
            thirdBetweenConstraint.constant += 9
        }
        //iPhone 8+
        if UIScreen.main.bounds.width == 414.0 && UIScreen.main.bounds.height == 736.0 {
            print("8+")
            topConstraint.constant += 64.7
            
            leftFirstConstraint.constant += 24
            leftSecondConstraint.constant += 24
            thirdLeftConstraint.constant += 24
            fourthLeftConstraint.constant += 24
            
            betweenFirstConstraint.constant += 7.5
            betweenSecondConstraint.constant += 13
            thirdBetweenConstraint.constant += 10
        }
        //iPhone X
        if UIScreen.main.bounds.width == 375.0 && UIScreen.main.bounds.height == 812.0 {
            print("X")
            topConstraint.constant += 54.7
            
            leftFirstConstraint.constant += 8
            leftSecondConstraint.constant += 8
            thirdLeftConstraint.constant += 8
            fourthLeftConstraint.constant += 8
            
            betweenFirstConstraint.constant += 10.5
            betweenSecondConstraint.constant += 12
            thirdBetweenConstraint.constant += 18
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "backToLifestyle", sender: nil)
    }
    
    @IBAction func foreheadBtnWasPressed(_ sender: Any) {
        setImage(acceptionStatus: &foreheadAccepted, image: foreheadBtn)
    }
    
    @IBAction func interbrowBtnWasPressed(_ sender: Any) {
        setImage(acceptionStatus: &interbrowAccepted, image: interbrowBtn)

    }
    
    @IBAction func eyeBtnWasPressed(_ sender: Any) {
        setImage(acceptionStatus: &eyeAccepted, image: eyeBtn)

    }
    
    @IBAction func smileBtnWasPressed(_ sender: Any) {
        setImage(acceptionStatus: &smileAccepted, image: smileBtn)
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
