//
//  ThirdFaceVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 08.05.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class ThirdFaceVC: UIViewController, BluetoothDelegate {
    
    var bluetoothSerice: BluetoothService!

    @IBOutlet weak var thirdFaceImg: UIImageView!
    @IBOutlet weak var nextScreenLbl: UILabel!
    @IBOutlet weak var nextScreenBtn: UIButton!
    
    private var count = 0
    private var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextScreenBtn.imageEdgeInsets = UIEdgeInsetsMake(25, 25, 12, 20)
        thirdFaceImg.image = UIImage.gifImageWithName("thirdFace")
        nextScreenLbl.isHidden = true
        nextScreenBtn.isEnabled = false
        
    }
    
    @IBAction func nextScreenBtnWasPressed(_ sender: Any) {
        // Тут можно обновлять пользовательскую информацию
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        let mean = (CurrentUserData.instance.firstFace! + CurrentUserData.instance.secondFace! + CurrentUserData.instance.thirdFace!) / 3.0
        
        if CurrentUserData.instance.currentPercantage == nil {
            CurrentUserData.instance.currentPercantage = mean
            CurrentUserData.instance.prevPercantage = -1
            CurrentUserData.instance.prevDate = formatter.string(from: Date())
            CurrentUserData.instance.date = formatter.string(from: Date())
        } else {
            CurrentUserData.instance.prevPercantage = CurrentUserData.instance.currentPercantage
            CurrentUserData.instance.currentPercantage = mean
            CurrentUserData.instance.prevDate = CurrentUserData.instance.date
            CurrentUserData.instance.date = formatter.string(from: Date())
        }
        
        DataService.instance.uploadBluetoothData { (success) in
            if success {
                self.performSegue(withIdentifier: "toBluetoothVC", sender: nil)
            } else {
                print("Something went wrong")
            }
        }
        
    }
    
    func didRecieveValue(value: Double) {
        if value != -1 && flag == false {
            count += 1
            if count == 2 {
                CurrentUserData.instance.thirdFace = value
                flag = true
            }
        }
        
        if value != -1 && flag == true {
            nextScreenLbl.text = "remove stone from your face"
            nextScreenLbl.isHidden = false
            nextScreenBtn.isEnabled = false
        }
        
        if value == -1 && flag == true {
            nextScreenLbl.text = "go on to the next screen"
            nextScreenBtn.isEnabled = true
        }
    }
}
