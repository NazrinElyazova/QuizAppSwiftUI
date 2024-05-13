//
//  ModelsMock.swift
//  QuizAppSwiftUI
//
//  Created by Nazrin on 13.05.24.
//

import Foundation
import LoremSwiftum

extension Question {
    static func generate() -> [Question] {
        (0..<10).map { index in
            Question(id: UUID().uuidString,
                     level: .random(),
                     text: Lorem.paragraph,
                     imageURL: nil,
                     answers: [Lorem.sentence, Lorem.sentence, Lorem.sentence, Lorem.sentence],
                     correctAnswerIndex: 1,
                     explanation: nil)
        }
    }
}

extension QuestionLevel {
    static func random()-> QuestionLevel {
        QuestionLevel(rawValue: Int.random(in: 0...3))!
    }
}
