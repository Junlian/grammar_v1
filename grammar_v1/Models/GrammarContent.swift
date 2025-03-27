import Foundation

// Grammar lesson model
struct GrammarLesson: Identifiable {
    let id: String
    let title: String
    let description: String
    let content: String
    let category: GrammarCategory
    let level: ProficiencyLevel
    let order: Int
    let examples: [GrammarExample]
}

// Grammar example model
struct GrammarExample: Identifiable {
    let id = UUID()
    let sentence: String
    let explanation: String
}

// Grammar exercise model
struct GrammarExercise: Identifiable {
    let id: String
    let title: String
    let type: ExerciseType
    let instructions: String
    let relatedLessonId: String
    let questions: [GrammarQuestion]
}

// Grammar question model
struct GrammarQuestion: Identifiable {
    let id = UUID()
    let prompt: String
    let options: [String]?
    let correctAnswer: String
    let explanation: String
}

// Grammar category enum
enum GrammarCategory: String, CaseIterable {
    case verbTenses = "Verb Tenses"
    case nouns = "Nouns"
    case adjectives = "Adjectives"
    case adverbs = "Adverbs"
    case prepositions = "Prepositions"
    case articles = "Articles"
    case pronouns = "Pronouns"
    case conjunctions = "Conjunctions"
}

// Exercise type enum
enum ExerciseType {
    case multipleChoice
    case fillInTheBlank
    case matching
    case reordering
}

// Learning progress model
struct LearningProgress {
    let userId: String
    var completedLessons: [String] // Lesson IDs
    var completedExercises: [String] // Exercise IDs
    var masteryLevels: [GrammarCategory: Float] // Category mastery levels (0.0 to 1.0)
    var totalTimeSpentMinutes: Int
    var lastUpdated: Date
}