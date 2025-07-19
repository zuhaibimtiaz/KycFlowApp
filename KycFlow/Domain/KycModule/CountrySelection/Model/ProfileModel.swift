//
//  ProfileModel.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Foundation

struct ProfileModel {
    let fields: [ProfileField]
}

struct ProfileField {
    let id: String
    let value: String
}
