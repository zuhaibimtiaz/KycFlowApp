//
//  AppError.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

enum AppError: Error, CustomStringConvertible {
    
    case decodingError(String)
    case unknownError(String)
    case fileNotFound(String)
    
    var description: String {
        switch self {
        case .decodingError(let string):
            string
        case .fileNotFound(let string):
            string
        case .unknownError(let string):
            string
        }
    }
}

