//
//  QuizViewModel.swift
//  QuizAppSwiftUI
//
//  Created by Nazrin on 13.05.24.
//

import Foundation

@MainActor
final class QuizViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var question: Question?
    
    private let repository = Repository()
    private var currentIndex = 0
    private var questions: [Question] = []
    private var level: QuestionLevel = .random
    
    func retrieveQuestions(level: QuestionLevel) async throws {
        self.level = level
        self.isLoading = true
        
        let newQuestion = try await repository.retrieveNewQuestion(level: level)
        questions.append(contentsOf: newQuestion)
        
        if questions.count > currentIndex {
            question = questions[currentIndex]
        } else {
            //error show
        }
        isLoading = false
        // MARK: - PAGINATION
    }
    
    func set(answerIndex: Int) -> Bool {
        if let question {
            let isCorrect = question.correctAnswerIndex == answerIndex
            repository.saveAnswer(StatQuestion(questionId: question.id,
                                               level: question.level,
                                               isCorrect: isCorrect))
            return isCorrect
        }
        return false
    }
    
    func getNextQuestion() async throws {
        currentIndex += 1
        if questions.count > currentIndex {
            question = questions[currentIndex]
        } else {
            try await retrieveQuestions(level: level)
        }
    }
    
    func quit() {
        level = .random
        questions = []
        question = nil
        currentIndex = 0
    }
}
