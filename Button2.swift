//
//  Button2.swift
//  auth0
//
//  Created by Charlie Schmidt on 7/20/22.
//

import SwiftUI
//just easier to use for multiple times
struct Button2: View {
    var text: String
    var background: Color = Color("AccentColor")
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .padding()
            .padding(.horizontal)
            .background(background)
            .cornerRadius(30)
            .shadow(radius: 10)
    }
}
