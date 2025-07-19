//
//  ProfileModelMapper.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

protocol ProfileModelMapperProtocol {
    func mapToDomain(dto: ProfileDto) -> ProfileModel
}

struct ProfileModelMapper: ProfileModelMapperProtocol {
    
    func mapToDomain(dto: ProfileDto) -> ProfileModel {
        .init(
            fields: dto.fields.map {
                .init(
                    id: $0.id,
                    value: $0.value
                )
            })
    }
}
