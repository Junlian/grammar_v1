import Foundation

class UserViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var isLoggedIn: Bool = false
    @Published var dailyGoalProgress: Double = 0.0
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
        loadUser()
    }
    
    func loadUser() {
        // In a real app, this would load from UserDefaults or a backend
        currentUser = userService.getCurrentUser()
        isLoggedIn = currentUser != nil
        
        // Mock progress - in a real app, this would be calculated
        dailyGoalProgress = 0.6 // 60% of daily goal completed
    }
    
    func updateProgress(minutesSpent: Int) {
        userService.updateUserProgress(minutesSpent: minutesSpent)
        // Update progress calculation
        if let user = currentUser {
            dailyGoalProgress = min(1.0, Double(minutesSpent) / Double(user.dailyGoalMinutes))
        }
    }
    
    func logout() {
        userService.clearUserData()
        currentUser = nil
        isLoggedIn = false
    }
}