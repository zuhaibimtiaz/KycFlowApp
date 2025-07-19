//
//  DynamicFormViewModelProtocol.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Foundation

protocol DynamicFormViewModelProtocol: Observable {
    var fields: [FieldModel] { get set }
    func checkFieldsValidation() -> Bool
}
