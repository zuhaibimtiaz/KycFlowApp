//
//  ValidationServiceProtocol.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Foundation

// MARK: - Validation Service Protocol
protocol ValidationServiceProtocol {
    func validateFields(
        _ fields: [FieldModel]
    ) -> [FieldModel]
}

// MARK: - Validation Service
struct ValidationService: ValidationServiceProtocol {
    func validateFields(
        _ fields: [FieldModel]
    ) -> [FieldModel] {
        var updatedFields = fields
        
        for i in 0..<updatedFields.count {
            // Reset error message (handled by the wrapper)
            // Force validation for all fields to ensure errors are shown
            guard updatedFields[i].required else { continue }
            updatedFields[i].triggerValidation()
            
            // The error message is automatically handled by the @Validate wrapper's projectedValue
            // No need for additional checks since the wrapper handles required, regex, etc.
        }
        
        return updatedFields
    }
}
