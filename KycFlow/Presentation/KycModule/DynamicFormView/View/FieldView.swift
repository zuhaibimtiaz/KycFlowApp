//
//  FieldView.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 18/07/2025.
//

import SwiftUI

struct FieldView: View {
    @Binding var field: FieldModel
    @State private var dateValue: Date = .now
    
    var body: some View {
        VStack(alignment: .leading) {
            switch field.type {
            case .text,
                    .number:
                TextField(field.label, text: $field.value)
                    .keyboardType(field.keyboartType)
                    .disabled(field.readOnly)
                
            case .date:
                
                DatePicker(
                    selection: Binding(
                        get: {
                            if let date = ISO8601DateFormatter().date(
                                from: field.value
                            ) {
                                return date
                            }
                            return dateValue
                        },
                        set: {
                            field.value = ISO8601DateFormatter().string(
                                from: $0
                            )
                        }
                    ),
                    displayedComponents: .date) {
                        Text(field.label)

                    }
                    .disabled(field.readOnly)
                    .onAppear {
                        if field.value.isEmpty {
                            field.value =  ISO8601DateFormatter().string(from: dateValue)
                        }
                    }
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
