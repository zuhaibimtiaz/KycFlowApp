//
//  SummaryReviewScreen.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import SwiftUI

struct SummaryReviewScreen<ViewModel: SummaryReviewViewModelProtocol>: View {
    
    @Environment(Router.self) private var router
    @State var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: UIConstants.spacing.small) {
                // Header Section
                VStack(alignment: .leading, spacing: UIConstants.spacing.small) {
                    Text(SummaryViewScreenConstant.title.localized)
                        .subTitleStyle()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.bottom, UIConstants.padding.small)
                
                // Content Card
                LazyVStack(alignment: .leading, spacing: .zero) {
                    ForEach(viewModel.fields) { field in
                        FieldRowView(field: field)
                    }
                }
                .padding(.horizontal)
                
                // Footer Note
                Text(SummaryViewScreenConstant.footerNote.localized)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(UIConstants.padding.medium)
            }
            .padding(.vertical)
        }
        .safeAreaInset(
            edge: .bottom,
            content: {
                ButtonView(
                    title: ButtonConstants.submit.localized,
                    isLoading: viewModel.state == .loading,
                    isDisable: viewModel.state == .loading,
                    action: submit
                )
                .padding(.horizontal, UIConstants.padding.large)
                
            })
        .navigationTitle(Text(SummaryViewScreenConstant.navTitle.localized))
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension SummaryReviewScreen {
    func submit() {
        Task {
            await self.viewModel.submit()
            router.popToRoot()
        }
    }
}
