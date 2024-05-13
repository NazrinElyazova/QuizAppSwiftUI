//
//  StatQuestion.swift
//  QuizAppSwiftUI
//
//  Created by Nazrin on 13.05.24.
//

import Foundation

struct StatQuestion: Hashable {
    let questionId: String
    let level: QuestionLevel
    let isCorrect: Bool
    
    //MARK: EYNI QUESTION ID STATQUESTIONA ELAVE EDILE BILMEYECEK
    
    static func == (lhs: StatQuestion, rhs: StatQuestion) -> Bool {
        lhs.questionId == rhs.questionId
    }
}
