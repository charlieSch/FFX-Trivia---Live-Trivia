//
//  QuestionViewModel.swift
//  FFXTrivia
//
//  Created by Charlie Schmidt on 8/8/22.
//
import Foundation
import Firebase
import SwiftUI

//get the questions from databsae

class QuestionViewModel: ObservableObject {
    
    @Published var questions : [Question] = []
    
    func getQuestions(set: String) {
        
        let db = Firestore.firestore()
        
        db.collection("WeeklyChallenge").getDocuments { (snap, err) in
            
            guard let data = snap else { return }
            
            DispatchQueue.main.async {
                
                self.questions = data.documents.compactMap({ (doc) -> Question? in
                    return try? doc.data(as: Question.self)
                })
            }
        }
    }
    
}
