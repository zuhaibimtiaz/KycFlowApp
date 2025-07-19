//
//  MockData.swift
//  TestKYCApp
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Testing
@testable import KycFlow

// Mock models
extension CountryModel {
    static func testCountry(id: String = "US", name: String = "United States") -> CountryModel {
        CountryModel(id: id, name: name)
    }
}

extension KycConfigModel {
    static func testConfig(
        country: String = "US",
        fields: [FieldModel] = [],
        source: FieldSource = .remote
    ) -> KycConfigModel {
        KycConfigModel(country: country, source: source, fields: fields)
    }
}

extension ProfileModel {
    static func testProfile(fields: [ProfileField] = []) -> ProfileModel {
        ProfileModel(fields: fields)
    }
}

extension FieldModel {
    static func testField(
        id: String,
        label: String,
        type: FieldType = .text,
        value: String? = nil,
        required: Bool = false,
        validation: ValidationRule? = nil,
        readOnly: Bool = false,
        errorMessage: String? = nil
    ) -> FieldModel {
        var field = FieldModel(
            id: id,
            label: label,
            type: type,
            required: required,
            validation: validation,
            initialValue: value ?? ""
        )
        field.readOnly = readOnly
        field.errorMessage = errorMessage
        return field
    }
}
