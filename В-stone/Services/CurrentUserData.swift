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
    
    var prevPercantage: Double?
    var currentPercantage: Double?
    
    var firstFace: Double?
    var secondFace: Double?
    var thirdFace: Double?
    
    var date: String?
    var prevDate: String?
    
    var selectedIndex = 2
    
}

func clearUserData() {
    
    CurrentUserData.instance.age = nil
    CurrentUserData.instance.allergic = nil
    CurrentUserData.instance.email = nil
    CurrentUserData.instance.habitCoffee = nil
    CurrentUserData.instance.habitDiet = nil
    CurrentUserData.instance.habitMakeup = nil
    CurrentUserData.instance.habitSmoking = nil
    CurrentUserData.instance.habitSport = nil
    CurrentUserData.instance.habitSunbathing = nil
    CurrentUserData.instance.inflamationsAroundNose = nil
    CurrentUserData.instance.inflamationsCheeks = nil
    CurrentUserData.instance.inflamationsChin = nil
    CurrentUserData.instance.inflamationsForehead = nil
    CurrentUserData.instance.inflamationsNose = nil
    CurrentUserData.instance.placeOfLiving = nil
    CurrentUserData.instance.wrinklesForehead = nil
    CurrentUserData.instance.wrinklesInterbrow = nil
    CurrentUserData.instance.wrinklesSmile = nil
    CurrentUserData.instance.wrinklesUnderEye = nil
    CurrentUserData.instance.prevPercantage = nil
    CurrentUserData.instance.currentPercantage = nil
    CurrentUserData.instance.date = nil
    CurrentUserData.instance.prevDate = nil
    CurrentUserData.instance.currentPercantage = nil
    CurrentUserData.instance.prevPercantage = nil
    
    
}
