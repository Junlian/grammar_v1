import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var currentPage = 0
    @State private var name = ""
    @State private var email = ""
    @State private var selectedLevel: ProficiencyLevel = .beginner
    @State private var selectedGoal: LearningGoal = .general
    
    var body: some View {
        VStack {
            // Progress indicator
            HStack {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(currentPage >= index ? Color("Primary") : Color.gray.opacity(0.3))
                        .frame(width: 10, height: 10)
                }
            }
            .padding(.top, 20)
            
            // Page content
            TabView(selection: $currentPage) {
                // Welcome page
                welcomeView
                    .tag(0)
                
                // User info page
                userInfoView
                    .tag(1)
                
                // Learning preferences page
                learningPreferencesView
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            // Navigation buttons
            HStack {
                if currentPage > 0 {
                    Button(action: {
                        withAnimation {
                            currentPage -= 1
                        }
                    }) {
                        Text("Back")
                            .foregroundColor(Color("Primary"))
                            .padding()
                    }
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        if currentPage < 2 {
                            currentPage += 1
                        } else {
                            completeOnboarding()
                        }
                    }
                }) {
                    Text(currentPage == 2 ? "Get Started" : "Next")
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 15)
                        .background(Color("Primary"))
                        .cornerRadius(25)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
        .background(Color("Background").edgesIgnoringSafeArea(.all))
    }
    
    // Welcome page
    var welcomeView: some View {
        VStack(spacing: 30) {
            Image("onboarding_illustration")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
            
            Text("Master English Grammar")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color("Text"))
            
            Text("Learn and practice English grammar rules through interactive lessons and exercises")
                .font(.system(size: 16))
                .foregroundColor(Color("SecondaryText"))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding(.top, 50)
    }
    
    // User info page
    var userInfoView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Tell us about yourself")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color("Text"))
                .padding(.bottom, 20)
            
            Text("Name")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color("Text"))
            
            TextField("Your name", text: $name)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("Border"), lineWidth: 1)
                )
            
            Text("Email")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color("Text"))
            
            TextField("Your email", text: $email)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("Border"), lineWidth: 1)
                )
                .keyboardType(.emailAddress)
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.top, 30)
    }
    
    // Learning preferences page
    var learningPreferencesView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Your learning preferences")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color("Text"))
                .padding(.bottom, 20)
            
            Text("Proficiency Level")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color("Text"))
            
            VStack(spacing: 10) {
                ForEach(ProficiencyLevel.allCases, id: \.self) { level in
                    Button(action: {
                        selectedLevel = level
                    }) {
                        HStack {
                            Text(level.rawValue)
                                .foregroundColor(Color("Text"))
                            
                            Spacer()
                            
                            if selectedLevel == level {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color("Primary"))
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedLevel == level ? Color("Primary") : Color("Border"), lineWidth: 1)
                        )
                    }
                }
            }
            
            Text("Learning Goal")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color("Text"))
                .padding(.top, 10)
            
            VStack(spacing: 10) {
                ForEach(LearningGoal.allCases, id: \.self) { goal in
                    Button(action: {
                        selectedGoal = goal
                    }) {
                        HStack {
                            Text(goal.rawValue)
                                .foregroundColor(Color("Text"))
                            
                            Spacer()
                            
                            if selectedGoal == goal {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color("Primary"))
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedGoal == goal ? Color("Primary") : Color("Border"), lineWidth: 1)
                        )
                    }
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.top, 30)
    }
    
    // Complete onboarding and create user
    func completeOnboarding() {
        // In a real app, this would create a user account
        // For prototype, we'll just update the current user
        let user = User(
            name: name.isEmpty ? "Sarah Johnson" : name,
            email: email.isEmpty ? "sarah.j@example.com" : email,
            profileImageName: "profile_default",
            level: selectedLevel,
            learningGoal: selectedGoal,
            dailyGoalMinutes: 20,
            streakDays: 0
        )
        
        userViewModel.currentUser = user
        userViewModel.isLoggedIn = true
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(UserViewModel())
    }
}