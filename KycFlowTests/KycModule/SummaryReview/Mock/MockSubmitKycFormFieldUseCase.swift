//
//  MockSubmitKycFormFieldUseCase.swift
//  TestKYCApp
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Testing
@testable import KycFlow

// Mock dependencies
struct MockSubmitKycFormFieldUseCase: SubmitKycFormFieldUseCaseProtocol {
    
    let result: Result<Void, Error>
    
    func submitForm(fields: [FieldModel]) async throws {
        switch result {
        case .success:
            try await Task.sleep(for: .seconds(1)) // Reduced sleep time for faster tests
        case .failure(let error):
            throw error
        }
    }
}
