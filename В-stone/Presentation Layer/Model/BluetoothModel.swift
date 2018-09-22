//
//  BluetoothModel.swift
//  В-stone
//
//  Created by Георгий Фесенко on 11.06.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import Foundation


//Надо хранить просто словари, принимать прошлые словари и дополнять их новой информацией.
struct BluetoothModel {
    
//    var prevPercentage: Double?
//    var prevDate: String?
//
//    var currentPercentage: Double?
//    var date: String?
    
    //TODO: - This should be JSON string with all needed parameters
    /*
     {
        "info": [{
            "measuredData": [
                "87.1",
                "80.1",
                "76.1"
            ],
            "date": "13/10/1997 HH:mm:SS"
        }]
     }
     */
    var data: BluetoothStory?
    
}

struct BluetoothStory: Codable {
    let info: [Info]
}

struct Info: Codable {
    let measuredData: [Double]
    let date: String
}

