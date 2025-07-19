//
//  ButtonView.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import SwiftUI

public struct ButtonView: View {
    
    let title: LocalizedStringResource
    var icon: String? = nil
    var isLoading: Bool = false
    var isDisable: Bool = false
    var action: () -> Void
    
    @ViewBuilder
    var iconView: some View {
        if let icon {
            Image(systemName: icon)
        }
    }
    
    public var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.headline.bold())
                iconView
            }
        }
        .buttonStyle(
            PrimaryButtonStyle(
                isLoading: isLoading,
                isDisable: isDisable
            )
        )
        .disabled(isLoading)
    }
}
