//
//  FirestoreService.swift
//  Quiz
//
//  Created by Ботурбек Имомдодов on 22/11/23.
//

import Foundation
import FirebaseFirestore

final class FirestoreService{
    private init(){}
    static let shared = FirestoreService()
    var usersRef = Firestore.firestore().collection("quiz").document("users")
    func getUsers(completion: @escaping ([User]) -> Void) {
        usersRef.getDocument { snapshot, error in
            guard let data = snapshot?.data() else {
                return;
            }
            let usersDict = data.filter({ user in
                return user.key != AuthService.shared.currentUser.uid
            })
            let users = usersDict.map { user in
                User(data: user.value as! NSDictionary)
            }
            completion(users)
        }
    }
    func setUser(user:User) {
        usersRef.updateData([user.id : user.convertToDictionary()])
    }
    
    
}
