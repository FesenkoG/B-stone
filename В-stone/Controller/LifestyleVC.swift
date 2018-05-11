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
    
    @IBAction func prepareForUnwindToLifestyle(segue: UIStoryboardSegue) {}

    override func viewDidLoad() {
        super.viewDidLoad()
        if let c = CurrentUserData.instance.habitSunbathing, c == true {
            setImage(acceptionStatus: &sunbathingAccepted, imageName: "sunbathing", image: sunbathingImg)
        }
        if let c = CurrentUserData.instance.habitDiet, c == true {
            setImage(acceptionStatus: &dietAccepted, imageName: "diet", image: dietImg)
        }
        if let c = CurrentUserData.instance.habitSport, c == true {
            setImage(acceptionStatus: &sportAccepted, imageName: "sport", image: sportImg)
        }
        if let c = CurrentUserData.instance.habitCoffee, c == true {
            setImage(acceptionStatus: &coffeeAccepted, imageName: "coffee", image: coffeeImg)
        }
        if let c = CurrentUserData.instance.habitSmoking, c == true {
            setImage(acceptionStatus: &smokingAccepted, imageName: "smoking", image: smokingImg)
        }
        if let c = CurrentUserData.instance.habitMakeup, c == true {
            setImage(acceptionStatus: &makeupAccepted, imageName: "makeup", image: makeUpImg)
        }
    }


    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        CurrentUserData.instance.habitSunbathing = sunbathingAccepted
        CurrentUserData.instance.habitSport = sportAccepted
        CurrentUserData.instance.habitDiet = dietAccepted
        CurrentUserData.instance.habitCoffee = coffeeAccepted
        CurrentUserData.instance.habitMakeup = makeupAccepted
        CurrentUserData.instance.habitSmoking = smokingAccepted
        
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
