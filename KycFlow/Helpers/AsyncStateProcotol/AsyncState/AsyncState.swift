//
//  AsyncState.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

enum AsyncState: Equatable {
    // we can use loaded with Value (Generic)
    case idle, loading, loaded, failed(String)
}

