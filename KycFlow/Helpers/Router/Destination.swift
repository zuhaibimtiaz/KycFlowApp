//
//  Destination.swift
//
//  Created by Zuhaib Imtiaz on 09/07/2025.
//

import SwiftUI

// Enum representing different types of navigation destinations
enum Destination {
    case tab(TabDestination)            // Navigation to a tab
    case push(PushDestination)          // Navigation to a pushed view
    case sheet(HalfSheetDestination)    // Navigation to a half-sheet presentation
    case fullScreen(FullScreenDestination) // Navigation to a full-screen presentation
    case alert(AlertDestination)        // Presentation of an alert
}

// MARK: - AlertDestination Struct
// Struct representing an alert with a message and optional actions
struct AlertDestination: Identifiable {
    struct ButtonConfig: Identifiable {
        let id = UUID()
        let title: String          // Title of the button
        let action: (() -> Void)? // Optional action to perform when button is tapped
    }
    
    // Unique identifier for the alert
    let id = UUID().uuidString
    // The message to display in the alert
    let message: String
    // Optional primary ButtonConfig
    let primaryConfig: ButtonConfig?
    // Optional secondary ButtonConfig
    let secondaryConfig: ButtonConfig?
    
    init(
        message: String,
        primaryConfig: ButtonConfig? = nil,
        secondaryConfig: ButtonConfig? = nil
    ) {
        self.message = message
        self.primaryConfig = primaryConfig
        self.secondaryConfig = secondaryConfig
    }
}

// MARK: - TabDestination Enum
// Enum representing tab bar destinations
enum TabDestination: String, CaseIterable, Identifiable {
    case home = "Home"           // Home tab
    // Unique identifier for the tab, derived from the raw value
    var id: String { rawValue }
    
    // Computed property providing the label view for the tab
    @ViewBuilder
    var label: some View {
        EmptyView()
    }
    
    /// Provides the destination view for the tab
    /// - Returns: A SwiftUI view corresponding to the tab destination
    @MainActor
    @ViewBuilder
    var view: some View {
        EmptyView()
    }
}

// MARK: - PushDestination Enum
// Enum representing destinations for push navigation
enum PushDestination: Hashable, Identifiable {
    
    case formView(fields: [FieldModel])
    case summaryReview(fields: [FieldModel])
    // Unique identifier for the push destination
    var id: String {
        switch self {
        case .formView:
            "formView"
        case .summaryReview:
            "summaryReview"
        }
    }
    
    /// Provides the view for the push destination
    /// - Returns: A SwiftUI view corresponding to the push destination
    @MainActor
    @ViewBuilder
    var view: some View {
        switch self {
        case .formView(let fields):
            DynamicFormViewScreen(
                viewModel: DynamicFormViewModel(
                    fields: fields
                )
            )
        case .summaryReview(let fields):
            SummaryReviewScreen(viewModel: SummaryReviewViewModel(fields: fields)
            )
        }
    }
    
    static func == (lhs: PushDestination, rhs: PushDestination) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .formView:
            hasher.combine("formView")
        case .summaryReview:
            hasher.combine("summaryReview")
        }
    }
}

// MARK: - SheetDestination Enum
// Enum representing destinations for half-sheet presentation
enum HalfSheetDestination: Identifiable {
    case testSheet(id: String)  // Test sheet with an identifier
    
    // Unique identifier for the half-sheet destination
    var id: String {
        switch self {
        case .testSheet(let id):
            return "testSheet_\(id)"
        }
    }
    
    /// Provides the view for the half-sheet destination
    /// - Returns: A SwiftUI view corresponding to the half-sheet destination
    @MainActor
    @ViewBuilder
    var view: some View {
        switch self {
        case .testSheet:
            Text("Half Sheet")
        }
    }
}

// MARK: - FullScreenDestination Enum
// Enum representing destinations for full-screen presentation
enum FullScreenDestination: Identifiable {
    case testFullScreen(id: String)  // Test full-screen view with an identifier
    
    // Unique identifier for the full-screen destination
    var id: String {
        switch self {
        case .testFullScreen:
            return "testFullScreen_"
        }
    }
    
    /// Provides the view for the full-screen destination
    /// - Returns: A SwiftUI view corresponding to the full-screen destination
    @MainActor
    @ViewBuilder
    var view: some View {
        switch self {
        case .testFullScreen:
            Text("Full Screen")
        }
    }
}
