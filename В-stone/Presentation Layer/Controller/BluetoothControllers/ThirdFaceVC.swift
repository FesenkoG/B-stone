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
    var localStorage = LocalDataService()

    @IBOutlet weak var thirdFaceImg: UIImageView!
    @IBOutlet weak var nextScreenLbl: UILabel!
    @IBOutlet weak var nextScreenBtn: UIButton!
    
    private var count = 0
    private var flag = false
    
    var bluetoothNumbers: [Double]?
    
    //THIS IS NOT WORKING, this is nil
    //TODO: -
    override func viewDidLoad() {
        super.viewDidLoad()
        nextScreenBtn.imageEdgeInsets = UIEdgeInsetsMake(25, 25, 12, 20)
        thirdFaceImg.image = UIImage.gifImageWithName("thirdFace")
        nextScreenLbl.isHidden = true
        nextScreenBtn.isEnabled = false
        
    }
    
    @IBAction func nextScreenBtnWasPressed(_ sender: Any) {
        guard let bluetoothNumbers = bluetoothNumbers, bluetoothNumbers
            .count == 3 else {
                nextScreenLbl.text = "Something is wrong, please try again";
                nextScreenLbl.isHidden = false
                return
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        var bluetoothInfo = [BluetoothInfo]()
        let currentInfo = BluetoothInfo(measuredData: bluetoothNumbers, date: formatter.string(from: Date()))
        DataService.instance.checkIfCurrentUserHaveBluetoothData { (success, info) in
            if success, let info = info {
                bluetoothInfo = info
                bluetoothInfo.append(currentInfo)
            } else {
                bluetoothInfo = [currentInfo]
            }
            self.localStorage.saveBluetoothData(model: bluetoothInfo, handler: { (success) in
                DataService.instance.uploadBluetoothData(model: bluetoothInfo) { (success) in
                    if success {
                        self.performSegue(withIdentifier: "toBluetoothVC", sender: nil)
                    } else {
                        print("Something went wrong")
                    }
                }
            })
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
