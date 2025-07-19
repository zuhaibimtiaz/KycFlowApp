//
//  CountryPickerView.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import SwiftUI

/// A generic country picker that supports any identifiable country model.
/// Displays a wheel-style picker that scrolls to the selected country.
///
/// - Parameters:
///   - label: The field label shown above the picker.
///   - selectedCountry: The currently selected country (Binding).
///   - availableCountries: The full list of countries to choose from.
///   - displayName: A closure to extract a displayable name from the country model.
struct CountryPickerView<Country: Identifiable & Hashable>: View {
    let label: LocalizedStringResource
    @Binding var selectedCountry: Country
    let availableCountries: [Country]
    let displayName: (Country) -> String
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: UIConstants.spacing.small
        ) {
            // Field label
            Text(label)
                .font(.subheadline.bold())
                .foregroundStyle(.secondary)
            
            // Wheel-style Picker
            Picker(
                selection: $selectedCountry,
                label: Text(displayName(selectedCountry))
            ) {
                ForEach(availableCountries) { country in
                    Text(displayName(country))
                        .tag(country)
                }
            }
            .pickerStyle(.wheel)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: UIConstants.radius.small)
                    .strokeBorder(Color(.systemGray3), lineWidth: 1)
            )
            .clipped() // Ensure wheel stays within bounds
        }
        .padding(.horizontal)
    }
}
