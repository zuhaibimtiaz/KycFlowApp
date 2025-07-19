//
//  FieldRowView.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import SwiftUI

// Reusable Field Row View
struct FieldRowView: View {
    let field: FieldModel
    
    var body: some View {
        VStack(alignment: .leading) {
            GroupBox {
                GroupBox {
                    Text(field.formattedFieldValue)
                        .font(.body)
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            } label: {
                HStack {
                    Text(field.label)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    if field.required {
                        Text("Required")
                            .font(.caption2)
                            .foregroundColor(.red)
                            .padding(4)
                            .background(Capsule().fill(Color.red.opacity(0.1)))
                    }
                }
            }
        }
    }
}
