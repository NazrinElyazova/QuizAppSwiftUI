//
//  QuizView.swift
//  QuizAppSwiftUI
//
//  Created by Nazrin on 13.05.24.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject var model: QuizViewModel
    @Environment(\.scenePhase) var scenePhase
    @State private var isCorrect: Bool?
    @State private var selectedIndex: Int?
    @State private var explanationPresented = false


    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                if let question = model.question {
                    Text(question.text ?? "")
                                            .padding()
                                            .multilineTextAlignment(.leading)
                    
                    // MARK: SCROLL VIEW
                    ScrollView(.vertical) {
                        ForEach(0..<question.answers.count, id: \.self) {
                            index in
                            
                            VStack {
                                Text(question.answers[index])
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                Rectangle()
                                    .fill(itemsColor(index: index))
                                    .cornerRadius(8.0)
                            )
                            .onTapGesture {
                                if selectedIndex == nil {
                                    isCorrect = model.set(answerIndex: index)
                                    selectedIndex = index
                                }
                            }
                        }
                    }
                    .padding()
                }
                Spacer()
                HStack {
                    Button("Quit",systemImage: "") {
                        model.quit()
                    }
                    
                    if selectedIndex != nil {
                        if model.question?.explanation != nil {
                            
                            Button("Explain",systemImage: "") {
                                // MARK: SHOW PRESENT SHEET
                                explanationPresented = true
                            }
                        }
                            Button("Next",systemImage: "") {
                                Task {
                                    isCorrect = nil
                                    selectedIndex = nil
                                    try? await model.getNextQuestion()
                                }
                            }
                        }
                    
                    if selectedIndex == nil {
                        Button("Skip",systemImage: "") {
                            Task {
                                try? await model.getNextQuestion()
                            }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $explanationPresented, content: {
            Text("\(model.question!.explanation ?? "")")
        })
        .foregroundStyle(.white)
        .onChange(of: scenePhase) {
            oldValue, newValue in
            if newValue == .background {
                model.syncAnswers()
            }
        }
    }
    private func itemsColor(index: Int) -> Color {
        if selectedIndex == nil {
            return Color.gray
        }
        if index == model.question?.correctAnswerIndex {
            return Color.green
        }
        if index == selectedIndex {
            return Color.red
        }
        return Color.gray
    }
}

#Preview {
    QuizView(model: QuizViewModel())
}
