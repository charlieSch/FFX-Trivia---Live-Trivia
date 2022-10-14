//
//  WeeklyChallenge.swift
//  FFX Trivia
//
//  Created by Charlie Schmidt on 7/12/22.
//

import SwiftUI

//code for the non live "weekly challenge" (doesnt have ot be weekly) 

struct WeeklyChallenge: View {
    
    //@Binding var totalPoints : Int
    //for now just do total correct
    @Binding var correct: Int
    
    @StateObject var data = QuestionViewModel()
    @Binding var answered: Int
    var set: String
    var timer = CircleTimer()
    
    var body: some View {
        
        ZStack() {
            if(data.questions.isEmpty) {
                ProgressView()
            }
            else {
                if(answered == data.questions.count) {
                    
                    ZStack{
                        
                        Color(red: 1.0, green: 0.992, blue: 0.9)
                            .edgesIgnoringSafeArea(.all)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        VStack(spacing: 25) {
                            Title()
                            
                            Text("Well Done!")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(.accentColor)
                            
                            Text("Total Points: \(correct)")
                                .font(.largeTitle)
                                .foregroundColor(.accentColor)
                            
                            NavigationLink {
                                AppView()
                                    .navigationBarHidden(true)
                            } label: {
                                Button2(text: "Go home")
                            }
                            
                        }
                    }
                    
                } else {
                    
                    VStack(spacing: 0){
                        
                        HStack(){
                            
                            Title()
                                .position(x: 60, y: 50)
                                .frame(width: 200, height: 100)
                            
                            //Text("Points: \(totalPoints)")
                            Text("Points: \(correct)")
                                .fontWeight(.bold)
                            
                                .font(.subheadline)
                                .foregroundColor(.accentColor)
                                .position(x: 75, y: 50)
                                .frame(width: 110, height: 100)
                        }
                        
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                            
                            Capsule()
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: 6)
                            
                            Capsule()
                                .fill(Color.accentColor)
                                .frame(width: progress(), height: 6)
                        }
                        .padding()
                        
                        ZStack {
                            
                            ForEach(data.questions.reversed().indices, id: \.self) {index in
                                
                                WeeklyChallengeQuestionView(question: $data.questions[index], correct: $correct, answered: $answered)
                                
                                    .offset(x: data.questions[index].completed ? 1000 : 0)
                                    .rotationEffect(.init(degrees: data.questions[index].completed ? 10 : 0))
                            }
                            
                            
                        }
                        .padding()
                    }
                    .background(Color(red: 1.0, green: 0.992, blue: 0.9))
                }
            }
        }
        .onAppear(perform: {
            data.getQuestions(set: set)
        })
    }
    
    func progress() -> CGFloat{
        
        let fraction = CGFloat(answered) / CGFloat(data.questions.count)
        
        let width = UIScreen.main.bounds.width - 30
        
        return fraction * width
    }
}

