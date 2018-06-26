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
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var model: QuizModel!
    
    var sunbathingAccepted = false
    var travellingAccepted = false
    var makeupAccepted = false
    var smokingAccepted = false
    var dietAccepted = false
    var coffeeAccepted = false
    
    @IBAction func prepareForUnwindToLifestyle(segue: UIStoryboardSegue) {}

    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.imageEdgeInsets = UIEdgeInsetsMake(25, 25, 12, 20)
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(25, 20, 12, 25)
        if model.habitSunbathing {
            setImage(acceptionStatus: &sunbathingAccepted, imageName: "sunbathing", image: sunbathingImg)
        }
        if model.habitDiet {
            setImage(acceptionStatus: &dietAccepted, imageName: "diet", image: dietImg)
        }
        if model.habitTravelling {
            setImage(acceptionStatus: &travellingAccepted, imageName: "sport", image: sportImg)
        }
        if model.habitCoffee {
            setImage(acceptionStatus: &coffeeAccepted, imageName: "coffee", image: coffeeImg)
        }
        if model.habitSmoking {
            setImage(acceptionStatus: &smokingAccepted, imageName: "smoking", image: smokingImg)
        }
        if model.habitMakeup {
            setImage(acceptionStatus: &makeupAccepted, imageName: "makeup", image: makeUpImg)
        }
    }


    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
//        CurrentUserData.instance.habitSunbathing = sunbathingAccepted
//        CurrentUserData.instance.habitSport = sportAccepted
//        CurrentUserData.instance.habitDiet = dietAccepted
//        CurrentUserData.instance.habitCoffee = coffeeAccepted
//        CurrentUserData.instance.habitMakeup = makeupAccepted
//        CurrentUserData.instance.habitSmoking = smokingAccepted
        model.habitSunbathing = sunbathingAccepted
        model.habitDiet = dietAccepted
        model.habitCoffee = coffeeAccepted
        model.habitMakeup = makeupAccepted
        model.habitSmoking = smokingAccepted
        model.habitTravelling = travellingAccepted
        
        self.performSegue(withIdentifier: "toWrinkles", sender: nil)
        
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "backToWhereLive", sender: nil)
    }
    
    @IBAction func sunbathingBtnWasPressed(_ sender: Any) {
        setImage(acceptionStatus: &sunbathingAccepted, imageName: "sunbathing", image: sunbathingImg)
    }
    
    @IBAction func smokingBtnWasPressed(_ sender: Any) {
        setImage(acceptionStatus: &smokingAccepted, imageName: "smoking", image: smokingImg)
        
    }
    @IBAction func sportBtnWasPressed(_ sender: Any) {
        setImage(acceptionStatus: &travellingAccepted, imageName: "sport", image: sportImg)
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WrinklesVC {
            vc.model = model
        }
    }
}
