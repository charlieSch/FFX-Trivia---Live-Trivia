//
//  App View.swift
//  FFX Trivia
//
//  Created by Charlie Schmidt on 7/12/22.
//

import SwiftUI

//home page UI

struct AppView: View {
    
    //@State var totalPoints = 0
    @State var correct = 0
    @State var answered = 0
    @State var set = "WeeklyChallenge"
    
    var body: some View {
        
        NavigationView {
            
            ZStack{
                
                Color(red: 1.0, green: 0.992, blue: 0.9)
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack(){
                    
                    Title()
                    
                    Spacer()
                    
                    Text("Weekly Challenge")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(Color("AccentColor"))
                        .padding(.bottom)
                    
                    NavigationLink{
                        WeeklyChallenge(correct: $correct, answered: $answered, set: set)
                            .navigationBarHidden(true)
                    } label:{
                        Button2(text: "Start")
                    }
                    
                    Spacer()
                    
                    ZStack(){
                        BlackRectangle()
                        VStack(){
                            Group{
                                LiveTrivia()
                                    .accentColor(.white)

                                
                                Reward(text: "$15 local gift card")
                                    .foregroundColor(.white)
                                
                                HStack(){
                                    Spacer()
                                    
                                    Button {
                                        
                                        //link to trivia in app store once actually uploaded to app store
                                    } label: {
                                        Button2(text: "Share")
                                            .padding(.top)
                                    }
                                    
                                    Spacer()
                                    
                                    PlayTime()
                                    
                                    Spacer()
                                }
                            }
                            .foregroundColor(.white)
                        }
                        
                    }
                    
                    Spacer()
                    
                    Divider()
                    NavigateBar(bolded: 2)
                }
            }
        }
    }
}

struct App_View_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

struct BlackRectangle: View {
    var body: some View {
        Rectangle()
            .frame(width: 350, height: 250)
            .cornerRadius(20)
            .shadow(radius: 10)
            .foregroundColor(Color.accentColor)
    }
}

struct Reward: View{
    var text: String
    var body: some View{
        Text(text)
            .font(.title2)
            .fontWeight(.semibold)
            .padding(.bottom, 1.0)
            .padding(.top, 1.0)
        
    }
}

struct PlayTime: View {
    var body: some View{
        Text("Fridays @ 6pm")
            .font(.title2)
            .padding(.top)
    }
}
