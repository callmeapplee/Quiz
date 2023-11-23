//
//  User.swift
//  Quiz
//
//  Created by Ботурбек Имомдодов on 22/11/23.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
struct User {
    let name:String
    let ref:DatabaseReference?
    let quizzes:[Quiz]
    init(name: String, ref: DatabaseReference?, quizzes: [Quiz]) {
        self.name = name
        self.ref = nil
        self.quizzes = quizzes
    }
    
    init(data:NSDictionary) {
        name = data["name"] as! String
        quizzes = (data["quizzes"] as! [NSDictionary]).map({ quiz in
            Quiz(data: quiz)
        })
        self.ref = nil
    }
    func convertToDictionary()->NSDictionary{
        return ["name":name, "quizzes":quizzes.map({ quiz in
            quiz.convertToDictionary()
        })]
    }
}
