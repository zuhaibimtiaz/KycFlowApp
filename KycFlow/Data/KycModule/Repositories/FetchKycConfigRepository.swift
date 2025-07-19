//
//  FetchKycConfigRepository.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 18/07/2025.
//

import Foundation

protocol FetchKycConfigRepositoryProtocol {
    func fetch(country: CountryModel) async throws -> KycConfigModel
}

struct FetchKycConfigRepository: FetchKycConfigRepositoryProtocol {
    
    private var mapper: KycConfigModelMapperProtocol
    
    init(mapper: KycConfigModelMapperProtocol = KycConfigModelMapper()) {
        self.mapper = mapper
    }
    
    func fetch(country: CountryModel) async throws -> KycConfigModel {
        let dto = try await loadConfig(for: country)
        return self.mapper.mapToDomain(dto: dto)
    }
    
    private func loadConfig(for country: CountryModel) async throws -> KycCountryConfigDto {
        guard let url = Bundle.main.url(
            forResource: "kyc_config_\(country.id.lowercased())",
            withExtension: "json"
        ) else {
            throw AppError.fileNotFound(
                "File not found for country: \(country.name)"
            )
        }
        do {
            let data = try Data(contentsOf: url)
            
            return try JSONDecoder().decode(
                KycCountryConfigDto.self,
                from: data
            )
        } catch {
            throw AppError.decodingError("Failed to decode response: \(error.localizedDescription)")
        }
    }
}
