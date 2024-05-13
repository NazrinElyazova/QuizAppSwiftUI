//
//  Repository.swift
//  QuizAppSwiftUI
//
//  Created by Nazrin on 13.05.24.
//

import Foundation

final class Repository {
    
    private let network = NetworkAPI()
    private var queuedStats: Set<StatQuestion> = []
    
    // MARK: - Local
    
    func saveAnswer(_ answer: StatQuestion) {
        queuedStats.insert(answer)
    }
    
    // MARK: - Network
    
    func retrieveNewQuestion(level: QuestionLevel) async throws -> [Question] {
        try await syncAnswers()
        return try await network.retrieveNewQuestion(level: level.rawValue)
    }
    
    func retrieveStats() async throws -> Stats {
        try await syncAnswers()
        return try await network.retrieveStats()
    }
    
    func syncAnswers() async throws {
        try await network.syncAnswers(queuedStats)
        queuedStats = []
    }
}

