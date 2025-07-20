//
//  LanguageSelectionMenu.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import SwiftUI

/// A reusable menu to switch between supported app languages.
/// Dynamically loops through a list of `LanguageOption` items.
struct LanguageSelectionMenu: View, Equatable {
    static func == (lhs: LanguageSelectionMenu, rhs: LanguageSelectionMenu) -> Bool {
        lhs.languageOptions == rhs.languageOptions
    }
    
    @AppStorage(AppStorageKeys.selectedLanguage.rawValue)
    private var selectedLanguage: String = "en"

    /// All supported languages
    /// we can get the language options from lanugage Manager
    private let languageOptions: [LanguageOption] = [
        LanguageOption(code: "en", label: "English"),
        LanguageOption(code: "de", label: "Deutsch")
        // You can add more languages here
    ]

    var body: some View {
        Menu {
            ForEach(languageOptions) { option in
                Button(action: {
                    selectedLanguage = option.code
                }) {
                    HStack {
                        Text(option.label)
                        if selectedLanguage == option.code {
                            Spacer()
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            Image(systemName: "globe")
        }
    }
}
