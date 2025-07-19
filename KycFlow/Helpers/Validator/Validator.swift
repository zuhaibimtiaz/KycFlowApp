//
//  Validate.swift
//  Validator
//
//  Created by Zuhaib Imtiaz on 24/03/2025.
//

import SwiftUI

@propertyWrapper
public struct Validate<T: Equatable> {
    public enum ValidationRule {
        case required(message: String)
        case regularExpression(pattern: String, message: String)
        case minLength(Int, message: String)  // New: Minimum length rule
        case maxLength(Int, message: String)  // New: Maximum length rule
        case allowedCharacters(CharacterSet, message: String)
        case range(ClosedRange<Int>, message: String)
        case custom((T) -> Bool, message: String)
    }
    private var value: T
    private var initialValue: T
    private var rules: [ValidationRule]
    private var isDirty = false
    private var forceValidation = false
    
    public var wrappedValue: T {
        get { value }
        set {
            if newValue != initialValue {
                isDirty = true
            }
            value = newValue
        }
    }
    
    public var projectedValue: String? {
        // Show validation if field is dirty OR if validation is forced
        guard isDirty || forceValidation else { return nil }
        
        for rule in rules {
            if let message = validate(rule: rule) {
                return message
            }
        }
        return nil
    }
    
    public init(wrappedValue: T, _ rules: ValidationRule...) {
        self.value = wrappedValue
        self.initialValue = wrappedValue
        self.rules = rules
    }
    
    public init(wrappedValue: T, _ rules: [ValidationRule]) {
        self.value = wrappedValue
        self.initialValue = wrappedValue
        self.rules = rules
    }
    
    private func validate(rule: ValidationRule) -> String? {
        switch rule {
        case .required(let message):
            return validateRequired(message: message)
        case .regularExpression(let regexExpression, let message):
            return validateRegex(
                pattern: regexExpression,
                message: message
            )
        case .minLength(let min, let message):
            return validateMinLength(min: min, message: message)
        case .maxLength(let max, let message):
            return validateMaxLength(max: max, message: message)
        case .allowedCharacters(let characterSet, let message):
            return validateAllowedCharacters(characterSet: characterSet, message: message)
        case .range(let range, let message):
            return validateRange(range: range, message: message)
        case .custom(let predicate, let message):
            return validateCustom(predicate: predicate, message: message)
        }
    }
    
    private func validateRequired(message: String) -> String? {
        if let stringValue = value as? String, stringValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return message
        }
        return nil
    }
    
    private func validateRegex(pattern: String, message: String) -> String? {
        guard let stringValue = value as? String,
                !pattern.isEmpty else { return nil }
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: stringValue.utf16.count)
        
        return regex?.firstMatch(in: stringValue, options: [], range: range) == nil ? message : nil
    }
    
    private func validateMinLength(min: Int, message: String) -> String? {
        guard let stringValue = value as? String else { return nil }
        return stringValue.count < min ? message : nil
    }
    
    private func validateMaxLength(max: Int, message: String) -> String? {
        guard let stringValue = value as? String else { return nil }
        return stringValue.count > max ? message : nil
    }
    
    private func validateAllowedCharacters(characterSet: CharacterSet, message: String) -> String? {
        guard let stringValue = value as? String else { return nil }
        return stringValue.unicodeScalars.allSatisfy { characterSet.contains($0) } ? nil : message
    }
    
    private func validateRange(range: ClosedRange<Int>, message: String) -> String? {
        guard let numericValue = value as? String,
                let intValue = Int(numericValue) else { return nil }
        return range.contains(intValue) ? nil : message
    }
    
    private func validateCustom(predicate: (T) -> Bool, message: String) -> String? {
        return predicate(value) ? nil : message
    }
    
    // Method to force validation
    public mutating func showValidation() {
        forceValidation = true
    }
}
