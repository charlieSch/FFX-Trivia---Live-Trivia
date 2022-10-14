//
//  Title.swift
//  FFX Trivia
//
//  Created by Charlie Schmidt on 7/18/22.
//

import SwiftUI

//just easier to use for multiple times

struct Title : View {
    let text = "FFXTrivia"
    var body: some View {
        Text(text)
            .foregroundColor(.accentColor)
            .font(.system(size: 40, weight: .bold, design: .rounded))
    }
}
