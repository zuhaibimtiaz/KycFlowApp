//
//  CountrySelectionViewScreen.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import SwiftUI

/// A SwiftUI screen to let the user select their country of residence.
/// Displays a globe icon, a picker for country selection, a language switcher, and a "Next" button.
/// Uses MVVM Clean architecture with dependency-injected ViewModel.
struct CountrySelectionViewScreen<ViewModel: CountrySelectionViewModelProtocol>: View {
    // Environment Router for navigation
    @Environment(Router.self) private var router
    
    @State private var viewModel: ViewModel

    // Initializer with ViewModel injection
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: UIConstants.spacing.large) {
                // Header with icon and title
                CountrySelectionHeaderView()
                // Country selection dropdown
                
                CountryPickerView(
                    label: CountrySelectionViewScreenConstant.selectorFieldPlaceHolder.localized,
                    selectedCountry: $viewModel.selectedCountry,
                    availableCountries: viewModel.availableCountries,
                    displayName: { $0.name }
                )
                
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                LanguageSelectionMenu()
                    .equatable()
            }
        }
        .safeAreaInset(edge: .bottom) {
            // Bottom "Next" button
            ButtonView(
                title: ButtonConstants.next.localized,
                icon: "arrow.right",
                isLoading: viewModel.state == .loading,
                isDisable: viewModel.state == .loading,
                action: loadForm
            )
            .padding(.horizontal, UIConstants.padding.large)
        }
        .onChange(of: viewModel.state) { _, newState in
            // Show error alert if viewModel.errorMessage changes
            switch newState {
            case .failed(let error):
                router.navigate(to: .alert(.init(message: error)))
                
            default:
                break
            }
        }
        .navigationTitle(Text(CountrySelectionViewScreenConstant.navTitle.localized))
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Private Helpers

private extension CountrySelectionViewScreen {

    /// Load the form fields based on the selected country.
    /// Navigates to form screen if successful, otherwise triggers error alert.
    func loadForm() {
        Task {
            await viewModel.loadForm()

            if viewModel.state == .loaded {
                router.navigate(to: .push(.formView(fields: viewModel.fields)))
            }
        }
    }
}
