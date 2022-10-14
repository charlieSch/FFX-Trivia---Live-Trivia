//
//  FirebaseManager.swift
//  LBTASwiftUIFirebaseChat
//
//  Created by Brian Voong on 11/15/21.
//

import Foundation
import Firebase

//makes it easier to use Firebase instead of having to do Auth.auth() and Firebase.firebase() every time

class FirebaseManager: NSObject {
    
    let auth: Auth
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
    
}
