//
//  CountrySelectionViewModel.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Foundation

/// ViewModel responsible for managing the state of the KYC country selection screen.
/// Handles loading of form configuration and optionally user profile data for remote configs.
@Observable
final class CountrySelectionViewModel: CountrySelectionViewModelProtocol {
    
    /// Represents the current async state of the ViewModel.
    var state: AsyncState = .idle

    /// The country currently selected by the user.
    var selectedCountry: CountryModel = CountryModel.defaultCountry()
    
    /// All available countries for selection.
    var availableCountries: [CountryModel] = CountryModel.all
    
    /// The form fields to be rendered in the UI.
    var fields: [FieldModel] = []
        
    /// Use case for fetching the form configuration (local or remote).
    private var fetchConfigUseCase: FetchKycConfigUseCaseProtocol
    
    /// Use case for fetching the user profile (used only if config source is remote).
    private let fetchProfileUseCase: FetchProfileUseCaseProtocol
    
    /// Initializes the ViewModel with optional dependencies for testability or mocking.
    init(
        fetchConfigUseCase: FetchKycConfigUseCaseProtocol = FetchKycConfigUseCase(),
        fetchProfileUseCase: FetchProfileUseCaseProtocol = FetchProfileUseCase()
    ) {
        self.fetchConfigUseCase = fetchConfigUseCase
        self.fetchProfileUseCase = fetchProfileUseCase
    }
    
    /// Loads the KYC form for the selected country.
    /// If the config source is `.remote`, it also fetches the user profile and merges values.
    func loadForm() async {
        do {
            self.state = .loading
            
            var config = try await fetchFormConfig()
            
            if config.source == .remote {
                config = try await mergeRemoteProfile(into: config)
            }
            
            self.applyForm(config)
            self.state = .loaded
        } catch let error as AppError {
            self.state = .failed(error.description)
        } catch {
            self.state = .failed(error.localizedDescription)
        }
    }
}

// MARK: - Private Helper Methods

private extension CountrySelectionViewModel {
    
    /// Fetches the form configuration for the selected country.
    private func fetchFormConfig() async throws -> KycConfigModel {
        try await fetchConfigUseCase.fetch(country: selectedCountry)
    }
    
    /// Merges user profile data into the form config if the config source is remote.
    /// Auto-fills values and marks them as read-only.
    private func mergeRemoteProfile(into config: KycConfigModel) async throws -> KycConfigModel {
        var updatedConfig = config
        let userProfile = try await fetchProfileUseCase.fetch(country: selectedCountry)

        // we can use high order function as well to find and update the field value
        let profileFieldMap = Dictionary(uniqueKeysWithValues: userProfile.fields.map { ($0.id, $0.value) })

        // Map through config fields and overwrite value & readonly flag if a profile match is found.
        updatedConfig.fields = updatedConfig.fields.map { field in
            var updatedField = field
            if let remoteValue = profileFieldMap[field.id] {
                updatedField.value = remoteValue
                updatedField.readOnly = true
            }
            return updatedField
        }

        return updatedConfig
    }

    /// Applies the given config to the `fields` property to be used by the UI.
    private func applyForm(_ config: KycConfigModel) {
        self.fields = config.fields
    }
}
