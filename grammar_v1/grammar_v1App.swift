import SwiftUI

@main
struct grammar_v1App: App {
    @StateObject private var userViewModel = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            if userViewModel.isLoggedIn {
                HomeView()
                    .environmentObject(userViewModel)
            } else {
                OnboardingView()
                    .environmentObject(userViewModel)
            }
        }
    }
}