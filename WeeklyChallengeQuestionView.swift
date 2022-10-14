//
//  WeeklyChallengeQuestionView.swift
//  FFXTrivia
//
//  Created by Charlie Schmidt on 8/8/22.
//

import SwiftUI

//the code that runs the weeklychallenge and "plays the game"

struct WeeklyChallengeQuestionView: View {
    
    @Binding var question: Question
    @Binding var correct: Int
    @Binding var answered: Int
    
    @State var isSelected = ""
    @State var final = false
    @State var wrong = false
    
    @StateObject var setter = Username()
    
    var body: some View {
        
        VStack(spacing: 22) {
            
            Text(question.question!)
                .font(.title3)
                .fontWeight(.heavy)
                .foregroundColor(.accentColor)
                .padding(.top, 25)
            
            Spacer(minLength: 0)
            
            Button {
                
                if(final){
                    print("")
                } else {
                    isSelected = question.optionA!
                    checkAns()
                }
                
            } label: {
                Box(text: question.optionA!)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(color(question.optionA!), lineWidth: 2)
                    )
            }
            
            
            
            Button {
                if(final){
                    print("")
                } else {
                    isSelected = question.optionB!
                    checkAns()
                }
            } label: {
                Box(text: question.optionB!)                    .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(color(question.optionB!), lineWidth: 2)
                )
            }
            
            
            Button {
                if(final){
                    print("")
                } else {
                    isSelected = question.optionC!
                    checkAns()
                }
                
            } label: {
                Box(text: question.optionC!)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(color(question.optionC!), lineWidth: 2)
                    )
            }
            
            
            
            Button {
                if(final){
                    print("")
                } else {
                    isSelected = question.optionD!
                    checkAns()
                }
                
            } label: {
                Box(text: question.optionD!)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(color(question.optionD!), lineWidth: 2)
                    )
            }
            
            Spacer(minLength: 0)
            
            Button {
                
                withAnimation{question.completed.toggle()}
                final.toggle()
                answered += 1
                
                if(answered == 15) {
                    setter.playedWeeklyChallenge()
                    setter.setWeeklyChallScore(correct)
                }
                
            } label: {
                Text("Next Question")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(15)
            }
            .disabled(!question.isSubmitted ? true : false)
            .opacity(!question.isSubmitted ? 0.7 : 1)
            .padding(.bottom, 15)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: Color.accentColor.opacity(0.05), radius: 5, x: 5, y: 5)
        .shadow(color: Color.accentColor.opacity(0.05), radius: 5, x: -5, y: -5)
    }
    
    func color(_ option: String) -> Color{
        
        if(option == isSelected){
            
            if(isSelected == question.answer!) {
                
                return Color.green
                
            } else {
                
                return Color.red
                
            }
            
        } else {
            
            if(wrong && final) {
                
                if(option == question.answer!) {
                    
                    return Color.green
                    
                }
                
            }
            
            return Color.accentColor
        }
    }
    
    func checkAns(){
        
        if isSelected == question.answer! {
            
            correct += 1
            
        } else {
            
            correct += 0
            wrong = true
            
        }
        question.isSubmitted.toggle()
        final = true
        
    }
    
    struct Box : View {
        
        var text: String
        
        var body: some View {
            Text(text)
                .foregroundColor(.accentColor)
                .padding(.vertical)
                .frame(maxWidth: .infinity)
        }
    }
    
}
