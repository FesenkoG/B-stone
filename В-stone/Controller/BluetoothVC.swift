//
//  BluetoothVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 16.02.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class BluetoothVC: UIViewController, BluetoothDelegate {
    
    @IBOutlet weak var startScanningBtn: UIButton!
    lazy var bluetoothService = BluetoothService()
    var isConnected = false
    
    var bluetoothModel: BluetoothModel?
    var localDataService: LocalDataService!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bluetoothService.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
        tabBarController?.tabBar.unselectedItemTintColor = UIColor.white
        self.tabBarItem.selectedImage = UIImage(named: "mm_selected")!.withRenderingMode(.alwaysOriginal)
        startScanningBtn.isEnabled = false
        startScanningBtn.alpha = 0

    }

    
    func configureScreen() {
        //iPhone 8
        if UIScreen.main.bounds.width == 375.0 && UIScreen.main.bounds.height == 667.0 {
            //Do smth for Iphone 8
            
        }
        //iPhone 8+
        if UIScreen.main.bounds.width == 414.0 && UIScreen.main.bounds.height == 736.0 {
            print("8+")
            
        }
        //iPhone X
        if UIScreen.main.bounds.width == 375.0 && UIScreen.main.bounds.height == 812.0 {
            print("X")
            
        }
    }
    
    func loadUserData() {
        
        let resultBluetooth = localDataService.fetchBluetoothData()
        switch resultBluetooth {
        case .success(let bluetooth):
            bluetoothModel = bluetooth
        case .failure(let error):
            bluetoothModel = nil
            print(error)
        }
    }
    
    @IBAction func startScanningBtnWasPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toStoneVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let stoneVC = segue.destination as? StoneVC else { return }
        stoneVC.bluetoothService = bluetoothService
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

