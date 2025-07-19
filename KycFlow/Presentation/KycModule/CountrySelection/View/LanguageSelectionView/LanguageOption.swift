//
//  LanguageOption.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Foundation

/// Represents a supported language with a code and display name.
struct LanguageOption: Identifiable, Hashable {
    let id = UUID()
    let code: String       // e.g., "en", "de"
    let label: String      // e.g., "English", "Deutsch"
}
