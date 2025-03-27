import SwiftUI

struct LessonDetailView: View {
    var lesson: GrammarLesson
    @State private var showingExercise = false
    @State private var selectedExercise: GrammarExercise?
    @StateObject var exerciseViewModel = ExerciseViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Progress bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color("Border"))
                            .frame(width: geometry.size.width, height: 10)
                            .cornerRadius(5)
                        
                        Rectangle()
                            .fill(Color("Primary"))
                            .frame(width: geometry.size.width * 0.6, height: 10) // 60% progress
                            .cornerRadius(5)
                    }
                }
                .frame(height: 10)
                .padding(.horizontal)
                
                // Lesson content
                VStack(alignment: .leading, spacing: 20) {
                    // Lesson title
                    Text(lesson.title)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color("Text"))
                        .padding(.horizontal)
                    
                    // Lesson description
                    Text(lesson.description)
                        .font(.system(size: 16))
                        .foregroundColor(Color("Text"))
                        .padding(.horizontal)
                    
                    // Lesson content
                    Text(lesson.content)
                        .font(.system(size: 16))
                        .foregroundColor(Color("Text"))
                        .padding(.horizontal)
                    
                    // Examples
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Examples:")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color("Text"))
                        
                        ForEach(lesson.examples) { example in
                            VStack(alignment: .leading, spacing: 5) {
                                Text(example.sentence)
                                    .font(.system(size: 16))
                                    .foregroundColor(Color("Text"))
                                
                                Text(example.explanation)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color("SecondaryText"))
                                    .padding(.leading, 10)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .padding()
                    .background(Color("Background"))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // Formula section (for verb tenses)
                    if lesson.category == .verbTenses {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Formula:")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color("Text"))
                            
                            // Example formula based on tense
                            let formula = getFormula(for: lesson.title)
                            Text(formula)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color("Primary"))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                                .background(Color("Background"))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                    
                    // Usage section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("When to use:")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color("Text"))
                        
                        // Usage points
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(getUsagePoints(for: lesson.title), id: \.self) { point in
                                HStack(alignment: .top) {
                                    Circle()
                                        .fill(Color("Text"))
                                        .frame(width: 6, height: 6)
                                        .padding(.top, 6)
                                    
                                    Text(point)
                                        .font(.system(size: 16))
                                        .foregroundColor(Color("Text"))
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.horizontal)
                    
                    // Practice button
                    Button(action: {
                        // Load exercises for this lesson
                        let exercises = exerciseViewModel.loadExercisesForLesson(lessonId: lesson.id)
                        if let firstExercise = exercises.first {
                            selectedExercise = firstExercise
                            showingExercise = true
                        }
                    }) {
                        Text("Continue to Practice")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("Primary"))
                            .cornerRadius(25)
                            .padding(.horizontal)
                    }
                    .padding(.vertical, 20)
                    
                    Spacer(minLength: 50)
                }
                .padding(.vertical)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                .padding()
            }
        }
        .background(Color("Background").edgesIgnoringSafeArea(.all))
        .navigationTitle(lesson.title)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingExercise) {
            if let exercise = selectedExercise {
                ExerciseView(exercise: exercise)
            }
        }
    }
    
    // Helper function to get formula based on tense
    func getFormula(for tenseTitle: String) -> String {
        if tenseTitle.contains("Present Simple") {
            return "Subject + base form (+ s/es for 3rd person singular)"
        } else if tenseTitle.contains("Present Continuous") {
            return "Subject + am/is/are + verb-ing"
        } else if tenseTitle.contains("Past Simple") {
            return "Subject + past form (verb + ed or irregular)"
        } else if tenseTitle.contains("Past Perfect") {
            return "Subject + had + past participle"
        } else {
            return "Formula depends on specific grammar rule"
        }
    }
    
    // Helper function to get usage points
    func getUsagePoints(for tenseTitle: String) -> [String] {
        if tenseTitle.contains("Present Simple") {
            return [
                "Habits and routines",
                "General truths and facts",
                "Fixed arrangements"
            ]
        } else if tenseTitle.contains("Present Continuous") {
            return [
                "Actions happening now",
                "Temporary situations",
                "Future arrangements"
            ]
        } else if tenseTitle.contains("Past Simple") {
            return [
                "Completed actions in the past",
                "Series of completed actions",
                "Past habits"
            ]
        } else if tenseTitle.contains("Past Perfect") {
            return [
                "Actions completed before another past action",
                "Experiences that happened before a specific time in the past"
            ]
        } else if tenseTitle.contains("Prepositions of Place") {
            return [
                "Describing the position or location of something",
                "Showing spatial relationships between objects"
            ]
        } else {
            return ["Specific usage depends on the grammar rule"]
        }
    }
}