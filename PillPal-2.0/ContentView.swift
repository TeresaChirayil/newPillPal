//
//  ContentView.swift
//  PillPal-2.0
//
//  Created by 47GOParticipant on 7/9/25.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Color
                Color(red: 122/255, green: 198/255, blue: 227/255)
                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    Text("PillPal")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                    
                    VStack(spacing: 20) {
                        NavigationLink(destination: LoginView()) {
                            Text("Log in")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal, 40)

                        NavigationLink(destination: SignUpView()) {
                            Text("Sign up")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal, 40)
                    }
                }
            }
        }
    }
}

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Log In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                VStack(alignment: .leading, spacing: 15) {
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                .padding(.horizontal, 40)
                
                Button(action: {
                    // Log in action
                    print("Email: \(email)")
                    print("Password: \(password)")
                }) {
                    Text("Log in")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 40)
            }
        }
    }
}

struct SignUpView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    
    @State private var navigateToLogin = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    Text("Sign Up")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        TextField("First Name", text: $firstName)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        
                        TextField("Last Name", text: $lastName)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        
                        DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        
                        TextField("Email", text: $email)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        
                        TextField("Phone Number", text: $phoneNumber)
                            .keyboardType(.phonePad)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 40)
                    
                    Button(action: {
                        // Do sign up logic here
                        print("First Name: \(firstName)")
                        print("Last Name: \(lastName)")
                        print("Date of Birth: \(dateOfBirth)")
                        print("Email: \(email)")
                        print("Phone Number: \(phoneNumber)")
                        
                        // Navigate to Login screen
                        navigateToLogin = true
                    }) {
                        Text("Sign up")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 40)
                    
                    // Hidden NavigationLink
                    .navigationDestination(isPresented: $navigateToLogin) {
                                    LoginView()
                                }

                }
            }
        }
    }
}

#Preview {
    ContentView()
}
