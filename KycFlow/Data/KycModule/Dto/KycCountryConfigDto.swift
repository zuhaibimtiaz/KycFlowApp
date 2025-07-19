//
//  KycCountryConfigDto.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 18/07/2025.
//

struct KycCountryConfigDto: Decodable, Hashable {
    let country: String
    var fields: [KycField]
}

struct KycField: Identifiable, Decodable, Hashable {
    let id: String
    let label: String
    let type: FieldType
    let required: Bool
    let validation: ValidationRule?
    var readOnly: Bool? = false
    var value: String?
    var errorMessage: String?

    enum FieldType: String, Decodable {
        case text, number, date
    }
}

struct ValidationRule: Decodable, Hashable {
    let regex: String?
    let message: String?
    let minLength: Int?
    let maxLength: Int?
    let minValue: Int?
    let maxValue: Int?
}
