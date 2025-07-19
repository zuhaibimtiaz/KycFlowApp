//
//  AppRootView.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import SwiftUI

struct AppRootView: View {
    @State private var router: Router = Router(level: 0, identifierTab: nil)
    @AppStorage(AppStorageKeys.selectedLanguage.rawValue) private var selectedLanguage: String = ""
    
    var body: some View {
        NavigationContainer(parentRouter: router) {
            CountrySelectionViewScreen(viewModel: CountrySelectionViewModel())
        }
        .environment(router)
        .environment(
            \.locale,
             Locale(identifier: selectedLanguage)
        ).onAppear {
            if selectedLanguage.isEmpty {
                self.selectedLanguage =  Locale.current.region?.identifier.lowercased() ?? "en"
            }
        }
    }
}
