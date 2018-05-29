//
//  BluetoothService.swift
//  В-stone
//
//  Created by Георгий Фесенко on 06.05.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import Foundation
import CoreBluetooth

@objc protocol BluetoothDelegate:class {
    @objc optional func didTurnOnBluetooth()
    @objc optional func didRecieveValue(value: Double)
    @objc optional func didConnected()
    @objc optional func didTurnOffBluetooth()
}

class BluetoothService: NSObject {
    var centralManager: CBCentralManager!
    var someDevicePeripheral: CBPeripheral!
    
    weak var delegate: BluetoothDelegate?
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func convertValue(value i: Double) -> Double {
        let bord_1 = 10000.0
        let bord_2 = 3200000.0
        let bord_1_min = 400000.0
        let bord_2_max = 1100000.0
        let border_2 = 80.0
        let border_1 = 100.0
        let bord_min = 100000.0
        let bord_max = 11000000.0
        let max = 65.0
        let min = 75.0
        let min_2 = 65.0
        let max_2 = 50.0
        
        if i < 300000 {
            return 99.0
        }
        
        if(i > 300000 &&  i < 1100000) {
            let percent = (i - bord_1_min) / (bord_2_max - bord_1_min) * (border_2 - border_1) + border_1
            return percent
        } else
            if(i > 1100000 &&  i < 3000000) {
                let percent = (i - bord_1)/(bord_2 - bord_1)*(max - min) + min
                return percent
            }
            else if i > 3000000 && i < 9000000 {
                let percent = (i - bord_min) / (bord_max - bord_min) * (max_2 - min_2) + min_2
                return percent
            } else
                if i > 9000000 {
                    return -1
        }
        
        return -1
    }
}

//MARK: - CBCentralManager Delegate
extension BluetoothService: CBCentralManagerDelegate {
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
            delegate?.didTurnOffBluetooth?()
        case .poweredOn:
            //CBUUID(string: "FFE0")
            centralManager.scanForPeripherals(withServices: nil)
            delegate?.didTurnOnBluetooth?()
            
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        //print(peripheral)
        //print("hello")
//        if let name = peripheral.name {
//            peripherals.insert(name)
//            print(peripheral)
//        }
//        print(peripherals.count)
//        print(peripherals)
        
        if let name = peripheral.name, name == "BT05" {
            someDevicePeripheral = peripheral
            someDevicePeripheral.delegate = self
            centralManager.stopScan()
            centralManager.connect(someDevicePeripheral)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        delegate?.didConnected?()
        someDevicePeripheral.discoverServices(nil)
    }
}

extension BluetoothService: CBPeripheralDelegate {
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
            guard let strData = String(data: data, encoding: String.Encoding.ascii) else {
                print("encoding went wrong")
                return
            }
            let doubleValue : Double = NSString(string: strData).doubleValue
            let convertedValue = convertValue(value: doubleValue)
            print("original: \(doubleValue)")
            print(convertValue(value: doubleValue))
            delegate?.didRecieveValue?(value: convertedValue)
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
