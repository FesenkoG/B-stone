//
//  AuthService.swift
//  В-stone
//
//  Created by Георгий Фесенко on 30.01.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(email: String, password: String, username: String,  handler: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                handler(false, error)
                return
            }
            let userData = ["provider": user.providerID, "email": user.email!, "username": username]
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            handler(true, error)
        }
    }
    
    func loginUser(email: String, password: String, handler: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                handler(false, error)
                return
            }
            
            handler(true, error)
        }
        
    }
}
