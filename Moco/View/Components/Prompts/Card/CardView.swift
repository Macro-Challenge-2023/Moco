//
//  CardView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 13/11/23.
//

import SwiftUI

struct CardView: View {
    var state = CardState.inactive
    var revealedImage = ""
    var text = ""
    var suffix = ""
    var type = CardType.character

    var onTap: (() -> Void)?

    func getWidth() -> CGFloat{
        switch type {
        case .character:
            return Screen.width * 0.25
        case .verb, .noun:
            return Screen.width * 0.12
        }
    }

    func getHeight() -> CGFloat{
        switch type {
        case .character:
            return 0.4 * Screen.height
        case .verb, .noun:
            return 0.2 * Screen.height
        }
    }

    func getActiveCard() -> String{
        switch type {
        case .character:
            return "Story/Prompts/card-active"
        case .verb:
            return "Story/Prompts/card-verb"
        case .noun:
            return "Story/Prompts/card-noun"
        }
    }

    var body: some View {
        VStack {
            switch state {
            case .active:
                VStack {
                    Image(getActiveCard())
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            onTap?()
                        }
//                    Text(String(repeating: "_", count: text.count) + suffix)
//                        .customFont(.didactGothic, size: 40)
                }
            case .inactive:
                Image("Story/Prompts/card-inactive")
                    .resizable()
                    .scaledToFit()
//                Text(String(repeating: "_", count: text.count) + suffix)
//                    .customFont(.didactGothic, size: 40)
            case .revealed:
                Image(revealedImage)
                    .resizable()
                    .scaledToFit()
//                Text(text + suffix)
//                    .customFont(.didactGothic, size: 40)
            }
        }
        .frame(
            width: getWidth(),
            height: getHeight()
        )
    }
}

#Preview {
    CardView()
}
