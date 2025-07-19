//
//  DatePickerFieldView.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import SwiftUI

struct DatePickerFieldView: View {
    @Binding var field: FieldModel
    @State private var dateValue: Date = .now

    var body: some View {
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
}
