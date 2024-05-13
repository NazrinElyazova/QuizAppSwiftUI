//
//  QuestionLevel.swift
//  QuizAppSwiftUI
//
//  Created by Nazrin on 13.05.24.
//

import Foundation

enum QuestionLevel: Int, CaseIterable {
    case beginner
    case intermediate
    case advanced
    case random
    
    var text: String {
        switch self {
            
        case .beginner:
            return "Beginner"
            
        case .intermediate:
            return "Intermediate"

        case .advanced:
            return "Advanced"
            
        case .random:
            return "Random"
        }
    }
}
