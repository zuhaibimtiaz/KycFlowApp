//
//  Navigator.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//



import SwiftUI

// MARK: - NavigationButton
// A SwiftUI view that triggers navigation actions based on a destination or navigation type
public struct Navigator<Content: View>: View {
    // Optional destination for general navigation
    let destination: Destination?
    // Optional tuple for push navigation with destination and completion handler
    let push: (destination: PushDestination, completion: ResultCompletion)?
    // Optional tuple for sheet presentation with destination and completion handler
    let sheet: (destination: HalfSheetDestination, completion: ResultCompletion)?
    // Optional tuple for full-screen presentation with destination and completion handler
    let fullScreen: (destination: FullScreenDestination, completion: ResultCompletion)?
    // The content view to be displayed within the button
    @ViewBuilder var content: () -> Content
    // The router instance from the environment for navigation control
    @Environment(Router.self) private var router
    let alert: (destination: AlertDestination, completion: ResultCompletion)?

    /// Initializes a Navigator with a general destination
    /// - Parameters:
    ///   - destination: The destination to navigate to
    ///   - content: The content view to display inside the button
    init(
        destination: Destination,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.destination = destination
        self.push = nil
        self.sheet = nil
        self.fullScreen = nil
        self.content = content
        self.alert = nil
    }
    
    /// Initializes a Navigator for push navigation
    /// - Parameters:
    ///   - destination: The push destination to navigate to
    ///   - completion: Optional completion handler to call when the destination is popped
    ///   - content: The content view to display inside the button
    init(
        push destination: PushDestination,
        completion: ResultCompletion = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.destination = nil
        self.push = (destination, completion)
        self.sheet = nil
        self.fullScreen = nil
        self.content = content
        self.alert = nil

    }
    
    /// Initializes a Navigator for sheet presentation
    /// - Parameters:
    ///   - destination: The half-sheet destination to present
    ///   - completion: Optional completion handler to call when the sheet is dismissed
    ///   - content: The content view to display inside the button
    init(
        sheet destination: HalfSheetDestination,
        completion: ResultCompletion = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.destination = nil
        self.push = nil
        self.sheet = (destination, completion)
        self.fullScreen = nil
        self.content = content
        self.alert = nil

    }
    
    /// Initializes a Navigator for full-screen presentation
    /// - Parameters:
    ///   - destination: The full-screen destination to present
    ///   - completion: Optional completion handler to call when the full-screen view is dismissed
    ///   - content: The content view to display inside the button
    init(
        fullScreen destination: FullScreenDestination,
        completion: ResultCompletion = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.destination = nil
        self.push = nil
        self.sheet = nil
        self.fullScreen = (destination, completion)
        self.content = content
        self.alert = nil

    }
    
    /// Initializes a Navigator for presenting an alert
       /// - Parameters:
       ///   - destination: The alert destination to present
       ///   - completion: Optional completion handler to call when the alert is dismissed
       ///   - content: The content view to display inside the button
       init(
           alert destination: AlertDestination,
           completion: ResultCompletion = nil,
           @ViewBuilder content: @escaping () -> Content
       ) {
           self.destination = nil
           self.push = nil
           self.sheet = nil
           self.fullScreen = nil
           self.alert = (destination, completion)
           self.content = content
       }
    
    // The main view body of the Navigator, rendering a button with navigation actions
    public var body: some View {
        Button(
            action: {
                if let destination = destination {
                    router.navigate(to: destination)
                } else if let (destination, completion) = push {
                    router.push(destination, completion: completion)
                } else if let (destination, completion) = sheet {
                    router.present(sheet: destination, completion: completion)
                } else if let (destination, completion) = fullScreen {
                    router.present(fullScreen: destination, completion: completion)
                } else if let (destination, completion) = alert {
                    router.present(alert: destination, completion: completion)
                }
            },
            label: {
                content()
                    .background(Color.clear)
            }
        )
    }
}

