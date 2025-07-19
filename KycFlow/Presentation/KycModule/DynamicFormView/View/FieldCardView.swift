//
//  FieldCardView.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 18/07/2025.
//

import SwiftUI

// MARK: - Field Card View
struct FieldCardView: View {
    @Binding var field: FieldModel
    
    var body: some View {
        VStack(alignment: .leading) {
            // Field Label
            GroupBox {
                // Field Content
                GroupBox {
                    FieldView(field: $field)
                }
            } label: {
                HStack {
                    Text(field.label)
                        .font(.subheadline.bold())
                        .foregroundStyle(field.readOnly ? .secondary : .primary)
                    
                    if field.required {
                        Text("*")
                            .font(.subheadline)
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}
