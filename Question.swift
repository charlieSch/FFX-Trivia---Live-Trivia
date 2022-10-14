//
//  Question.swift
//  FFXTrivia
//
//  Created by Charlie Schmidt on 8/8/22.
//

import SwiftUI
import FirebaseFirestore
import Foundation
import FirebaseFirestoreSwift

//model to store the questions from the databse

struct Question: Identifiable, Codable {
    
    @DocumentID var id: String?
    var question: String?
    var optionA: String?
    var optionB: String?
    var optionC: String?
    var optionD: String?
    var answer: String?
    
    var isSubmitted = false
    var completed = false
    
    enum CodingKeys: String, CodingKey {
        case question = "Question"
        case optionA = "a"
        case optionB = "b"
        case optionC = "c"
        case optionD = "d"
        case answer
    }
    
}
