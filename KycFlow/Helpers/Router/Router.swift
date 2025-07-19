//
//  Router.swift
//  SARAB
//
//  Created by Zuhaib Imtiaz on 09/07/2025.
//

import SwiftUI

// Typealias for a completion handler that takes an optional result and returns void
typealias ResultCompletion = (@Sendable (Any?) -> Void)?

// MARK: - Router Class
/// Observable class for managing navigation state in an app
@Observable
public final class Router {
    // Unique identifier for the router instance
    let id = UUID()
    // The level of the router in the navigation hierarchy
    let level: Int
    // The tab identifier associated with this router, if any
    let identifierTab: TabDestination?
    // The currently selected tab, if applicable
    var selectedTab: TabDestination?
    // Stack of navigation destinations with their completion handlers
    private var navigationStack: [(destination: PushDestination, completion: ResultCompletion)] = []
    // State for presenting a half-sheet with its completion handler
    private var sheetState: (destination: HalfSheetDestination, completion: ResultCompletion)?
    // State for presenting a full-screen view with its completion handler
    private var fullScreenState: (destination: FullScreenDestination, completion: ResultCompletion)?
    // Weak reference to the parent router in the hierarchy
    weak var parent: Router?
    // Indicates whether this router is currently active
    private(set) var isActive: Bool = false
    private var alertState: (destination: AlertDestination, completion: ResultCompletion)?
    
    // New computed property for alert state
    var presentingAlert: AlertDestination? {
        get { alertState?.destination }
        set { alertState = newValue.map { (destination: $0, completion: nil) } }
    }
    /// Initializes a new Router instance
    /// - Parameters:
    ///   - level: The level of the router in the navigation hierarchy
    ///   - identifierTab: The tab identifier associated with this router, if any
    init(level: Int, identifierTab: TabDestination?) {
        self.level = level
        self.identifierTab = identifierTab
        self.parent = nil
//        //AppLogger.info("\(self.debugDescription) initialized")
    }
    
    /// Deinitializes the Router instance and logs its cleanup
    deinit {
//        //AppLogger.info("\(self.debugDescription) cleared")
    }
    
    /// Resets the navigation stack and presentation states
    private func resetContent() {
        navigationStack = []
        sheetState = nil
        fullScreenState = nil
        alertState = nil
    }
    
    /// Creates a child router with an incremented level
    /// - Parameters:
    ///   - tab: The tab destination for the child router, defaults to the parent's identifierTab
    /// - Returns: A new Router instance configured as a child
    func childRouter(for tab: TabDestination? = nil) -> Router {
        let router = Router(level: level + 1, identifierTab: tab ?? identifierTab)
        router.parent = self
        return router
    }
    
    /// Marks this router as active and deactivates its parent
    func setActive() {
//        //AppLogger.info("\(self.debugDescription): \(#function)")
        parent?.resignActive()
        isActive = true
    }
    
    /// Marks this router as inactive
    func resignActive() {
//        //AppLogger.info("\(self.debugDescription): \(#function)")
        isActive = false
    }
    
    /// Creates a preview Router instance for testing or previewing
    /// - Returns: A Router instance with level 0 and no tab identifier
    static func previewRouter() -> Router {
        Router(level: 0, identifierTab: nil)
    }
    
    /// Navigates to a specified destination
    /// - Parameters:
    ///   - destination: The destination to navigate to (tab, push, sheet, or full-screen)
    func navigate(to destination: Destination) {
        switch destination {
        case let .tab(tab):
            select(tab: tab)
        case let .push(destination):
            push(destination)
        case let .sheet(destination):
            present(sheet: destination)
        case let .fullScreen(destination):
            present(fullScreen: destination)
        case let .alert(destination):
            present(alert: destination)
        }
    }
    
    /// Selects a tab and updates the navigation state
    /// - Parameters:
    ///   - destination: The tab destination to select
    func select(tab destination: TabDestination) {
//        //AppLogger.info("\(self.debugDescription) \(#function) \(destination.rawValue)")
        if level == 0 {
            selectedTab = destination
        } else {
            parent?.select(tab: destination)
            resetContent()
        }
    }
    
    /// Presents an alert with the specified destination
      /// - Parameters:
      ///   - destination: The alert destination to present
      ///   - completion: Optional completion handler to call when the alert is dismissed
      func present(alert destination: AlertDestination, completion: ResultCompletion = nil) {
          debugPrint("\(self.debugDescription): \(#function) alert \(destination.message)")
          alertState = (destination: destination, completion: completion)
      }
    
