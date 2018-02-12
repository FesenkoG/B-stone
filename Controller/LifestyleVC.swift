//
//  LifestyleVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 30.01.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class LifestyleVC: UIViewController {
    
    @IBOutlet weak var makeUpImg: UIImageView!
    @IBOutlet weak var sunbathingImg: UIImageView!
    @IBOutlet weak var sportImg: UIImageView!
    @IBOutlet weak var smokingImg: UIImageView!
    @IBOutlet weak var dietImg: UIImageView!
    @IBOutlet weak var coffeeImg: UIImageView!
    
    var sunbathingAccepted = false
    var sportAccepted = false
    var makeupAccepted = false
    var smokingAccepted = false
    var dietAccepted = false
    var coffeeAccepted = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        CurrentUserData.instance.habitSunbathing = sunbathingAccepted
        CurrentUserData.instance.habitSport = sportAccepted
        CurrentUserData.instance.habitDiet = dietAccepted
        CurrentUserData.instance.habitCoffee = coffeeAccepted
        CurrentUserData.instance.habitMakeup = makeupAccepted
        CurrentUserData.instance.habitSmoking = smokingAccepted
        
        guard let wrinklesVC = storyboard?.instantiateViewController(withIdentifier: "WrinklesVC") else { return }
        presentDetail(wrinklesVC)
        
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
        
    }
    
    @IBAction func sunbathingBtnWasPressed(_ sender: Any) {
        setImage(acceptionStatus: &sunbathingAccepted, imageName: "sunbathing", image: sunbathingImg)
    }
    
    @IBAction func smokingBtnWasPressed(_ sender: Any) {
        setImage(acceptionStatus: &smokingAccepted, imageName: "smoking", image: smokingImg)
        
    }
    @IBAction func sportBtnWasPressed(_ sender: Any) {
        setImage(acceptionStatus: &sportAccepted, imageName: "sport", image: sportImg)
        
    }
    
    @IBAction func dietBtnWasPressed(_ sender: Any) {
        setImage(acceptionStatus: &dietAccepted, imageName: "diet", image: dietImg)
        
    }
    
    @IBAction func makeupBtnWasPressed(_ sender: Any) {
        setImage(acceptionStatus: &makeupAccepted, imageName: "makeup", image: makeUpImg)
        
    }
    
    @IBAction func coffeeBtnWasPressed(_ sender: Any) {
        setImage(acceptionStatus: &coffeeAccepted, imageName: "coffee", image: coffeeImg)
        
    }
    
    func setImage(acceptionStatus: inout Bool, imageName: String, image: UIImageView) {
        if acceptionStatus == false {
            acceptionStatus = true
            image.image = UIImage(named: imageName + "Selected")
        } else {
            acceptionStatus = false
            image.image = UIImage(named: imageName)
        }
    }
    
    
}
