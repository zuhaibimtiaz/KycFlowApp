//
//  CountryModel.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Foundation

struct CountryModel: Identifiable, Hashable {
    let id: String // ISO country code (e.g., "US", "NL")
    let name: String // Localized display name
    
    static var all: [CountryModel] {
        Locale.Region.isoRegions
            .compactMap { region in
                guard let name = Locale.current.localizedString(forRegionCode: region.identifier) else {
                    return nil
                }
                return CountryModel(id: region.identifier, name: name)
            }
            .sorted { $0.name < $1.name }
    }
    
    static func defaultCountry() -> CountryModel {
        let code = Locale.current.region?.identifier ?? "NL"
        let name = Locale.current.localizedString(forRegionCode: code) ?? code
        return CountryModel(id: code, name: name)
    }
}
