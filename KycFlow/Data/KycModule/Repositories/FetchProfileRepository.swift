//
//  FetchProfileRepository.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Foundation

protocol FetchProfileRepositoryProtocol {
    func fetch(country: CountryModel) async throws -> ProfileModel
}

struct FetchProfileRepository: FetchProfileRepositoryProtocol {
    
    private var mapper: ProfileModelMapperProtocol
    
    init(mapper: ProfileModelMapperProtocol = ProfileModelMapper()) {
        self.mapper = mapper
    }
    
    func fetch(country: CountryModel) async throws -> ProfileModel {
        let dto = try await loadUserProfile(for: country)
        return self.mapper.mapToDomain(dto: dto)
    }
    
    private func loadUserProfile(for country: CountryModel) async throws -> ProfileDto {
        /// Simulate fetching profile data from /api/nl-user-profile endpoint for NL-specific behavior.
        /// In a production environment, this would make an HTTP request to /api/nl-user-profile to retrieve
        /// user profile data (e.g., first_name, last_name) for read-only fields when country is NL.
        /// Currently, it returns hardcoded mock data with a simulated network delay for demonstration.
        /// Simulate network delay
        try await Task.sleep(for: .seconds(1))
        return ProfileDto(
            fields: [
                .init(
                    id: "first_name",
                    value: "Zuhaib"
                ),
                .init(
                    id: "last_name",
                    value: "Imtiaz"
                ),
                .init(
                    id: "birth_date",
                    value: Date.now.ISO8601Format()
                ),
                .init(
                    id: "bsn",
                    value: "123456789"
                ),
            ]
        )
    }
}
