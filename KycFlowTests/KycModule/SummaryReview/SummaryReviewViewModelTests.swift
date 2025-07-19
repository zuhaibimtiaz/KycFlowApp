//
//  DynamicFormViewModelTests.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Testing
@testable import KycFlow
import Foundation

@Suite("SummaryReviewViewModel Tests")
struct SummaryReviewViewModelTests {
    
    @Test("Initial state is set correctly")
    func testInitialState() {
        let fields: [FieldModel] = [
            .testField(
                id: "first_name",
                label: "First Name",
                type: .text,
                required: true
            )
        ]
        let viewModel = SummaryReviewViewModel(fields: fields)
        
        #expect(viewModel.fields == fields)
    }
    
    @Test("submit updates state to loading and loaded on success")
    func testSubmitSuccess() async {
        let fields: [FieldModel] = [
            .init(
                id: "first_name",
                label: "First Name",
                type: .text,
                required: true,
                validation: nil,
                initialValue: "Zuhaib"
            )
        ]
        let viewModel = SummaryReviewViewModel(
            fields: fields)
        
        await viewModel.submit()
        
        #expect(viewModel.state == .loaded)
    }
    
    @Test(
        "submit returns expected state for various scenarios",
        arguments: [
            (
                description: "Success with mock use case",
                fields: [
                    FieldModel.testField(
                        id: "first_name",
                        label: "First Name",
                        type: .text,
                        value: "Zuhaib",
                        required: true
                    )
                ],
                useCase: MockSubmitKycFormFieldUseCase(
                    result: .success(())
                ),
                expectedState: AsyncState.loaded
            ),
            (
                description: "AppError with mock use case",
                fields: [
                    FieldModel.testField(
                        id: "first_name",
                        label: "First Name",
                        type: .text,
                        value: "Zuhaib",
                        required: true
                    )
                ],
                useCase: MockSubmitKycFormFieldUseCase(
                    result: .failure(
                        AppError.unknownError(
                            "Submission failed"
                        )
                    )
                ),
                expectedState: AsyncState.failed(
                    "Submission failed"
                )
            ),
            (
                description: "Generic error with mock use case",
                fields: [
                    FieldModel.testField(
                        id: "first_name",
                        label: "First Name",
                        type: .text,
                        value: "Zuhaib",
                        required: true
                    )
                ],
                useCase: MockSubmitKycFormFieldUseCase(
                    result: .failure(
                        NSError(
                            domain: "Test",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey: "Generic error"]
                        )
                    )
                ),
                expectedState: AsyncState.failed("Generic error")
            )
        ]
    )
    func testSubmit(
        _ testCase: (
            description: String,
            fields: [FieldModel],
            useCase: SubmitKycFormFieldUseCaseProtocol,
            expectedState: AsyncState
        )
    ) async {
        let viewModel = SummaryReviewViewModel(
            fields: testCase.fields,
            useCase: testCase.useCase
        )
        
        await viewModel.submit()
        
        #expect(
            viewModel.state == testCase.expectedState,
            .init(stringLiteral: testCase.description)
        )
    }
}
