//
//  DataService.swift
//  В-stone
//
//  Created by Георгий Фесенко on 30.01.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private(set) var REF_USERS = DB_BASE.child("users")
    private(set) var REF_QUIZES = DB_BASE.child("quizes")
    
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func uploadUserData(handler: @escaping (_ status: Bool) -> Void) {
        REF_QUIZES.childByAutoId().updateChildValues(["age": CurrentUserData.instance.age!,
                                                      "placeOfLiving": CurrentUserData.instance.placeOfLiving!.rawValue, "habitSunbathing": CurrentUserData.instance.habitSunbathing!, "habitSmoking": CurrentUserData.instance.habitSmoking!, "habitSport": CurrentUserData.instance.habitSport!, "habitDiet": CurrentUserData.instance.habitDiet!, "habitMakeup": CurrentUserData.instance.habitMakeup!, "habitCoffee": CurrentUserData.instance.habitCoffee!, "wrinklesForehead": CurrentUserData.instance.wrinklesForehead!, "wrinklesInterbrow": CurrentUserData.instance.wrinklesInterbrow!, "wrinklesUnderEye": CurrentUserData.instance.wrinklesUnderEye!, "wrinklesSmile": CurrentUserData.instance.wrinklesSmile!, "inflamationsForehead": CurrentUserData.instance.inflamationsForehead!, "inflamationsNose": CurrentUserData.instance.inflamationsNose!, "inflamationsCheeks": CurrentUserData.instance.inflamationsCheeks!, "inflamationsAroundNose": CurrentUserData.instance.inflamationsAroundNose!, "inflamationsChin": CurrentUserData.instance.inflamationsChin!, "allergicReactions": CurrentUserData.instance.allergic!.rawValue, "userId": Auth.auth().currentUser?.uid])
        handler(true)
    }
    
    func checkIfCurrentUserHaveQuizCompleted() -> Bool {
        
        var returnedValue = false
        REF_QUIZES.observeSingleEvent(of: .value) { (quizesSnapshot) in
            guard let quizesSpanshot = quizesSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for quiz in quizesSpanshot {
                let userId = quiz.childSnapshot(forPath: "userId").value as! String
                if userId == Auth.auth().currentUser?.uid {
                    returnedValue = true
                }
            }
        }
        return returnedValue
    }
}
