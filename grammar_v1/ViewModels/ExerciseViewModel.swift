import Foundation

class ExerciseViewModel: ObservableObject {
    @Published var currentQuestionIndex: Int = 0
    @Published var userAnswers: [String] = []
    @Published var isSubmitted: Bool = false
    
    private let exerciseService: ExerciseServiceProtocol
    
    init(exerciseService: ExerciseServiceProtocol = ExerciseService()) {
        self.exerciseService = exerciseService
    }
    
    func loadExercise(id: String) {
        // Reset state
        currentQuestionIndex = 0
        userAnswers = []
        isSubmitted = false
    }
    
    func loadExercisesForLesson(lessonId: String) -> [GrammarExercise] {
        // In a real app, this would load from a backend
        return createMockExercises()
    }
    
    func submitAnswer(for questionIndex: Int, answer: String) {
        while userAnswers.count <= questionIndex {
            userAnswers.append("")
        }
        userAnswers[questionIndex] = answer
    }
    
    func moveToNextQuestion() {
        if currentQuestionIndex < userAnswers.count - 1 {
            currentQuestionIndex += 1
        }
    }
    
    func moveToPreviousQuestion() {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
        }
    }
    
    // Mock data - in a real app, this would come from a backend
    private func createMockExercises() -> [GrammarExercise] {
        return [
            GrammarExercise(
                id: "1",
                title: "Present Simple Practice",
                type: .multipleChoice,
                instructions: "Choose the correct form of the verb in present simple tense.",
                relatedLessonId: "1",
                questions: [
                    GrammarQuestion(
                        prompt: "She _____ to work every day.",
                        options: ["go", "goes", "going", "went"],
                        correctAnswer: "goes",
                        explanation: "Use 'goes' because the subject is third person singular (she)."
                    ),
                    GrammarQuestion(
                        prompt: "They _____ in London.",
                        options: ["lives", "live", "living", "lived"],
                        correctAnswer: "live",
                        explanation: "Use 'live' because the subject is plural (they)."
                    )
                ]
            )
        ]
    }
}