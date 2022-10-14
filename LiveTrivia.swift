//
//  LiveTrivia.swift
//  FFX Trivia
//
//  Created by Charlie Schmidt on 7/18/22.
//

import SwiftUI
//just easier to use for multiple times

struct LiveTrivia : View {
    let text = "Live Trivia"
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.accentColor)
    }
}
