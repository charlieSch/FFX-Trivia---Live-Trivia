//
//  PlaceHolder.swift
//  FFXTrivia-LiveTrivia
//
//  Created by Charlie Schmidt on 7/22/22.
//

import SwiftUI
//just easier to use for multiple times
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
