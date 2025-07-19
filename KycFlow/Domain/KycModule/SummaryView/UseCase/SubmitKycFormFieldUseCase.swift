//
//  FetchKycConfigUseCaseProtocol.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

protocol SubmitKycFormFieldUseCaseProtocol {
    func submitForm(fields: [FieldModel]) async throws
}

struct SubmitKycFormFieldUseCase: SubmitKycFormFieldUseCaseProtocol {

    func submitForm(fields: [FieldModel]) async throws {
        try await Task.sleep(for: .seconds(2))
    }
}
