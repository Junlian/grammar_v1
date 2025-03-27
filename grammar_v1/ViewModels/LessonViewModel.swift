import Foundation

class LessonViewModel: ObservableObject {
    @Published var lessons: [GrammarLesson] = []
    @Published var isLoading: Bool = false
    
    private let lessonService: LessonServiceProtocol
    
    init(lessonService: LessonServiceProtocol = LessonService()) {
        self.lessonService = lessonService
        loadLessons()
    }
    
    func loadLessons() {
        isLoading = true
        // In a real app, this would be an async call to a backend
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.lessons = self?.createMockLessons() ?? []
            self?.isLoading = false
        }
    }
    
    func getLessonsByCategory(_ category: GrammarCategory) -> [GrammarLesson] {
        return lessons.filter { $0.category == category }
    }
    
    // Mock data - in a real app, this would come from a backend
    private func createMockLessons() -> [GrammarLesson] {
        return [
            GrammarLesson(
                id: "1",
                title: "Present Simple Tense",
                description: "Learn when and how to use the present simple tense",
                content: "The present simple tense is used to describe habits, unchanging situations, general truths, and fixed arrangements.",
                category: .verbTenses,
                level: .beginner,
                order: 1,
                examples: [
                    GrammarExample(sentence: "I play tennis every weekend.", explanation: "Regular habit"),
                    GrammarExample(sentence: "The sun rises in the east.", explanation: "General truth"),
                    GrammarExample(sentence: "The train leaves at 3pm.", explanation: "Fixed arrangement")
                ]
            ),
            GrammarLesson(
                id: "2",
                title: "Present Continuous Tense",
                description: "Master the present continuous tense for ongoing actions",
                content: "The present continuous tense is used for actions happening now and temporary situations.",
                category: .verbTenses,
                level: .beginner,
                order: 2,
                examples: [
                    GrammarExample(sentence: "I am studying grammar now.", explanation: "Action happening now"),
                    GrammarExample(sentence: "She is working in London this month.", explanation: "Temporary situation")
                ]
            )
        ]
    }
}