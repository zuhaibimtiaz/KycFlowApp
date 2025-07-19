//
//  FieldView.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 18/07/2025.
//

import SwiftUI

struct FieldViews: View {
    @Binding var field: FieldModel
    
    var body: some View {
        VStack(alignment: .leading) {
            switch field.type {
            case .text,
                    .number:
                TextAndNumberFieldView(field: $field)
                
            case .date:
                DatePickerFieldView(field: $field)
            }
            self.errorView
        }
        .onChange(of: field.value) { _, newValue in
            if !newValue.isEmpty,
                field.errorMessage != nil {
                field.triggerValidation()
            }
        }
    }
    
    @ViewBuilder
    var errorView: some View {
        if let error = field.errorMessage {
            Text(LocalizedStringResource(stringLiteral: error))
                .font(.caption)
                .foregroundStyle(.red)
        }
    }
}
