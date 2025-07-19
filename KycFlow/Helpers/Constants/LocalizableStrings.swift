//
//  LocalizableStrings.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import Foundation

enum CountrySelectionViewScreenConstant {
    case navTitle
    case title
    case subTitle
    case selectorFieldTitle
    case selectorFieldPlaceHolder
    
    var localized: LocalizedStringResource {
        switch self {
        case .navTitle:
            LocalizedStringResource(stringLiteral: "Country Selection")
            
        case .title:
            LocalizedStringResource(stringLiteral: "Select Your Country")
        case .subTitle:
            LocalizedStringResource(stringLiteral: "Please choose the country where you reside")
        case .selectorFieldTitle:
            LocalizedStringResource(stringLiteral: "Country of Residence")
        case .selectorFieldPlaceHolder:
            LocalizedStringResource(stringLiteral: "Select Country")
        }
    }
}

enum KycFormViewScreenConstant {
    case navTitle
    case title
    case subTitle
    
    var localized: LocalizedStringResource {
        switch self {
        case .navTitle:
            LocalizedStringResource(stringLiteral: "Complete Your KYC")
        case .title:
            LocalizedStringResource(stringLiteral: "Kyc Form View")
        case .subTitle:
            LocalizedStringResource(stringLiteral: "Please fill in all required fields")
        }
    }
}

enum SummaryViewScreenConstant {
    case navTitle
    case title
    case footerNote
    
    var localized: LocalizedStringResource {
        switch self {
        case .navTitle:
            LocalizedStringResource(stringLiteral: "Summary Review")
        case .title:
            LocalizedStringResource(stringLiteral: "Review your submitted information")
        case .footerNote:
            LocalizedStringResource(stringLiteral: "Please verify all information is correct before submitting.")
        }
    }
}

enum ButtonConstants {
    case next
    case submit
    
    var localized: LocalizedStringResource {
        switch self {
        case .next:
            LocalizedStringResource(stringLiteral: "Next")
        case .submit:
            LocalizedStringResource(stringLiteral: "Submit")
        }
    }
}

enum ValidationMessage {
    case fieldRequired
    
    var localized: String {
        switch self {
        case .fieldRequired:
          NSLocalizedString("This field is required", comment: "ValidationMessage")
        }
    }
}
