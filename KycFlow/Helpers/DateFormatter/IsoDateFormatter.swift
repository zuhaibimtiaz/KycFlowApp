//
//  IsoDateFormatter.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//
import Foundation

enum IsoDateFormatter {
    
    static let iso: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()
    
    static let output: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" // Customize as needed
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter
    }()
}
