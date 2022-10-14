//
//  ContentView.swift
//  FFXTrivia-LiveTrivia
//
//  Created by Charlie Schmidt on 7/21/22.
//

import SwiftUI
import Firebase

//just all UI stuff with code to also store new users info

struct SignUpView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    @State private var loginError = ""
    @State private var showPassword = false
    
    let startingUserStats = 0
    
    var body: some View {
        if(userIsLoggedIn){
            AppView()
        } else{
            CreateAccount
        }
    }
    
    var CreateAccount: some View {
        
        NavigationView {
            
            ZStack() {
                (Color(red: 1.0, green: 0.992, blue: 0.9)
                    .ignoresSafeArea())
                
                VStack(spacing: 20){
                    VStack(){
                        
                        Title()
                            .offset(y: -45)
                        
                        LiveTrivia()
                            .offset(y: -45)
                        
                        
                        Image("FairfaxCountySeal")
                            .resizable()
                            .frame(width: 164, height: 164)
                            .offset(y: -45)
                        
                    }
                    
                    Text("Create an Account")
                        .foregroundColor(.accentColor)
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .offset(x : -50, y: -25)
                    
                    TextField("", text: $email)
                        .foregroundColor(.accentColor)
                        .textFieldStyle(.plain)
                        .placeholder(when: email.isEmpty) {
                            Text("Email")
                                .foregroundColor(.accentColor)
                                .bold()
                        }
                        .offset(y: -5)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.accentColor)
                         .offset(y: -20)
                    
                    
                    PasswordField(text: $password)
                        .foregroundColor(.accentColor)
                        .textFieldStyle(.plain)
                        .placeholder(when: password.isEmpty) {
                            Text("Password")
                                .foregroundColor(.accentColor)
                                .bold()
                        }
                        .offset(y: -5)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.accentColor)
                        .offset(y: -20)
                    
                    Button {
                        register()
                    } label: {
                        Text("Sign up")
                            .bold()
                            .frame(width: 200, height: 40)
                            .background{
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.linearGradient(colors : [.accentColor], startPoint: .top, endPoint: .bottomTrailing))
                            }
                            .foregroundColor(.white)
                    }
                    
                    .padding(.top)
                    .offset(y: 5)
                    
                    NavigationLink {
                        LoginView()
                    } label: {
                        Text("Already have an account? Login here")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.accentColor)
                            .underline()
                    }
                    
                    .padding(.top, 1.0)
                    .offset(y: 5)
                    
                    Text(loginError)
                        .font(.caption2)
                        .offset(y: 5)
                    
                    
                }
                
                .frame(width: 350)
                .onAppear{
                    Auth.auth().addStateDidChangeListener { auth, user in
                        if user != nil{
                            userIsLoggedIn.toggle()
                        }
                    }
                }
                .ignoresSafeArea()
            }
        }
    }
    
    //function for making accounts
    
    private func register(){
        Auth.auth().createUser(withEmail: email, password: password) {result, error in
            if let error = error {
                print(error.localizedDescription)
                self.loginError = "Failed to login: \(error)"
            }
            self.storeUserInformation()
        }
    }
    
    private func storeUserInformation() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userData = ["email": self.email, "uid": uid, "gp": self.startingUserStats, "gw": self.startingUserStats, "hs": self.startingUserStats, "weeklyChallScore": self.startingUserStats, "playedWeeklyChall": false] as [String : Any]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    return
                }
                
                print("Success")
            }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
