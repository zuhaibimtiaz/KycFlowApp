//
//  FieldModel.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import SwiftUI

struct FieldModel: Identifiable {
    let id: String
    let label: String
    let type: FieldType
    let required: Bool
    let validation: ValidationRule?
    var readOnly: Bool = false
    
    // Use @Validate directly for value
    @Validate var value: String
    
    // Expose error message from the wrapper's projected value
    var errorMessage: String?
    
    // Initialize with validation rules
    init(
        id: String,
        label: String,
        type: FieldType,
        required: Bool = false,
        validation: ValidationRule? = nil,
        initialValue: String = ""
    ) {
        self.id = id
        self.label = label
        self.type = type
        self.required = required
        self.validation = validation
        
        // Build validation rules array
        var rules: [Validate<String>.ValidationRule] = []
        
        // Apply required rule
        if required {
            rules.append(
                .required(
                    message: validation?.message ?? ValidationMessage.fieldRequired.localized
                )
            )
        }
        
        // Apply text-specific rules for .text fields
        if type == .text {
            if let regex = validation?.regex,
                let message = validation?.message {
                rules.append(
                    .regularExpression(
                        pattern: regex,
                        message: message
                    )
                )
            }
            if let minLength = validation?.minLength,
                let message = validation?.message {
                rules.append(
                    .minLength(
                        minLength,
                        message: message
                    )
                )
            }
            if let maxLength = validation?.maxLength,
                let message = validation?.message {
                rules.append(
                    .maxLength(
                        maxLength,
                        message: message
                    )
                )
            }
            // Apply numeric validation if minValue or maxValue is specified
            if validation?.minValue != nil || validation?.maxValue != nil {
                // Enforce numeric input with a regex
                rules.append(
                    .regularExpression(
                        pattern: "[0-9]+",
                        message: validation?.message ?? "Must be a number"
                    )
                )
                if let minValue = validation?.minValue,
                   let maxValue = validation?.maxValue,
                   let message = validation?.message {
                    rules.append(
                        .range(
                            minValue...maxValue,
                            message: message
                        )
                    )
                }
            }
        }
        
        // Initialize the @Validate wrapper with spread array
        self._value = Validate(
            wrappedValue: initialValue,
            rules
        )
    }
    
    // Public method to trigger validation in Validator
    mutating func triggerValidation() {
        _value.showValidation()
        errorMessage = $value

    }
    
    enum FieldType: String {
        case text, number, date
    }
    
    struct ValidationRule {
        let regex: String?
        let message: String?
        let minLength: Int?
        let maxLength: Int?
        let minValue: Int?
        let maxValue: Int?
    }
}

extension FieldModel {
    var formattedFieldValue: String {
        if type == .date,
           let date = IsoDateFormatter.iso.date(from: value) {
            return IsoDateFormatter.output.string(from: date)
        }
        return value
    }
    
    var keyboartType: UIKeyboardType {
        switch type {
        case .text:
            .default
        case .number:
            .numberPad
        case .date:
            .default
        }
    }
}

extension FieldModel: Equatable {
    static func == (lhs: FieldModel, rhs: FieldModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.label == rhs.label &&
        lhs.type == rhs.type &&
        lhs.required == rhs.required &&
        lhs.value == rhs.value &&
        lhs.readOnly == rhs.readOnly &&
        lhs.errorMessage == rhs.errorMessage &&
        lhs.validation?.regex == rhs.validation?.regex &&
        lhs.validation?.message == rhs.validation?.message &&
        lhs.validation?.minLength == rhs.validation?.minLength &&
        lhs.validation?.maxLength == rhs.validation?.maxLength &&
        lhs.validation?.minValue == rhs.validation?.minValue &&
        lhs.validation?.maxValue == rhs.validation?.maxValue
    }
}
