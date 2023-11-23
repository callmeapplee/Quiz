//
//  AuthService.swift
//  Quiz
//
//  Created by Ботурбек Имомдодов on 22/11/23.
//

import Foundation
import FirebaseAuth
final class AuthService {
    private init(){}
    static let shared = AuthService()
    var currentUser: FirebaseAuth.User {
        return Auth.auth().currentUser!
    }
    var isAuthorized:Bool {
        return Auth.auth().currentUser != nil
    }
    func createUser(withEmail email:String, password:String,  completion:@escaping(AuthDataResult?,Error?)->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            completion(user,error)
        }
    }
    func signIn(withEmail email:String, password:String,  completion:@escaping(AuthDataResult?,Error?)->Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            completion(user,error)
        }
    }
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
