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
    let id:String
    let name:String
    let quizzes:[Quiz]
    init(id:String,  name:String,  quizzes:[Quiz]) {
        self.id = id
        self.name = name
        self.quizzes = quizzes
    }
    init(data:NSDictionary) {
        id = data["id"] as! String
        name = data["name"] as! String
        quizzes = (data["quizzes"] as! [NSDictionary]).map({ quiz in
            Quiz(data: quiz)
        })
    }
    func convertToDictionary()->NSDictionary{
        return ["id":id, "name":name, "quizzes":quizzes.map({ quiz in
            quiz.convertToDictionary()
        })]
    }
}
