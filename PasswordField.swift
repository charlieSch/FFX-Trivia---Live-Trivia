//
//  PasswordField.swift
//  FFXTrivia
//
//  Created by Charlie Schmidt on 7/28/22.
//

import SwiftUI
//just easier to use for multiple times
struct PasswordField: View {
    
    @State private var isSecureField: Bool = true
    
    @Binding var text: String
    
    var body: some View {
        HStack {
            if isSecureField {
                SecureField("", text: $text)
            } else {
                TextField(text, text: $text)
            }
        }.overlay(alignment: .trailing) {
            Image(systemName: isSecureField ? "eye.slash.fill": "eye.fill")
                .offset(x: -5)
                .onTapGesture {
                    isSecureField.toggle()
                }
        }
    }
}

