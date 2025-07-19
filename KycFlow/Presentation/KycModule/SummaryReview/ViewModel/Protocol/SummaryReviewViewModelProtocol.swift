//
//  SummaryReviewViewModelProtocol.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Foundation

typealias SummaryReviewViewModelProtocol = AsyncStateProtocol & FieldsStateProtocol

protocol FieldsStateProtocol: Observable {
    var fields: [FieldModel] { get set }
    func submit() async
}
