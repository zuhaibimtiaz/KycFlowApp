//
//  ProfileDto.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Foundation

struct ProfileDto: Decodable {
    let fields: [UserProfileFieldDto]
}

struct UserProfileFieldDto: Decodable {
    let id: String
    let value: String
}