    /// Pushes a destination onto the navigation stack
    /// - Parameters:
    ///   - destination: The destination to push
    ///   - completion: Optional completion handler to call when the destination is popped
    func push(_ destination: PushDestination, completion: ResultCompletion = nil) {
//        //AppLogger.info("\(self.debugDescription): \(#function) \(destination)")
        navigationStack.append((destination: destination, completion: completion))
    }
    
    /// Presents a half-sheet with a destination
    /// - Parameters:
    ///   - destination: The half-sheet destination to present
    ///   - completion: Optional completion handler to call when the sheet is dismissed
    func present(sheet destination: HalfSheetDestination, completion: ResultCompletion = nil) {
//        //AppLogger.info("\(self.debugDescription): \(#function) sheet \(destination)")
        sheetState = (destination: destination, completion: completion)
    }
    
    /// Presents a full-screen destination
    /// - Parameters:
    ///   - destination: The full-screen destination to present
    ///   - completion: Optional completion handler to call when the full-screen view is dismissed
    func present(fullScreen destination: FullScreenDestination, completion: ResultCompletion = nil) {
//        //AppLogger.info("\(self.debugDescription): \(#function) fullScreen \(destination)")
        fullScreenState = (destination: destination, completion: completion)
    }
    
    /// Handles deep link navigation to a destination
    /// - Parameters:
    ///   - destination: The destination to navigate to via deep link
    func deepLinkOpen(to destination: Destination) {
        guard isActive else { return }
//        //AppLogger.info("\(self.debugDescription): \(#function) \(destination)")
        navigate(to: destination)
    }
    
    /// Dismisses the current sheet or full-screen view
    /// - Parameters:
    ///   - result: Optional result to pass to the completion handler
    func dismiss(result: Any? = nil) {
//        //AppLogger.info("\(self.debugDescription): \(#function)")
        if sheetState != nil {
            sheetState?.completion?(result)
            sheetState = nil
        }
        if fullScreenState != nil {
            fullScreenState?.completion?(result)
            fullScreenState = nil
        }
        if alertState != nil {
            alertState?.completion?(result)
            alertState = nil
        }
    }
    
    /// Pops the top destination from the navigation stack
    /// - Parameters:
    ///   - result: Optional result to pass to the completion handler
    func pop(result: Any? = nil) {
//        //AppLogger.info("\(self.debugDescription): \(#function)")
        if let last = navigationStack.popLast() {
            last.completion?(result)
        }
    }
    
    /// Pops all destinations back to the root of the navigation stack
    /// - Parameters:
    ///   - result: Optional result to pass to the completion handlers
    func popToRoot(result: Any? = nil) {
//        //AppLogger.info("\(self.debugDescription): \(#function)")
        while let last = navigationStack.popLast() {
            last.completion?(result)
        }
    }
    
    /// Pops destinations until reaching a specific destination
    /// - Parameters:
    ///   - destination: The destination to pop back to
    ///   - result: Optional result to pass to the completion handlers
    func popUntil(_ destination: PushDestination, result: Any? = nil) {
        //AppLogger.info("\(self.debugDescription): \(#function) until \(destination)")
        while let last = navigationStack.last, last.destination != destination {
            navigationStack.removeLast()
            last.completion?(result)
        }
    }
    
    // Computed property to get or set the navigation stack destinations
    var navigationStackPath: [PushDestination] {
        get { navigationStack.map { $0.destination } }
        set { navigationStack = newValue.map { (destination: $0, completion: nil) } }
    }
    
    // Computed property to get or set the presenting half-sheet destination
    var presentingSheet: HalfSheetDestination? {
        get { sheetState?.destination }
        set { sheetState = newValue.map { (destination: $0, completion: nil) } }
    }
    
    // Computed property to get or set the presenting full-screen destination
    var presentingFullScreen: FullScreenDestination? {
        get { fullScreenState?.destination }
        set { fullScreenState = newValue.map { (destination: $0, completion: nil) } }
    }
}

// Extension to provide a custom debug description for the Router
extension Router: CustomDebugStringConvertible {
    public var debugDescription: String {
        "Router[\(shortId) - \(identifierTabName) - Level: \(level)]"
    }
    
    // Private computed property to extract the first part of the UUID
    private var shortId: String { String(id.uuidString.split(separator: "-").first ?? "") }
    
    // Private computed property to get the tab identifier's raw value or a default
    private var identifierTabName: String {
        identifierTab?.rawValue ?? "No Tab"
    }
}
