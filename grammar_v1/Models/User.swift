import Foundation

// User model
struct User {
    let name: String
    let email: String
    let profileImageName: String
    var level: ProficiencyLevel
    var learningGoal: LearningGoal
    var dailyGoalMinutes: Int
    var streakDays: Int
}

// Proficiency level enum
enum ProficiencyLevel: String, CaseIterable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
}

// Learning goal enum
enum LearningGoal: String, CaseIterable {
    case general = "General English"
    case academic = "Academic English"
    case business = "Business English"
    case travel = "Travel English"
    case exam = "Exam Preparation"
}