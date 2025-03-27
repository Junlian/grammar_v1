import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Profile header
                VStack(spacing: 15) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(Color("Primary"))
                    
                    if let user = userViewModel.currentUser {
                        Text(user.name)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color("Text"))
                        
                        Text(user.email)
                            .font(.system(size: 16))
                            .foregroundColor(Color("SecondaryText"))
                    }
                }
                .padding()
                
                // Stats section
                HStack(spacing: 20) {
                    // Streak
                    VStack {
                        Text("\(userViewModel.currentUser?.streakDays ?? 0)")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color("Text"))
                        Text("Day Streak")
                            .font(.system(size: 14))
                            .foregroundColor(Color("SecondaryText"))
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    
                    // Level
                    VStack {
                        Text(userViewModel.currentUser?.level.rawValue ?? "Beginner")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color("Text"))
                        Text("Level")
                            .font(.system(size: 14))
                            .foregroundColor(Color("SecondaryText"))
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                }
                .padding(.horizontal)
                
                // Settings section
                VStack(alignment: .leading, spacing: 5) {
                    Text("Settings")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color("Text"))
                        .padding(.horizontal)
                    
                    VStack(spacing: 0) {
                        // Daily goal setting
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "clock")
                                    .foregroundColor(Color("Primary"))
                                Text("Daily Goal")
                                    .foregroundColor(Color("Text"))
                                Spacer()
                                Text("\(userViewModel.currentUser?.dailyGoalMinutes ?? 20) min")
                                    .foregroundColor(Color("SecondaryText"))
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color("SecondaryText"))
                            }
                            .padding()
                        }
                        Divider()
                        
                        // Learning goal setting
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "target")
                                    .foregroundColor(Color("Primary"))
                                Text("Learning Goal")
                                    .foregroundColor(Color("Text"))
                                Spacer()
                                Text(userViewModel.currentUser?.learningGoal.rawValue ?? "General")
                                    .foregroundColor(Color("SecondaryText"))
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color("SecondaryText"))
                            }
                            .padding()
                        }
                        Divider()
                        
                        // Notifications setting
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "bell")
                                    .foregroundColor(Color("Primary"))
                                Text("Notifications")
                                    .foregroundColor(Color("Text"))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color("SecondaryText"))
                            }
                            .padding()
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    .padding(.horizontal)
                }
                
                // Account section
                VStack(alignment: .leading, spacing: 5) {
                    Text("Account")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color("Text"))
                        .padding(.horizontal)
                    
                    VStack(spacing: 0) {
                        // Edit profile
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "person")
                                    .foregroundColor(Color("Primary"))
                                Text("Edit Profile")
                                    .foregroundColor(Color("Text"))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color("SecondaryText"))
                            }
                            .padding()
                        }
                        Divider()
                        
                        // Help center
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "questionmark.circle")
                                    .foregroundColor(Color("Primary"))
                                Text("Help Center")
                                    .foregroundColor(Color("Text"))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color("SecondaryText"))
                            }
                            .padding()
                        }
                        Divider()
                        
                        // Logout
                        Button(action: {
                            userViewModel.logout()
                        }) {
                            HStack {
                                Image(systemName: "arrow.right.square")
                                    .foregroundColor(.red)
                                Text("Logout")
                                    .foregroundColor(.red)
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding(.vertical)
        }
        .background(Color("Background").edgesIgnoringSafeArea(.all))
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
                .environmentObject(UserViewModel())
        }
    }
}