//
//  CountrySelectionHeaderView.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import SwiftUI

/// A reusable view that displays a globe icon, a title, and a subtitle.
/// Used as the top section of the Country Selection screen.
struct CountrySelectionHeaderView: View {
    /// we can add properties here if needed in the future
    var body: some View {
        VStack(spacing: UIConstants.Spacing.small) {
            // Animated Globe Icon
            Image(systemName: "globe.europe.africa.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundStyle(.blue.gradient)
                .symbolEffect(.pulse)
                .padding(.vertical, UIConstants.Padding.mediumLarge)

            // Title
            Text(CountrySelectionViewScreenConstant.title.localized)
                .titleStyle()

            // SubTitle
            Text(CountrySelectionViewScreenConstant.subTitle.localized)
                .subTitleStyle()
        }
        .padding(.top, UIConstants.Padding.large)
    }
}
