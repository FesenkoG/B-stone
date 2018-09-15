//
//  QuizModel.swift
//  В-stone
//
//  Created by Георгий Фесенко on 11.06.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import Foundation

struct QuizModel {
    var age: Int = 0
    var allergic: Allergic?
    
    var placeOfLiving: PlaceOfLiving?
    
    var habitCoffee: Bool = false
    var habitDiet: Bool = false
    var habitMakeup: Bool = false
    var habitSmoking: Bool = false
    var habitTravelling: Bool = false
    var habitSunbathing: Bool = false
    
    var inflamationsAroundNose: Bool = false
    var inflamationsCheeks: Bool = false
    var inflamationsChin: Bool = false
    var inflamationsForehead: Bool = false
    var inflamationsNose: Bool = false
    
    var wrinklesForehead: Bool = false
    var wrinklesInterbrow: Bool = false
    var wrinklesSmile: Bool = false
    var wrinklesUnderEye: Bool = false
}
