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
    
    var foreheadAccepted = false
    var interbrowAccepted = false
    var eyeAccepted = false
    var smileAccepted = false
    
    @IBAction func prepareForUnwindToWrinkles(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
