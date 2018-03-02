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
        var childUidToUpdate: String?
        let myGroup = DispatchGroup()
        myGroup.enter()
        DispatchQueue.main.async {
            self.REF_QUIZES.observeSingleEvent(of: .value) { (dataSnapshot) in
                
                guard let dataSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else { return }
                for quiz in dataSnapshot {
                    let uid = quiz.childSnapshot(forPath: "userId").value as! String
                    if uid == Auth.auth().currentUser?.uid {
                        childUidToUpdate = quiz.key
                    }
                }
                myGroup.leave()
            }
            
        }
        
        
        myGroup.notify(queue: .main) {
            if let uidToUpdate = childUidToUpdate {
                self.REF_QUIZES.child(uidToUpdate).updateChildValues(["age": CurrentUserData.instance.age!,
                                                                 "placeOfLiving": CurrentUserData.instance.placeOfLiving!.rawValue, "habitSunbathing": CurrentUserData.instance.habitSunbathing!, "habitSmoking": CurrentUserData.instance.habitSmoking!, "habitSport": CurrentUserData.instance.habitSport!, "habitDiet": CurrentUserData.instance.habitDiet!, "habitMakeup": CurrentUserData.instance.habitMakeup!, "habitCoffee": CurrentUserData.instance.habitCoffee!, "wrinklesForehead": CurrentUserData.instance.wrinklesForehead!, "wrinklesInterbrow": CurrentUserData.instance.wrinklesInterbrow!, "wrinklesUnderEye": CurrentUserData.instance.wrinklesUnderEye!, "wrinklesSmile": CurrentUserData.instance.wrinklesSmile!, "inflamationsForehead": CurrentUserData.instance.inflamationsForehead!, "inflamationsNose": CurrentUserData.instance.inflamationsNose!, "inflamationsCheeks": CurrentUserData.instance.inflamationsCheeks!, "inflamationsAroundNose": CurrentUserData.instance.inflamationsAroundNose!, "inflamationsChin": CurrentUserData.instance.inflamationsChin!, "allergicReactions": CurrentUserData.instance.allergic!.rawValue, "userId": Auth.auth().currentUser?.uid])
            } else {
                self.REF_QUIZES.childByAutoId().updateChildValues(["age": CurrentUserData.instance.age!,
                                                              "placeOfLiving": CurrentUserData.instance.placeOfLiving!.rawValue, "habitSunbathing": CurrentUserData.instance.habitSunbathing!, "habitSmoking": CurrentUserData.instance.habitSmoking!, "habitSport": CurrentUserData.instance.habitSport!, "habitDiet": CurrentUserData.instance.habitDiet!, "habitMakeup": CurrentUserData.instance.habitMakeup!, "habitCoffee": CurrentUserData.instance.habitCoffee!, "wrinklesForehead": CurrentUserData.instance.wrinklesForehead!, "wrinklesInterbrow": CurrentUserData.instance.wrinklesInterbrow!, "wrinklesUnderEye": CurrentUserData.instance.wrinklesUnderEye!, "wrinklesSmile": CurrentUserData.instance.wrinklesSmile!, "inflamationsForehead": CurrentUserData.instance.inflamationsForehead!, "inflamationsNose": CurrentUserData.instance.inflamationsNose!, "inflamationsCheeks": CurrentUserData.instance.inflamationsCheeks!, "inflamationsAroundNose": CurrentUserData.instance.inflamationsAroundNose!, "inflamationsChin": CurrentUserData.instance.inflamationsChin!, "allergicReactions": CurrentUserData.instance.allergic!.rawValue, "userId": Auth.auth().currentUser?.uid])
            }
        }
        handler(true)
    }
    
    func checkIfCurrentUserHaveQuizCompleted(handler: @escaping (_ status: Bool) -> ()) {
        var result = false
        REF_QUIZES.observeSingleEvent(of: .value) { (quizesSnapshot) in
            guard let quizesSpanshot = quizesSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for quiz in quizesSpanshot {
                let userId = quiz.childSnapshot(forPath: "userId").value as! String
                if userId == Auth.auth().currentUser?.uid {
                    result = true
                    CurrentUserData.instance.age = quiz.childSnapshot(forPath: "age").value as! Int
                    CurrentUserData.instance.allergic = Allergic(rawValue: quiz.childSnapshot(forPath: "allergicReactions").value as! String)
                    CurrentUserData.instance.habitCoffee = quiz.childSnapshot(forPath: "habitCoffee").value as! Bool
                    CurrentUserData.instance.habitDiet = quiz.childSnapshot(forPath: "habitDiet").value as! Bool
                    CurrentUserData.instance.habitSport = quiz.childSnapshot(forPath: "habitSport").value as! Bool
                    CurrentUserData.instance.habitMakeup = quiz.childSnapshot(forPath: "habitMakeup").value as! Bool
                    CurrentUserData.instance.habitSmoking = quiz.childSnapshot(forPath: "habitSmoking").value as! Bool
                    CurrentUserData.instance.habitSunbathing = quiz.childSnapshot(forPath: "habitSunbathing").value as! Bool
                    CurrentUserData.instance.wrinklesForehead = quiz.childSnapshot(forPath: "wrinklesForehead").value as! Bool
                    CurrentUserData.instance.wrinklesSmile = quiz.childSnapshot(forPath: "wrinklesSmile").value as! Bool
                    CurrentUserData.instance.wrinklesUnderEye = quiz.childSnapshot(forPath: "wrinklesUnderEye").value as! Bool
                    CurrentUserData.instance.wrinklesInterbrow = quiz.childSnapshot(forPath: "wrinklesInterbrow").value as! Bool
                    CurrentUserData.instance.inflamationsAroundNose = quiz.childSnapshot(forPath: "inflamationsAroundNose").value as! Bool
                    CurrentUserData.instance.inflamationsChin = quiz.childSnapshot(forPath: "inflamationsChin").value as! Bool
                    CurrentUserData.instance.inflamationsNose = quiz.childSnapshot(forPath: "inflamationsNose").value as! Bool
                    CurrentUserData.instance.inflamationsCheeks = quiz.childSnapshot(forPath: "inflamationsCheeks").value as! Bool
                    CurrentUserData.instance.inflamationsForehead = quiz.childSnapshot(forPath: "inflamationsForehead").value as! Bool
                    CurrentUserData.instance.placeOfLiving = PlaceOfLiving(rawValue: quiz.childSnapshot(forPath: "placeOfLiving").value as! String)
                    handler(true)
                }
            }
            if !result {
                handler(false)
            }
        }
    }
}
