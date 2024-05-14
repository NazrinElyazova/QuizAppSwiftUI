//
//  QuizStartView.swift
//  QuizAppSwiftUI
//
//  Created by Nazrin on 13.05.24.
//

import SwiftUI

struct QuizStartView: View {
    @StateObject var model = QuizViewModel()
    @State private var level: QuestionLevel = .beginner
    @State private var path: [Question] = []
    
    @Binding var logout: Bool?
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack {
                    Spacer()
                    
                    Picker("", selection: $level) {
                        ForEach(QuestionLevel.allCases, id: \.self) {
                            Text("\($0.text)")
                        }
                    }
                    
                    Button("Start Quiz", systemImage: "playstation.logo") {
                        Task {
                            do {
                                try await model.retrieveQuestions(level: level)
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button("Logout", systemImage: "xbox.logo") {
                      logout = true
                    }
                }
                if model.isLoading {
                    ProgressView()
                }
            }
            .navigationDestination(for: Question.self) { _ in
                QuizView(model: model)
            }
        }
        .onChange(of: model.question) { oldValue, newValue in
            if let newValue {
                path.append(newValue)
            }
            else {
                path = []
            }
        }
    }
}

#Preview {
    QuizStartView(logout: .constant(false))
}
