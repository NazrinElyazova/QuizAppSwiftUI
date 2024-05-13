//
//  Question.swift
//  QuizAppSwiftUI
//
//  Created by Nazrin on 13.05.24.
//

import Foundation

struct Question: Equatable, Hashable {
    let id: String
    let level: QuestionLevel
    let text: String?
    let imageURL: URL?
    let answers: [String]
    let correctAnswerIndex: Int
    let explanation: String?
}

