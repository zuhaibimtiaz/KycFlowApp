//
//  KycConfigModelMapper.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 18/07/2025.
//

import Foundation

protocol KycConfigModelMapperProtocol {
    func mapToDomain(dto: KycCountryConfigDto) -> KycConfigModel
}

struct KycConfigModelMapper: KycConfigModelMapperProtocol {
    
    func mapToDomain(dto: KycCountryConfigDto) -> KycConfigModel {
        /// country specific check is added here, once our config have dataSource property then we can just directly map this from dto to model
        return KycConfigModel(
            country: dto.country,
            source: dto.country.lowercased() == "nl" ? .remote : .manual,
            fields: dto.fields.map {
                .init(
                    id: $0.id,
                    label: $0.label,
                    type: getFieldType(type: $0.type),
                    required: $0.required,
                    validation: $0.validation == nil ? nil :
                            .init(
                                regex: $0.validation?.regex,
                                message: $0.validation?.message,
                                minLength: $0.validation?.minLength,
                                maxLength: $0.validation?.maxLength,
                                minValue: $0.validation?.minValue,
                                maxValue: $0.validation?.maxValue
                            )
                )
            }
        )
    }
    
    private func getFieldType(type: KycField.FieldType) -> FieldModel.FieldType {
        switch type {
        case .text: .text
        case .number: .number
        case .date: .date
        }
    }
}
