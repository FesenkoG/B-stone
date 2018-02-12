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
    
    var foreheadAccepted = false
    var noseAccepted = false
    var cheeksAccepted = false
    var aroundAccepted = false
    var chinAccepted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        guard let alergicVC = storyboard?.instantiateViewController(withIdentifier: "AllergicVC") as? AllergicVC else { return }
        presentDetail(alergicVC)
        
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
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
