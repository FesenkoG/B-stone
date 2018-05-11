//
//  BluetoothVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 16.02.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit
import CoreBluetooth

class BluetoothVC: UIViewController, BluetoothDelegate {
    
    @IBOutlet weak var startScanningBtn: UIButton!
    lazy var bluetoothService = BluetoothService()
    var isConnected = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bluetoothService.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.unselectedItemTintColor = UIColor.white
        self.tabBarItem.selectedImage = UIImage(named: "mm_selected")!.withRenderingMode(.alwaysOriginal)
        startScanningBtn.isEnabled = false
        startScanningBtn.alpha = 0
    }

    @IBAction func startScanningBtnWasPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toStoneVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let stoneVC = segue.destination as? StoneVC else { return }
        stoneVC.bluetoothService = bluetoothService
        stoneVC.bluetoothService.delegate = stoneVC
        stoneVC.isConnected = isConnected
    }
    
    //MARK: - Bluetooth Delegate
    func didConnected() {
        isConnected = true
    }
    
    func didTurnOnBluetooth() {
        UIView.animate(withDuration: 1.5) {
            self.startScanningBtn.isEnabled = true
            self.startScanningBtn.alpha = 1.0
        }
    }
    
    func didTurnOffBluetooth() {
        UIView.animate(withDuration: 1.5) {
            self.startScanningBtn.isEnabled = false
            self.startScanningBtn.alpha = 0.0
        }
    }

    
}

