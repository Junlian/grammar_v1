import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @StateObject var lessonViewModel = LessonViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // User greeting and profile
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Welcome back,")
                                .font(.system(size: 14))
                                .foregroundColor(Color("SecondaryText"))
                            
                            if let user = userViewModel.currentUser {
                                Text(user.name)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color("Text"))
                            }
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(Color("Primary"))
                        }
                    }
                    .padding(.horizontal)
                    
                    // Streak card
                    HStack {
                        // Streak icon
                        ZStack {
                            Circle()
                                .fill(Color("Primary"))
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: "flame.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("\(userViewModel.currentUser?.streakDays ?? 0) Day Streak!")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color("Text"))
                            
                            Text("Keep up the great work")
                                .font(.system(size: 14))
                                .foregroundColor(Color("SecondaryText"))
                        }
                        .padding(.leading, 10)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    .padding(.horizontal)
                    
                    // Daily goal
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Today's Goal")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color("Text"))
                        
                        // Progress bar
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .fill(Color("Border"))
                                    .frame(width: geometry.size.width, height: 20)
                                    .cornerRadius(10)
                                
                                Rectangle()
                                    .fill(Color("Primary"))
                                    .frame(width: geometry.size.width * CGFloat(userViewModel.dailyGoalProgress), height: 20)
                                    .cornerRadius(10)
                            }
                        }
                        .frame(height: 20)
                        
                        Text("\(Int(userViewModel.dailyGoalProgress * 100))% Complete")
                            .font(.system(size: 14))
                            .foregroundColor(Color("SecondaryText"))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    .padding(.horizontal)
                    
                    // Continue learning section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Continue Learning")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color("Text"))
                            .padding(.horizontal)
                        
                        if lessonViewModel.isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                        } else if let lesson = lessonViewModel.lessons.first {
                            // Lesson card
                            VStack(alignment: .leading, spacing: 10) {
                                HStack(alignment: .top) {
                                    // Lesson icon
                                    ZStack {
                                        Rectangle()
                                            .fill(Color("Primary"))
                                            .frame(width: 50, height: 50)
                                            .cornerRadius(5)
                                        
                                        Text(String(lesson.title.prefix(1)))
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text(lesson.title)
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(Color("Text"))
                                        
                                        Text("Lesson \(lesson.order) of 5")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color("SecondaryText"))
                                    }
                                    .padding(.leading, 10)
                                    
                                    Spacer()
                                    
                                    // Continue button
                                    NavigationLink(destination: LessonDetailView(lesson: lesson)) {
                                        Text("Continue")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 10)
                                            .background(Color("Primary"))
                                            .cornerRadius(20)
                                    }
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                            .padding(.horizontal)
                        }
                    }
                    
                    // Recommended practice
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Recommended Practice")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color("Text"))
                            .padding(.horizontal)
                        
                        // Practice cards
                        ForEach(0..<2) { index in
                            HStack {
                                // Practice icon
                                ZStack {
                                    Circle()
                                        .fill(Color("Accent"))
                                        .frame(width: 50, height: 50)
                                    
                                    Image(systemName: index == 0 ? "pencil" : "map")
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(index == 0 ? "Verb Tenses Quiz" : "Prepositions Practice")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(Color("Text"))
                                    
                                    Text(index == 0 ? "10 questions • 5 min" : "8 questions • 4 min")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("SecondaryText"))
                                }
                                .padding(.leading, 10)
                                
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                            .padding(.horizontal)
                        }
                    }
                    
                    Spacer(minLength: 50)
                }
                .padding(.top)
            }
            .background(Color("Background").edgesIgnoringSafeArea(.all))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserViewModel())
    }
}