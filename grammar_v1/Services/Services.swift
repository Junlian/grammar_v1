import Foundation

// Protocol for User Service
protocol UserServiceProtocol {
    func getCurrentUser() -> User?
    func saveUser(_ user: User)
    func updateUserProgress(minutesSpent: Int)
    func clearUserData()
}

// Implementation of User Service
class UserService: UserServiceProtocol {
    // In a real app, this would interact with UserDefaults, Keychain, or a backend API
    
    func getCurrentUser() -> User? {
        // Mock implementation - in a real app, this would retrieve from storage
        return User(
            name: "Sarah Johnson",
            email: "sarah.j@example.com",
            profileImageName: "profile_default",
            level: .intermediate,
            learningGoal: .academic,
            dailyGoalMinutes: 20,
            streakDays: 7
        )
    }
    
    func saveUser(_ user: User) {
        // Mock implementation - in a real app, this would save to storage
        print("Saving user: \(user.name)")
    }
    
    func updateUserProgress(minutesSpent: Int) {
        // Mock implementation - in a real app, this would update progress in storage
        print("Updated user progress: \(minutesSpent) minutes spent")
    }
    
    func clearUserData() {
        // Mock implementation - in a real app, this would clear user data from storage
        print("Cleared user data")
    }
}

// Protocol for Lesson Service
protocol LessonServiceProtocol {
    func getLessons() -> [GrammarLesson]
    func getLessonById(id: String) -> GrammarLesson?
    func getLessonsByCategory(category: GrammarCategory) -> [GrammarLesson]
    func getLessonsByLevel(level: ProficiencyLevel) -> [GrammarLesson]
}

// Implementation of Lesson Service
class LessonService: LessonServiceProtocol {
    // In a real app, this would interact with a database or API
    
    private var lessons: [GrammarLesson] = []
    
    init() {
        // In a real app, this would load from a database or API
        // For prototype, we'll use mock data
        lessons = createMockLessons()
    }
    
    func getLessons() -> [GrammarLesson] {
        return lessons
    }
    
    func getLessonById(id: String) -> GrammarLesson? {
        return lessons.first(where: { $0.id == id })
    }
    
    func getLessonsByCategory(category: GrammarCategory) -> [GrammarLesson] {
        return lessons.filter { $0.category == category }
    }
    
    func getLessonsByLevel(level: ProficiencyLevel) -> [GrammarLesson] {
        return lessons.filter { $0.level == level }
    }
    
    // Mock data creation - in a real app, this would come from a database
    private func createMockLessons() -> [GrammarLesson] {
        // This would be the same mock data as in LessonViewModel
        // For brevity, returning an empty array here
        return []
    }
}

// Protocol for Exercise Service
protocol ExerciseServiceProtocol {
    func getExercises() -> [GrammarExercise]
    func getExerciseById(id: String) -> GrammarExercise?
    func getExercisesForLesson(lessonId: String) -> [GrammarExercise]
}

// Implementation of Exercise Service
class ExerciseService: ExerciseServiceProtocol {
    // In a real app, this would interact with a database or API
    
    private var exercises: [GrammarExercise] = []
    
    init() {
        // In a real app, this would load from a database or API
        // For prototype, we'll use mock data
        exercises = createMockExercises()
    }
    
    func getExercises() -> [GrammarExercise] {
        return exercises
    }
    
    func getExerciseById(id: String) -> GrammarExercise? {
        return exercises.first(where: { $0.id == id })
    }
    
    func getExercisesForLesson(lessonId: String) -> [GrammarExercise] {
        return exercises.filter { $0.relatedLessonId == lessonId }
    }
    
    // Mock data creation - in a real app, this would come from a database
    private func createMockExercises() -> [GrammarExercise] {
        // This would be the same mock data as in ExerciseViewModel
        // For brevity, returning an empty array here
        return []
    }
}

// Protocol for Progress Service
protocol ProgressServiceProtocol {
    func getUserProgress(userId: String) -> LearningProgress?
    func saveProgress(_ progress: LearningProgress)
    func updateLessonProgress(userId: String, lessonId: String, timeSpent: Int)
    func updateExerciseProgress(userId: String, exerciseId: String, score: Float, timeSpent: Int)
}

// Implementation of Progress Service
class ProgressService: ProgressServiceProtocol {
    // In a real app, this would interact with a database or API
    
    func getUserProgress(userId: String) -> LearningProgress? {
        // Mock implementation - in a real app, this would retrieve from storage
        return LearningProgress(
            userId: userId,
            completedLessons: [],
            completedExercises: [],
            masteryLevels: [:],
            totalTimeSpentMinutes: 120,
            lastUpdated: Date()
        )
    }
    
    func saveProgress(_ progress: LearningProgress) {
        // Mock implementation - in a real app, this would save to storage
        print("Saving progress for user: \(progress.userId)")
    }
    
    func updateLessonProgress(userId: String, lessonId: String, timeSpent: Int) {
        // Mock implementation - in a real app, this would update in storage
        print("Updated lesson progress: \(lessonId) for user \(userId), time spent: \(timeSpent) minutes")
    }
    
    func updateExerciseProgress(userId: String, exerciseId: String, score: Float, timeSpent: Int) {
        // Mock implementation - in a real app, this would update in storage
        print("Updated exercise progress: \(exerciseId) for user \(userId), score: \(score), time spent: \(timeSpent) minutes")
    }
}