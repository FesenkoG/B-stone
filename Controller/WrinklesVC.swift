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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func nextBtnWasPressed(_ sender: Any) {
        
        CurrentUserData.instance.wrinklesSmile = smileAccepted
        CurrentUserData.instance.wrinklesForehead = foreheadAccepted
        CurrentUserData.instance.wrinklesUnderEye = eyeAccepted
        CurrentUserData.instance.wrinklesInterbrow = interbrowAccepted
        
        guard let inflamationsVC = storyboard?.instantiateViewController(withIdentifier: "InflamationsVC") as? InflamationsVC else { return }
        presentDetail(inflamationsVC)
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
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
