//
//  NavigateBar.swift
//  FFX Trivia
//
//  Created by Charlie Schmidt on 7/18/22.
//


import SwiftUI
struct NavigateBar: View {
    //just easier to use for multiple times
    
    var bolded = 2
    
    var body: some View {
        
        if(bolded == 2){
            HStack(){
                Spacer()
                
                NavigationLink{
                    FriendsView()
                        .navigationBarHidden(true)
                } label:{
                    Image(systemName: "person.3")
                        .font(.system(size: 15))
                }
                
                Spacer()
                
                Button {
                    print("")
                } label: {
                    FFXTriviaLogo()
                        .shadow(color: .accentColor, radius: 1)
                }
                
                Spacer()
                
                NavigationLink{
                    AccountView()
                        .navigationBarHidden(true)
                } label:{
                    Image(systemName: "gearshape")
                        .font(.system(size: 21))
                }
                
                Spacer()
            }
        }
        
        else if (bolded == 1){
            HStack(){
                Spacer()
                
                Button{
                    print("")
                } label:{
                    Image(systemName: "person.3.fill")
                        .font(.system(size: 15))
                }
                
                Spacer()
                
                NavigationLink {
                    AppView()
                        .navigationBarHidden(true)
                } label: {
                    FFXTriviaLogo()
                }
                
                Spacer()
                
                NavigationLink{
                    AccountView()
                        .navigationBarHidden(true)
                } label:{
                    Image(systemName: "gearshape")
                        .font(.system(size: 21))
                }
                
                Spacer()
            }
        }

        
        else {
            HStack(spacing: 15){
                Spacer()
                NavigationLink{
                    FriendsView()
                        .navigationBarHidden(true)
                } label:{
                    Image(systemName: "person.3")
                        .font(.system(size: 15))
                }
                
                Spacer()
                
                NavigationLink{
                    AppView()
                        .navigationBarHidden(true)
                } label:{
                    FFXTriviaLogo()
                }
                
                Spacer()
                
                Button {
                    print("")
                } label: {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 21))
                }
                
                Spacer()
                
            }
        }
    }
}

struct FFXTriviaLogo: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 45, height: 40)
                .foregroundColor(.accentColor)
            Text("FFX")
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
    }
}
