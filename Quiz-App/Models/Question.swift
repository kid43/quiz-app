//
//  Question.swift
//  Quiz-App
//
//  Created by Phong Le on 14/04/2021.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Question: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var question: String
    var a: String
    var b: String
    var c: String
    var answer: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case question
        case a
        case b
        case c
        case answer
    }
}
