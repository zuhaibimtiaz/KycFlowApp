//
//  PrimaryButton.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    var color: Color = Color.blue
    var pressedColor: Color = Color.blue.opacity(0.8)
    var isLoading: Bool = false
    var isDisable: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background((isLoading || isDisable) ? Color.gray : (configuration.isPressed ? pressedColor : color))
            .foregroundStyle(Color.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.02 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .overlay(alignment: .trailing, content: {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                        .scaleEffect(1.1)
                        .padding(.trailing, 10)
                }
            })
    }
}
