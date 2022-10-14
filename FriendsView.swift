//
//  Friends.swift
//  FFX Trivia
//
//  Created by Charlie Schmidt on 7/13/22.
//

import SwiftUI

//ui for the friends page
//don't know how to search up other accounts yet

struct FriendsView: View {
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color(red: 1.0, green: 0.992, blue: 0.9)
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack(spacing: 10){
                    Text("Friends")
                        .foregroundColor(.accentColor)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                    SearchBar()
                        .padding(.top)
                    Spacer()
                    
                    Button {
                        //link to trivia in app store once uploaded
                    } label: {
                        InviteFriends()
                            .padding(.bottom)
                    }
                    Divider()
                        .offset(y: 5)
                    NavigateBar(bolded: 1)
                }
            }
        }
    }
    
    
    struct Friends_Previews: PreviewProvider {
        static var previews: some View {
            FriendsView()
        }
    }
    
    struct Friend: View {
        var name : String
        // var color : UIColor
        var body: some View {
            ZStack(){
                Rectangle()
                    .frame(width: 325, height: 60)
                    .foregroundColor(.purple
                    )
                //need to learn this .foregroundColor(color)
                    .cornerRadius(15)
                HStack(){
                    Spacer()
                    Image(systemName: "person.circle")
                    Text("John Doe")
                    Spacer()
                }
            }
        }
    }
}

    struct SearchBar: View {
        @State var search: String = ""
        var body: some View {
            TextField("Search For Friends", text: $search)
                .padding(.all)
                .background(.white)
                .cornerRadius(30)
                .shadow(radius: 7)
                .foregroundColor(.accentColor)
                .padding(.horizontal)
                .frame(width: 400, height: 50)
        }
    }
    
    struct InviteFriends: View {
        var body: some View {
            
            ZStack(){
                Rectangle()
                    .shadow(radius: 20)
                    .frame(width: 225, height: 45)
                    .foregroundColor(.accentColor)
                    .edgesIgnoringSafeArea(.bottom)
                    .cornerRadius(15)
                //eventually learn how to make ths button share link to app store of app
                //w friends
                HStack(){
                    Image(systemName: "link")
                       
                    Text("Invite more Friends!")
                }
                .foregroundColor(.white)
            }
        }
    }
