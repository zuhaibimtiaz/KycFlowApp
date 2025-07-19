//
//  KycConfigModel.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

struct KycConfigModel {
    enum FieldSource: String, Hashable {
        case manual, remote
    }
    let country: String
    let source: FieldSource?
    var fields: [FieldModel]
}

