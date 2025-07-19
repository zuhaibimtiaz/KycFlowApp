//
//  AsyncStateProcotol.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Foundation

// Typo fix: "Procotol" → "Protocol"
protocol AsyncStateProtocol: Observable {
    var state: AsyncState { get }
}
