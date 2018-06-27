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
    
    var bluetoothNumbers: [Double]?
    var bluetoothModel: BluetoothModel!
    
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
        let mean = (bluetoothNumbers!.reduce(0, +)) / 3.0
        
        if bluetoothModel.currentPercentage == nil {
            bluetoothModel.currentPercentage = mean
            bluetoothModel.prevPercentage = -1
            bluetoothModel.prevDate = formatter.string(from: Date())
            bluetoothModel.date = formatter.string(from: Date())
            bluetoothModel.data.append([bluetoothNumbers!, Date()])
        } else {
            bluetoothModel.prevPercentage = bluetoothModel.currentPercentage
            bluetoothModel.currentPercentage = mean
            bluetoothModel.prevDate = bluetoothModel.date
            bluetoothModel.date = formatter.string(from: Date())
        }
        
        DataService.instance.uploadBluetoothData(model: bluetoothModel) { (success) in
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
                bluetoothNumbers?.append(value)
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
