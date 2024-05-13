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
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack {
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
        }
    }
}

#Preview {
    QuizStartView()
}
