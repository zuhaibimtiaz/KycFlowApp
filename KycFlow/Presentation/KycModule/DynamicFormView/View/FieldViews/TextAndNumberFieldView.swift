//
//  TextAndNumberFieldView.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import SwiftUI

struct TextAndNumberFieldView: View {
    @Binding var field: FieldModel
    @State private var dateValue: Date = .now

    var body: some View {
        TextField(field.label, text: $field.value)
            .keyboardType(field.keyboartType)
            .disabled(field.readOnly)
    }
}
