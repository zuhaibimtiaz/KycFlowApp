//
//  SummaryReviewViewModel.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Foundation

/// ViewModel responsible for managing the summary review screen logic,
/// including submission of the filled form fields.
@Observable
final class SummaryReviewViewModel: SummaryReviewViewModelProtocol {
    
    /// Use case responsible for submitting the form fields.
    private var useCase: SubmitKycFormFieldUseCaseProtocol
    
    /// Tracks the current asynchronous state (idle, loading, loaded, failed).
    var state: AsyncState = .idle
    
    /// The form fields that the user has reviewed and will submit.
    var fields: [FieldModel]

    /// Initializes the ViewModel with initial form fields and a submit use case.
    /// - Parameters:
    ///   - fields: The initial form fields to submit.
    ///   - useCase: The use case responsible for submitting the form (default provided).
    init(fields: [FieldModel],
         useCase: SubmitKycFormFieldUseCaseProtocol = SubmitKycFormFieldUseCase()) {
        self.fields = fields
        self.useCase = useCase
    }

    /// Asynchronously submits the form fields using the use case.
    /// Updates the `state` property to reflect the submission status.
    func submit() async {
        do {
            self.state = .loading
            try await useCase.submitForm(fields: fields)
            self.state = .loaded
        } catch let error as AppError {
            self.state = .failed(error.description)
        } catch {
            self.state = .failed(error.localizedDescription)
        }
    }
}
