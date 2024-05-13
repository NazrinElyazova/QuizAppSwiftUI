//
//  QuizView.swift
//  QuizAppSwiftUI
//
//  Created by Nazrin on 13.05.24.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject var model: QuizViewModel
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                if let question = model.question {
                    
                }
            }
        }
    }
}

#Preview {
    QuizView(model: QuizViewModel())
}
