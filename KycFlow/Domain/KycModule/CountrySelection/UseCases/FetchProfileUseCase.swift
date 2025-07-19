//
//  FetchKycConfigUseCaseProtocol.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

protocol FetchProfileUseCaseProtocol {
    func fetch(country: CountryModel) async throws -> ProfileModel
}

struct FetchProfileUseCase: FetchProfileUseCaseProtocol {
    private let repo: FetchProfileRepositoryProtocol

    init(repo: FetchProfileRepositoryProtocol = FetchProfileRepository()) {
        self.repo = repo
    }

    func fetch(country: CountryModel) async throws -> ProfileModel {
        try await repo.fetch(country: country)
    }
}
