//
//  MockProfileUseCase.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Testing
@testable import KycFlow

struct MockProfileUseCase: FetchProfileUseCaseProtocol {
    
    let result: Result<ProfileModel, Error>
    
    func fetch(country: CountryModel) async throws -> ProfileModel {
        switch result {
        case .success(let model):
            return model
        case .failure(let error):
            throw error
        }
    }
}
