//
//  CountrySelectable.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Foundation

typealias CountrySelectionViewModelProtocol = CountrySelectable & FormLoadable & AsyncStateProtocol

protocol CountrySelectable: Observable {
    var selectedCountry: CountryModel { get set }
    var availableCountries: [CountryModel] { get }
}

protocol FormLoadable: Observable {
    var fields: [FieldModel] { get set }
    func loadForm() async
}
