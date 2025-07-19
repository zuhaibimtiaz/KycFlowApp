//
//  TitleLabelStyle.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import SwiftUI

// MARK: - Title Label Style
struct TitleLabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.primary)
            .font(.largeTitle.bold())
            .multilineTextAlignment(.center)
            .lineLimit(2)
    }
}
