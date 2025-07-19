//
//  SubTitleLabelStyle.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import SwiftUI
// MARK: - Subtitle Label Style
struct SubTitleLabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .lineLimit(3)
    }
}
