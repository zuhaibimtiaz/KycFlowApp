//
//  NavigationContainer.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import SwiftUI

// MARK: - NavigationContainer
// A SwiftUI view that manages navigation state using a Router
struct NavigationContainer<Content: View>: View {
    // The router instance managing navigation state
    @State var router: Router
    // The content view to be displayed within the navigation container
    @ViewBuilder var content: () -> Content
    
    /// Initializes a NavigationContainer with a parent router and content
    /// - Parameters:
    ///   - parentRouter: The parent Router instance
    ///   - tab: Optional tab destination for the child router
    ///   - content: The content view to display
    init(
        parentRouter: Router,
        tab: TabDestination? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._router = .init(initialValue: parentRouter.childRouter(for: tab))
        self.content = content
    }
    
    // The main view body of the NavigationContainer
    var body: some View {
        InnerContainer(router: router) {
            content()
        }
        .environment(router)
        .onAppear(perform: router.setActive)
        .onDisappear(perform: router.resignActive)
    }
    
}

// MARK: - InnerContainer
// A private SwiftUI view that manages the navigation stack and presentations
private struct InnerContainer<Content: View>: View {
    // Bindable router instance for navigation state
    @Bindable var router: Router
    // The content view to be displayed within the inner container
    @ViewBuilder var content: () -> Content
    @State private var isAlertPresented: Bool = false

    // The main view body of the InnerContainer
    var body: some View {
        NavigationStack(path: $router.navigationStackPath) {
            content()
                .navigationDestination(for: PushDestination.self) { destination in
                    destination.view
                }
        }
        .sheet(item: $router.presentingSheet) { navigationView(for: $0) }
        .fullScreenCover(item: $router.presentingFullScreen) { navigationView(for: $0) }
        .alert(
            router.presentingAlert?.message ?? "",
            isPresented: Binding(
                get: { router.presentingAlert != nil },
                set: { if !$0 { router.dismiss() } }
            )
        ) {
            if let alert = router.presentingAlert {
                if let primary = alert.primaryConfig {
                    Button(
                        primary.title,
                        action: primary.action ?? {
                        })
                }
                if let secondary = alert.secondaryConfig {
                    Button(
                        secondary.title,
                        action: secondary.action ?? {
                        })
                }
                if alert.primaryConfig == nil && alert.secondaryConfig == nil {
                    Button("OK", action: {})
                }
            }
        }
    }
    
    /// Creates a navigation view for a half-sheet destination
    /// - Parameters:
    ///   - destination: The half-sheet destination to display
    /// - Returns: A view configured for the half-sheet presentation
    @ViewBuilder
    func navigationView(
        for destination: HalfSheetDestination
    ) -> some View {
        NavigationContainer(parentRouter: router) {
            destination.view
                .environment(router)
                .navigationBarTitleDisplayMode(.inline)
                .presentationDetents([.medium, .large])
                .presentationBackground(.regularMaterial)

        }
    }
    
    /// Creates a navigation view for a full-screen destination
    /// - Parameters:
    ///   - destination: The full-screen destination to display
    /// - Returns: A view configured for the full-screen presentation
    @ViewBuilder
    func navigationView(
        for destination: FullScreenDestination
    ) -> some View {
        NavigationContainer(parentRouter: router) {
            destination.view
                .environment(router)
        }
    }
}
