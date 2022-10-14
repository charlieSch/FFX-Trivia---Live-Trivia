//
//  PrizesView.swift
//  FFX Trivia
//
//  Created by Charlie Schmidt on 7/13/22.
//

import SwiftUI

//never created a ui for the prizes view

struct PrizesView: View {
    var body: some View {
        VStack(){
            Text("Prizes")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color("AccentColor"))
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color(red: 1.0, green: 0.992, blue: 0.9))
    }
}

struct PrizesView_Previews: PreviewProvider {
    static var previews: some View {
        PrizesView()
    }
}
