//
//  FetchKycConfigUseCase.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

protocol FetchKycConfigUseCaseProtocol {
    func fetch(country: CountryModel) async throws -> KycConfigModel
}

struct FetchKycConfigUseCase: FetchKycConfigUseCaseProtocol {
    private let repo: FetchKycConfigRepositoryProtocol

    init(repo: FetchKycConfigRepositoryProtocol = FetchKycConfigRepository()) {
        self.repo = repo
    }

    func fetch(country: CountryModel) async throws -> KycConfigModel {
        try await self.repo.fetch(country: country)
    }
}
