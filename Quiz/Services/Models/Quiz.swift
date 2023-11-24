//
//  Quiz.swift
//  Quiz
//
//  Created by Ботурбек Имомдодов on 22/11/23.
//

import Foundation
struct Quiz {
    let title:String
    init(title: String) {
        self.title = title
    }
    init(data:NSDictionary) {
        title = data["title"] as! String
    }
    func convertToDictionary()->NSDictionary{
        return ["title":title]
    }
}
