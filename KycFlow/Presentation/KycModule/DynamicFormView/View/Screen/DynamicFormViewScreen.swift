//
//  DynamicFormViewScreen.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 18/07/2025.
//

import SwiftUI

struct DynamicFormViewScreen<ViewModel: DynamicFormViewModelProtocol>: View {
    @Environment(Router.self) private var router
    @State var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: UIConstants.spacing.small) {
                // Header
                subTitleView
                
                // Form Fields
                formFieldsView
            }
            .padding(.horizontal)
        }
        .safeAreaInset(edge: .bottom) {
            ButtonView(
                title: ButtonConstants.next.localized,
                icon: "arrow.right",
                action: nextAction
            )
            .padding(.horizontal, UIConstants.padding.large)
        }
        .navigationTitle(Text(KycFormViewScreenConstant.navTitle.localized))
    }
    
    var subTitleView: some View {
        Text(KycFormViewScreenConstant.subTitle.localized)
            .subTitleStyle()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, UIConstants.padding.large)
            .padding(.bottom, UIConstants.padding.small)
    }
    
    @ViewBuilder
    var formFieldsView: some View {
        ForEach($viewModel.fields, id: \.id) { $field in
            FieldCardView(field: $field)
        }
    }
}

// MARK: - Next Button Action
private extension DynamicFormViewScreen {
    func nextAction() {
        if viewModel.checkFieldsValidation() {
            self.router.push(
                .summaryReview(fields: viewModel.fields)
            )
            
        }
    }
}
