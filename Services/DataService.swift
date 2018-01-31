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
    
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
}
