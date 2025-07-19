//
//  DynamicFormViewModelTests.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Testing
@testable import KycFlow
import Foundation

@Suite("DynamicFormViewModel Tests")
struct DynamicFormViewModelTests {
    
    @Test("Initial state is set correctly")
    func testInitialState() {
        let fields: [FieldModel] = [
            .testField(
                id: "name",
                label: "Name"
            )
        ]
        let viewModel = DynamicFormViewModel(fields: fields)
        
        #expect(viewModel.fields == fields)
    }
    
    @Test("fieldValidation returns expected result for various field configurations",
          arguments: [
            (
                description: "Valid field with value",
                fields: [
                    FieldModel.testField(
                        id: "first_name",
                        label: "First Name",
                        value: "Zuhaib",
                        required: true
                    )
                ],
                expected: true
            ),
            (
                description: "Empty required field",
                fields: [
                    FieldModel.testField(
                        id: "first_name",
                        label: "First Name",
                        value: "",
                        required: true
                    )
                ],
                expected: false
            ),
            (
                description: "Field with error message",
                fields: [
                    FieldModel.testField(
                        id: "first_name",
                        label: "First Name",
                        value: "",
                        required: true,
                        errorMessage: "This field is invalid"
                    )
                ],
                expected: false
            ),
            (
                description: "Empty non-required field",
                fields: [
                    FieldModel.testField(
                        id: "first_name",
                        label: "First Name",
                        value: nil,
                        required: false
                    )
                ],
                expected: true
            )
          ])
    func testFieldValidation(
        _ testCase: (
            description: String,
            fields: [FieldModel],
            expected: Bool
        )
    ) {
        let viewModel = DynamicFormViewModel(fields: testCase.fields)
        #expect(
            viewModel.checkFieldsValidation() == testCase.expected,
            .init(
                stringLiteral: testCase.description
            )
        )
    }
}
