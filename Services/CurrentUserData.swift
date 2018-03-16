//
//  CurrentUserData.swift
//  В-stone
//
//  Created by Георгий Фесенко on 05.02.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class CurrentUserData {
    
    static let instance = CurrentUserData()
    
    var age: Int?
        
    var placeOfLiving: PlaceOfLiving?
    
    var habitSunbathing: Bool?
    var habitSmoking: Bool?
    var habitSport: Bool?
    var habitDiet: Bool?
    var habitMakeup: Bool?
    var habitCoffee: Bool?
    
    var wrinklesForehead: Bool?
    var wrinklesInterbrow: Bool?
    var wrinklesUnderEye: Bool?
    var wrinklesSmile: Bool?
    
    var inflamationsForehead: Bool?
    var inflamationsNose: Bool?
    var inflamationsCheeks: Bool?
    var inflamationsAroundNose: Bool?
    var inflamationsChin: Bool?
    
    var allergic: Allergic?
    
    var email: String?
    var password: String?
    
}
