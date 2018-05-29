//
//  SecondFaceVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 08.05.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class SecondFaceVC: UIViewController, BluetoothDelegate {
    
    var bluetoothService: BluetoothService!

    @IBOutlet weak var secondFaceImg: UIImageView!
    @IBOutlet weak var nextScreenBtn: UIButton!
    @IBOutlet weak var nextScreenLbl: UILabel!
    
    private var count = 0
    private var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextScreenBtn.imageEdgeInsets = UIEdgeInsetsMake(25, 25, 12, 20)
        secondFaceImg.image = UIImage.gifImageWithName("secondFace")
        nextScreenBtn.isEnabled = false
        nextScreenLbl.isHidden = true
    }
    
    @IBAction func nextScreenBtnWasPressed(_ sender: Any) {
        performSegue(withIdentifier: "toThirdFaceVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let thirdFaceVC = segue.destination as? ThirdFaceVC else { return }
        thirdFaceVC.bluetoothSerice = bluetoothService
        thirdFaceVC.bluetoothSerice.delegate = thirdFaceVC
    }
    
    func didRecieveValue(value: Double) {
        if value != -1 && flag == false {
            count += 1
            if count == 2 {
                CurrentUserData.instance.secondFace = value
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
