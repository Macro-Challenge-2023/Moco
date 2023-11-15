//
//  PromptModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData

enum PromptType: String, Codable {
    case puzzle
    case findHoney
    case objectDetection
    case speech
    case multipleChoice
    case maze
    case ar
    case card
}

@Model
final class PromptModel: Identifiable {
    @Attribute var uid: String = ""
    @Attribute var startTime: Double = 0.0
    @Attribute var promptType = PromptType.maze
    @Attribute var correctAnswer = ""
    @Attribute var question: String? = ""
    @Attribute var imageCard: String? = ""
    @Attribute var answerChoices: [String]? = []
    @Attribute var answerAssets: [String]? = []
    @Attribute var createdAt = Date()
    @Attribute var updatedAt = Date()
// __main__
    var story: StoryModel? = nil
    var hints: [HintModel]?

    init(correctAnswer: String,
         startTime: Double,
         promptType: PromptType,
         hints: [HintModel]?,
         question: String? = "",
         imageCard: String? = "",
         answerChoices: [String]? = [],
         answerAssets: [String]? = []) {
        uid = UUID().uuidString
        self.startTime = startTime
        self.promptType = promptType
        self.correctAnswer = correctAnswer
        self.hints = hints ?? []
        self.question = question
        self.imageCard = imageCard
        self.answerChoices = answerChoices
        self.answerAssets = answerAssets
        createdAt = Date()
        updatedAt = Date()
    }
}
