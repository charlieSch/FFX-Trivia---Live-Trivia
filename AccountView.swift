//
//  AccountView.swift
//  FFX Trivia
//
//  Created by Charlie Schmidt on 7/13/22.
//

import SwiftUI
import Firebase

//fetches the accounts email (which is then turned into username by removing @domain) and the account's stats
//and also more ui for the page

struct AccountUser {
    let uid, email: String
    let gp, gw, hs, weeklyChallScore: Int
    let playedWeeklyChall: Bool
}

class SignOut: ObservableObject {
    
    @Published var isUserCurrentlyLoggedOut = false
    
    init() {
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut = Auth.auth().currentUser?.uid == nil
        }
    }
    
    func handleSignOut() {
        isUserCurrentlyLoggedOut.toggle()
        try? Auth.auth().signOut()
    }
    
}

class Username: ObservableObject {
    
    @Published var accountUser: AccountUser?
    
    init() {
        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("Could not find firebase uid")
            return
        }
        
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Failed to fetch current user: \(error)")
                return
            }
            
            guard let data = snapshot?.data() else {
                print("No data found")
                return
                
            }
            
            let uid = data["uid"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let gp = data["gp"] as? Int ?? 0
            let gw = data["gw"] as? Int ?? 0
            let hs = data["hs"] as? Int ?? 0
            let weeklyChallScore = data["weeklyChallScore"] as? Int ?? 0
            let playedWeeklyChall = data["playedWeeklyChall"] as? Bool ?? true
            
            self.accountUser = AccountUser(uid: uid, email: email, gp: gp, gw: gw, hs: hs, weeklyChallScore: weeklyChallScore, playedWeeklyChall: playedWeeklyChall)
        }
    }
    
    func playedWeeklyChallenge() {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("Could not find firebase uid")
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).setData(["playedWeeklyChall" : true], merge: true)
    }
    
    func setWeeklyChallScore(_ score: Int) {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("Could not find firebase uid")
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).setData(["weeklyChallScore" : score], merge: true)
    }
    
    func gameWon() {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("Could not find firebase uid")
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Failed to fetch current user: \(error)")
                return
            }
            
            guard let data = snapshot?.data() else {
                print("No data found")
                return
                
            }
            
            var gw = data["gw"] as? Int ?? 0
            
            let db = Firestore.firestore()
            
            db.collection("users").document(uid).setData(["gw": gw += 1], merge: true)
        }
    }
    
    func gamePlayed() {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("Could not find firebase uid")
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Failed to fetch current user: \(error)")
                return
            }
            
            guard let data = snapshot?.data() else {
                print("No data found")
                return
                
            }
            
            var gp = data["gp"] as? Int ?? 0
            
            let db = Firestore.firestore()
            
            db.collection("users").document(uid).setData(["gp": gp += 1], merge: true)
        }
    }
    
    func checkAndUpdateHS(_ newHighScore: Int) {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("Could not find firebase uid")
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Failed to fetch current user: \(error)")
                return
            }
            
            guard let data = snapshot?.data() else {
                print("No data found")
                return
                
            }
            
            let hs = data["hs"] as? Int ?? 0
            
            let db = Firestore.firestore()
            
            if(newHighScore > hs){
                db.collection("users").document(uid).setData(["hs": hs], merge: true)
            }
        }
    }
}
    
    struct AccountView: View {
        
        @ObservedObject private var signOut = SignOut() //signout class
        @ObservedObject private var vm = Username() //display email username and stats
        
        var body: some View {
            
            NavigationView{
                
                ZStack {
                    Color(red: 1.0, green: 0.992, blue: 0.9)
                        .edgesIgnoringSafeArea(.all)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    VStack(spacing: 5){
                        
                        Text("Account")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color("AccentColor"))
                            .padding(.bottom, 40.0)
                        
                        let email = vm.accountUser?.email ?? ""
                        let user = removeAtSign(email)
                        
                        Text(user)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.accentColor)
                            .padding(.vertical, 45.0)
                        
                        HStack(spacing: 25) {
                            //go thru only one acc's document
                            VStack {
                                Text("Games Played")
                                let gp = String(vm.accountUser?.gp ?? 0)
                                Text(gp)
                            }
                            VStack {
                                Text("Games Won")
                                let gw = String(vm.accountUser?.gw ?? 0)
                                Text(gw)
                            }
                            
                            VStack {
                                Text("High Score")
                                let hs = String(vm.accountUser?.hs ?? 0)
                                Text(hs)
                            }
                            
                        }
                        .foregroundColor(.accentColor)
                        .padding(.vertical)
                        
                        Spacer()
                        NavigationLink {
                            PrizesView()
                        } label: {
                            Text("Redeem Prizes")
                                .underline()
                        }
                        
                        Spacer()
                        
                        Button {
                            signOut.handleSignOut()
                        } label: {
                            Button2(text: "Logout")
                        }
                        .fullScreenCover(isPresented: $signOut.isUserCurrentlyLoggedOut, onDismiss: nil) {
                            SignUpView()
                        }
                        .padding(.bottom, 10)
                        
                        Divider()
                        NavigateBar(bolded: 3)
                    }
                }
            }
        }
    
        func removeAtSign(_ em: String) -> String {
            guard let index = em.firstIndex(of: "@") else { return em }
            let u = String(em[..<index])
            return u
        }
        
    }
    
    struct AccountView_Previews: PreviewProvider {
        static var previews: some View {
            AccountView()
        }
    }

