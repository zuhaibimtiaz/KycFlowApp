//
//  DynamicFormViewModel.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 18/07/2025.
//

import Foundation

/// ViewModel responsible for handling a dynamic form's state and validation logic.
@Observable
final class DynamicFormViewModel: DynamicFormViewModelProtocol
{
    /// Holds the list of dynamic form fields to be displayed and validated.
    var fields: [FieldModel]

    private let validationService: ValidationServiceProtocol
    /// Initializes the view model with an optional list of form fields.
    /// - Parameter fields: The initial fields for the form (defaults to empty).
    init(fields: [FieldModel] = [],
         validationService: ValidationServiceProtocol = ValidationService()) {
        self.fields = fields
        self.validationService = validationService
    }
    
    /// Validates all form fields.
    ///
    /// - Returns: `true` if all required fields are filled and have no validation error,
    ///            `false` otherwise.
    ///
    /// A field is considered valid if:
    /// - It's **not required**, or
    /// - It's **required**, and has **no error message**, and the **value is not empty**.
    func checkFieldsValidation() -> Bool {
        self.fields = self.validationService.validateFields(fields)
        return fields.allSatisfy { $0.errorMessage == nil }
    }
}
