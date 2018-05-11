//
//  BluetoothVC.swift
//  В-stone
//
//  Created by Георгий Фесенко on 16.02.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit
import CoreBluetooth

class BluetoothVC: UIViewController {
    
    var centralManager: CBCentralManager!
    var someDevicePeripheral: CBPeripheral!
    
    var peripherals = Set<String>()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.selectedImage = UIImage(named: "mm_selected")!.withRenderingMode(.alwaysOriginal)

        
        
        // Do any additional setup after loading the view.
    }

}

extension BluetoothVC: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
        case .resetting:
            print("central.state is .resetting")
        case .unsupported:
            print("central.state is .unsupported")
        case .unauthorized:
            print("central.state is .unauthorized")
        case .poweredOff:
            print("central.state is .poweredOff")
        case .poweredOn:
            centralManager.scanForPeripherals(withServices: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral)
        if let name = peripheral.name {
            peripherals.insert(name)
            print(peripheral)
        }
        print(peripherals.count)
        print(peripherals)
        if let name = peripheral.name, name == "BT05" {
            someDevicePeripheral = peripheral
            someDevicePeripheral.delegate = self
            centralManager.stopScan()
            centralManager.connect(someDevicePeripheral)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        someDevicePeripheral.discoverServices(nil)
    }
}

extension BluetoothVC: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            print("This is a service!")
            
            if service.uuid.uuidString == "FFE0" {
                print(service)
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics {
            print(characteristic)
            //Here could be more properties checked
            if characteristic.properties.contains(.read) {
                
                print("\(characteristic.uuid): properties contains .read")
                peripheral.readValue(for: characteristic)
            }
            if characteristic.properties.contains(.notify) {
                print("\(characteristic.uuid): properties contains .notify")
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        if let data = characteristic.value {
            print("I am here")
            print(data)
            guard let strData = String(data: data, encoding: String.Encoding.ascii) else { return }
            print(strData)
            let floatValue : Float = NSString(string: strData).floatValue
            print(floatValue)
            
            
//            var res: Float64 = 0.0
//            data.getBytes(&res, length: data.length)
//            print(res)
        }
//        switch characteristic.uuid {
//
//        //Here could be more cases
//        case randomUUID:
//            let someDataFromDevice = converterFromDevice(from: characteristic)
//            //Put that value to an UI output
//            heartRateLabel.text = someDataFromDevice
//            print("smth with given value")
//        default:
//            print("Unhandles characterisric UUID:\(characteristic.uuid)")
//        }
    }
    
}
