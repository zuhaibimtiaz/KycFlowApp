//
//  MockFetchKycConfigUseCase.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Testing
@testable import KycFlow

struct MockFetchKycConfigUseCase: FetchKycConfigUseCaseProtocol {
    
    let result: Result<KycConfigModel, Error>
    
    func fetch(country: CountryModel) async throws -> KycConfigModel {
        switch result {
        case .success(let model):
            return model
        case .failure(let error):
            throw error
        }
    }
}

