//
//  NetworkAPI.swift
//  QuizAppSwiftUI
//
//  Created by Nazrin on 13.05.24.
//

import Foundation

final class NetworkAPI {
    
    func retrieveNewQuestion(level: Int) async throws -> [Question] {
        //MARK: - BIR SANIYE GOZLEYECEK
        try await Task.sleep(nanoseconds: NSEC_PER_SEC * 1)
        return Question.generate()
    }
    
    func retrieveStats() async throws -> Stats {
        try await Task.sleep(nanoseconds: NSEC_PER_SEC * 1)
        return Stats(correctMap: [:], wrongMap: [:])
    }
    
    func syncAnswers(_ answers: Set<StatQuestion>) async throws {
        try await Task.sleep(nanoseconds: NSEC_PER_SEC * 1)
        //sync
    }
}
