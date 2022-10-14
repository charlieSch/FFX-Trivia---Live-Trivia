//
//  LoginView.swift
//  FFXTrivia-LiveTrivia
//
//  Created by Charlie Schmidt on 7/22/22.
//

import SwiftUI
import Firebase

//more UI code and functions to log users in

struct LoginView: View {
    
    @State private var loginError = ""
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    
    var body: some View {
       
        if(userIsLoggedIn){
            AppView()
        } else{
            LoginView
        }
    }
    
    
    var LoginView: some View {
        
        ZStack {
            
            (Color(red: 1.0, green: 0.992, blue: 0.9)
                .ignoresSafeArea())
            
            VStack(spacing: 20){
                
                    VStack(){
                        
        
                    Title()
                        
                    LiveTrivia()
                
                    Image("FairfaxCountySeal")
                    .resizable()
                    .frame(width: 164, height: 164)

                }
                Text("Login")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .offset(x: -140, y: 20)
                
                TextField("", text: $email)
                    .foregroundColor(.accentColor)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("Email")
                            .foregroundColor(.accentColor)
                            .bold()
                    }
                    .offset(y: 47)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.accentColor)
                    .offset(y: 32)
                
                PasswordField(text: $password)
                    .foregroundColor(.accentColor)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) {
                        Text("Password")
                            .foregroundColor(.accentColor)
                            .bold()
                    }
                    .offset(y: 47)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.accentColor)
                    .offset(y: 32)
                
                Button {
                    login()
                } label: {
                    Text("Login")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background{
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors : [.accentColor], startPoint: .top, endPoint: .bottomTrailing))
                        }
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y: 40)

                
                Text(loginError)
                    .offset(y: 50)
                    .font(.caption2)

            }
            .frame(width: 350)
            .onAppear{
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil{
                        userIsLoggedIn.toggle()
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
    
    private func login(){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                self.loginError = "Failed to login: \(error)"
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
