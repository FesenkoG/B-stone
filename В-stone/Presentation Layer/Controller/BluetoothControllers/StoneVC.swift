//
//  StoneVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 08.05.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class StoneVC: UIViewController, BluetoothDelegate {
    
    var bluetoothService: BluetoothService!
    var isConnected = false

    @IBOutlet weak var stoneImage: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bluetoothService.delegate = self
        stoneImage.image = UIImage.gifImageWithName("stoneGIF")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextBtn.imageEdgeInsets = UIEdgeInsetsMake(25, 25, 12, 20)
        
        if isConnected == true {
            nextBtn.isEnabled = true
        } else {
            nextBtn.isEnabled = false
        }
        
        
        
    }

    @IBAction func nextBtnWasPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "toFirstFaceVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let firstFaceVC = segue.destination as? FirstFaceVC else { return }
        firstFaceVC.bluetoothService = bluetoothService
        firstFaceVC.bluetoothService.delegate = firstFaceVC
    }
    
    func didConnected() {
        isConnected = true
        nextBtn.isEnabled = true
    }

}
