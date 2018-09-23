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
    private(set) var REF_BLUETOOTH = DB_BASE.child("bluetooth")
    
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }

    //MARK: - BluetoothServices
    func uploadBluetoothData(model: [BluetoothInfo], handler: @escaping (_ status: Bool) -> Void) {
        var childUidToUpdate: String?
        let myGroup = DispatchGroup()
        myGroup.enter()
        DispatchQueue.main.async {
            self.REF_BLUETOOTH.observeSingleEvent(of: .value) { (dataSnapshot) in
                
                guard let dataSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else { return }
                for blData in dataSnapshot {
                    let uid = blData.childSnapshot(forPath: "userId").value as! String
                    if uid == Auth.auth().currentUser?.uid {
                        childUidToUpdate = blData.key
                    }
                }
                myGroup.leave()
            }
        }
        myGroup.notify(queue: .main) {
            
            let dataString = String(data: (try! JSONEncoder().encode(model)), encoding: .utf8)!
            if let uidToUpdate = childUidToUpdate {
                self.REF_BLUETOOTH.child(uidToUpdate).updateChildValues(
                    ["data": dataString,
                     "userId": (Auth.auth().currentUser?.uid)!])
                handler(true)
            } else {
                self.REF_BLUETOOTH.childByAutoId().updateChildValues(
                    ["data": dataString,
                     "userId": (Auth.auth().currentUser?.uid)!])
                handler(true)
            }
        }
    }
    
    func checkIfCurrentUserHaveBluetoothData(handler: @escaping (Bool, [BluetoothInfo]?) -> Void) {
        var result = false
        REF_BLUETOOTH.observeSingleEvent(of: .value) { (quizesSnapshot) in
            guard let bluetoothSpanshots = quizesSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for blData in bluetoothSpanshots {
                let userId = blData.childSnapshot(forPath: "userId").value as! String
                if userId == (Auth.auth().currentUser?.uid)! {
                    result = true
                    let stringData = blData.childSnapshot(forPath: "data").value as! String
                    let data = try? JSONDecoder().decode([BluetoothInfo].self, from: stringData.data(using: .utf8)!)
                    handler(true, data)
                    break
                }
            }
            if !result {
                handler(false, nil)
            }
        }
    }
    
    //MARK: - Quiz Services
    func uploadUserData(quizModel: QuizModel, handler: @escaping (_ status: Bool) -> Void) {
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
                self.REF_QUIZES
                    .child(uidToUpdate)
                    .updateChildValues([
                        "age": quizModel.age,
                        "placeOfLiving": quizModel.placeOfLiving!.rawValue,
                        "habitSunbathing": quizModel.habitSunbathing,
                        "habitSmoking": quizModel.habitSmoking,
                        "habitSport": quizModel.habitTravelling,
                        "habitDiet": quizModel.habitDiet,
                        "habitMakeup": quizModel.habitMakeup,
                        "habitCoffee": quizModel.habitCoffee,
                        "wrinklesForehead": quizModel.wrinklesForehead,
                        "wrinklesInterbrow": quizModel.wrinklesInterbrow,
                        "wrinklesUnderEye": quizModel.wrinklesUnderEye,
                        "wrinklesSmile": quizModel.wrinklesSmile,
                        "inflamationsForehead": quizModel.inflamationsForehead,
                        "inflamationsNose": quizModel.inflamationsNose,
                        "inflamationsCheeks": quizModel.inflamationsCheeks,
                        "inflamationsAroundNose": quizModel.inflamationsAroundNose,
                        "inflamationsChin": quizModel.inflamationsChin,
                        "allergicReactions": quizModel.allergic!.rawValue,
                        "userId": Auth.auth().currentUser?.uid as Any])
                
            } else {
                self.REF_QUIZES
                    .childByAutoId()
                    .updateChildValues([
                        "age": quizModel.age,
                        "placeOfLiving": quizModel.placeOfLiving!.rawValue,
                        "habitSunbathing": quizModel.habitSunbathing,
                        "habitSmoking": quizModel.habitSmoking,
                        "habitSport": quizModel.habitTravelling,
                        "habitDiet": quizModel.habitDiet,
                        "habitMakeup": quizModel.habitMakeup,
                        "habitCoffee": quizModel.habitCoffee,
                        "wrinklesForehead": quizModel.wrinklesForehead,
                        "wrinklesInterbrow": quizModel.wrinklesInterbrow,
                        "wrinklesUnderEye": quizModel.wrinklesUnderEye,
                        "wrinklesSmile": quizModel.wrinklesSmile,
                        "inflamationsForehead": quizModel.inflamationsForehead,
                        "inflamationsNose": quizModel.inflamationsNose,
                        "inflamationsCheeks": quizModel.inflamationsCheeks,
                        "inflamationsAroundNose": quizModel.inflamationsAroundNose,
                        "inflamationsChin": quizModel.inflamationsChin,
                        "allergicReactions": quizModel.allergic!.rawValue,
                        "userId": Auth.auth().currentUser?.uid as Any])
                
            }
        }
        handler(true)
    }
    
    func checkIfCurrentUserHaveQuizCompleted(handler: @escaping (_ status: Bool, _ model: QuizModel?) -> ()) {
        var result = false
        REF_QUIZES.observeSingleEvent(of: .value) { (quizesSnapshot) in
            guard let quizesSpanshot = quizesSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for quiz in quizesSpanshot {
                let userId = quiz.childSnapshot(forPath: "userId").value as! String
                if userId == Auth.auth().currentUser?.uid {
                    result = true
                    var model = QuizModel()
                    model.age = quiz.childSnapshot(forPath: "age").value as! Int
                    model.allergic = Allergic(rawValue: quiz.childSnapshot(forPath: "allergicReactions").value as! String)
                    model.habitCoffee = quiz.childSnapshot(forPath: "habitCoffee").value as! Bool
                    model.habitDiet = quiz.childSnapshot(forPath: "habitDiet").value as! Bool
                    model.habitTravelling = quiz.childSnapshot(forPath: "habitSport").value as! Bool
                    model.habitMakeup = quiz.childSnapshot(forPath: "habitMakeup").value as! Bool
                    model.habitSmoking = quiz.childSnapshot(forPath: "habitSmoking").value as! Bool
                    model.habitSunbathing = quiz.childSnapshot(forPath: "habitSunbathing").value as! Bool
                    model.wrinklesForehead = quiz.childSnapshot(forPath: "wrinklesForehead").value as! Bool
                    model.wrinklesSmile = quiz.childSnapshot(forPath: "wrinklesSmile").value as! Bool
                    model.wrinklesUnderEye = quiz.childSnapshot(forPath: "wrinklesUnderEye").value as! Bool
                    model.wrinklesInterbrow = quiz.childSnapshot(forPath: "wrinklesInterbrow").value as! Bool
                    model.inflamationsAroundNose = quiz.childSnapshot(forPath: "inflamationsAroundNose").value as! Bool
                    model.inflamationsChin = quiz.childSnapshot(forPath: "inflamationsChin").value as! Bool
                    model.inflamationsNose = quiz.childSnapshot(forPath: "inflamationsNose").value as! Bool
                    model.inflamationsCheeks = quiz.childSnapshot(forPath: "inflamationsCheeks").value as! Bool
                    model.inflamationsForehead = quiz.childSnapshot(forPath: "inflamationsForehead").value as! Bool
                    model.placeOfLiving = PlaceOfLiving(rawValue: quiz.childSnapshot(forPath: "placeOfLiving").value as! String)
                    handler(true, model)
                    break
                }
            }
            if !result {
                handler(false, nil)
            }
        }
    }
    
    func deleteUser(withId id: String, completionHandler: @escaping (Bool) -> Void) {
        //Remove user
        REF_USERS.child(id).removeValue()
        //Remove bluetooth data
        var bluetoothUidToDelete: String?
        var quizUidToDelete: String?
        let myGroup = DispatchGroup()
        myGroup.enter()
        DispatchQueue.main.async {
            self.REF_BLUETOOTH.observeSingleEvent(of: .value) { (dataSnapshot) in
                
                guard let dataSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else { return }
                for blData in dataSnapshot {
                    let uid = blData.childSnapshot(forPath: "userId").value as! String
                    if uid == id {
                        bluetoothUidToDelete = blData.key
                    }
                }
                myGroup.leave()
            }
        }
        myGroup.notify(queue: .main) {
            if let blId = bluetoothUidToDelete {
                self.REF_BLUETOOTH.child(blId).removeValue()
            }
        }
        
        let anotherGroup = DispatchGroup()
        anotherGroup.enter()
        DispatchQueue.main.async {
            self.REF_QUIZES.observeSingleEvent(of: .value) { (dataSnapshot) in
                guard let dataSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else { return }
                for quiz in dataSnapshot {
                    let uid = quiz.childSnapshot(forPath: "userId").value as! String
                    if uid == id {
                        quizUidToDelete = quiz.key
                    }
                }
                anotherGroup.leave()
            }
        }
        
        anotherGroup.notify(queue: .main) {
            if let quizId = quizUidToDelete {
                self.REF_QUIZES.child(quizId).removeValue()
                completionHandler(true)
            } else {
                completionHandler(false)
            }
            
        }
        
    }
}
