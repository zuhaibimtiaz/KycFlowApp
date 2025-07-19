//
//  CountrySelectionViewModelTests.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Testing
@testable import KycFlow
import Foundation

@Suite("CountrySelectionViewModel Tests")
struct CountrySelectionViewModelTests {
    
    @Test("Initial state is set correctly")
    func testInitialState() {
        let configModel = KycConfigModel.testConfig(
            country: "NL",
            fields: [],
            source: .manual
        )
        
        let profileModel = ProfileModel.testProfile(
            fields: [
                .init(
                    id: "first_name",
                    value: "Zuhaib"
                ),
                .init(
                    id: "last_name",
                    value: "Imtiaz"
                ),
                .init(
                    id: "date_of_birth",
                    value: "1990-22-12"
                )
            ]
        )
        
        let viewModel = CountrySelectionViewModel(
            fetchConfigUseCase: MockFetchKycConfigUseCase(result: .success(configModel)),
            fetchProfileUseCase: MockProfileUseCase(result: .success(profileModel))
        )
        
        #expect(viewModel.state == .idle)
        #expect(viewModel.selectedCountry == .defaultCountry())
        #expect(viewModel.availableCountries == CountryModel.all)
        #expect(viewModel.fields.isEmpty)
    }
    
    @Test(
        "loadForm returns expected state and fields for various scenarios",
        arguments: [
            (
                description: "Success with remote source and profile data",
                selectedCountry: CountryModel.testCountry(id: "NL", name: "Netherlands"),
                configResult: Result<KycConfigModel, Error>.success(
                    KycConfigModel.testConfig(
                        country: "NL",
                        fields: [
                            .testField(
                                id: "first_name",
                                label: "First Name",
                                type: .text,
                                required: true
                            )
                        ],
                        source: .remote
                    )
                ),
                profileResult: Result<ProfileModel, Error>.success(
                    ProfileModel.testProfile(
                        fields: [
                            .init(
                                id: "first_name",
                                value: "Zuhaib"
                            ),
                            .init(
                                id: "last_name",
                                value: "Imtiaz"
                            ),
                            .init(
                                id: "date_of_birth",
                                value: "1990-22-12"
                            )
                        ]
                    )
                ),
                expectedState: AsyncState.loaded,
                expectedFieldsCount: 1,
                expectNonEmptyFields: true
            ),
            (
                description: "Success for Netherlands with default use case",
                selectedCountry: CountryModel.testCountry(
                    id: "NL",
                    name: "Netherlands"
                ),
                configResult: nil,
                // Use default use case
                profileResult: nil,
                // Use default use case
                expectedState: AsyncState.loaded,
                expectedFieldsCount: nil,
                // Don't check specific count for default use case
                expectNonEmptyFields: true
            ),
            (
                description: "Success for Germany with default use case",
                selectedCountry: CountryModel.testCountry(
                    id: "DE",
                    name: "Germany"
                ),
                configResult: nil,
                // Use default use case
                profileResult: nil,
                // Use default use case
                expectedState: AsyncState.loaded,
                expectedFieldsCount: nil,
                // Don't check specific count for default use case
                expectNonEmptyFields: false
            ),
            (
                description: "AppError with mock use case",
                selectedCountry: CountryModel.testCountry(
                    id: "NL",
                    name: "Netherlands"
                ),
                configResult: Result<KycConfigModel, Error>.failure(AppError.fileNotFound("Config file not found")),
                profileResult: Result<ProfileModel, Error>.success(
                    ProfileModel.testProfile(
                        fields: [
                            .init(
                                id: "first_name",
                                value: "Zuhaib"
                            ),
                            .init(
                                id: "last_name",
                                value: "Imtiaz"
                            ),
                            .init(
                                id: "date_of_birth",
                                value: "1990-22-12"
                            )
                        ]
                    )
                ),
                expectedState: AsyncState.failed("Config file not found"),
                expectedFieldsCount: 0,
                expectNonEmptyFields: false
            )
        ]
    )
    func testLoadForm_MockUseCase(
        _ testCase: (
            description: String,
            selectedCountry: CountryModel,
            configResult: Result<KycConfigModel, Error>?,
            profileResult: Result<ProfileModel, Error>?,
            expectedState: AsyncState,
            expectedFieldsCount: Int?,
            expectNonEmptyFields: Bool
        )
    ) async {
        let viewModel: CountrySelectionViewModel
        if let configResult = testCase.configResult,
           let profileResult = testCase.profileResult {
            viewModel = CountrySelectionViewModel(
                fetchConfigUseCase: MockFetchKycConfigUseCase(
                    result: configResult
                ),
                fetchProfileUseCase: MockProfileUseCase(
                    result: profileResult
                )
            )
        } else {
            viewModel = CountrySelectionViewModel()
        }
        
        viewModel.selectedCountry = testCase.selectedCountry
        await viewModel.loadForm()
        
        #expect(
            viewModel.state == testCase.expectedState,
            .init(stringLiteral: testCase.description)
        )
        
        if let expectedFieldsCount = testCase.expectedFieldsCount {
            #expect(
                viewModel.fields.count == expectedFieldsCount,
                Comment("\(testCase.description): Expected fields count")
            )
        }
        
        if testCase.expectNonEmptyFields {
            #expect(
                viewModel.fields.allSatisfy { !$0.value.isEmpty },
                Comment("\(testCase.description): Expected non-empty field values")
            )
        }
    }
    
    @Test("loadForm updates state to loading and loaded on success")
    func testLoadFormNetherland_Success() async {
        let viewModel = CountrySelectionViewModel()
        viewModel.selectedCountry = CountryModel(
            id: "NL",
            name: "Netherlands"
        )
        await viewModel.loadForm()
        
        #expect(viewModel.state == .loaded)
        #expect(viewModel.fields.isEmpty == false)
        #expect(viewModel.fields.allSatisfy{ $0.value.isEmpty == false } == true)
    }
    
    @Test("loadForm updates state to loading and loaded on success")
    func testLoadFormGermany_Success() async {
        let viewModel = CountrySelectionViewModel()
        viewModel.selectedCountry = CountryModel(
            id: "DE",
            name: "Germany"
        )
        await viewModel.loadForm()
        
        #expect(viewModel.state == .loaded)
        #expect(viewModel.fields.isEmpty == false)
    }
}
