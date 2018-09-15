//
//  FirstFaceVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 08.05.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class FirstFaceVC: UIViewController, BluetoothDelegate {

    @IBOutlet weak var faceImage: UIImageView!
    @IBOutlet weak var nextScreenLabel: UILabel!
    @IBOutlet weak var nextScreenBtn: UIButton!
    
    var bluetoothService: BluetoothService!
    private var count = 0
    private var flag = false
    
    var bluetoothNumbers = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextScreenBtn.imageEdgeInsets = UIEdgeInsetsMake(25, 25, 12, 20)
        faceImage.image = UIImage.gifImageWithName("firstFace")
        nextScreenLabel.isHidden = true
        nextScreenBtn.isEnabled = false
        
    }
    
    @IBAction func nextScreenBtnWasPressed(_ sender: Any) {
        performSegue(withIdentifier: "toSecondFaceVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let secondFaceVC = segue.destination as? SecondFaceVC else { return }
        secondFaceVC.bluetoothService = bluetoothService
        secondFaceVC.bluetoothService.delegate = secondFaceVC
        secondFaceVC.bluetoothNumbers = bluetoothNumbers
    }
    
    func didRecieveValue(value: Double) {
        print(value)
        if value != -1 && flag == false {
            
            count += 1
            if count == 2 {
                bluetoothNumbers.append(value)
                flag = true
            }
        }
        
        if value != -1 && flag == true {
            nextScreenLabel.text = "remove stone from your face"
            nextScreenLabel.isHidden = false
            nextScreenBtn.isEnabled = false
        }
        
        if value == -1 && flag == true {
            nextScreenLabel.text = "go on to the next screen"
            nextScreenBtn.isEnabled = true
        }
    }
    
}
