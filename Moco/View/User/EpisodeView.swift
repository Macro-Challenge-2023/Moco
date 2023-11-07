//
//  EpisodeView.swift
//  Moco
//
//  Created by Nur Azizah on 12/10/23.
//

import SwiftData
import SwiftUI

struct EpisodeView: View {
    @Environment(\.audioViewModel) private var audioViewModel
    @Environment(\.storyThemeViewModel) private var storyThemeViewModel
    @Environment(\.episodeViewModel) private var episodeViewModel
    @Environment(\.storyViewModel) private var storyViewModel
    @Environment(\.storyContentViewModel) private var storyContentViewModel
    @Environment(\.promptViewModel) private var promptViewModel
    @Environment(\.hintViewModel) private var hintViewModel
    @Environment(\.navigate) private var navigate

    var body: some View {
        ZStack {
            VStack {
                Image("Story/main-background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            }.frame(width: Screen.width, height: Screen.height)

            VStack {
                HStack(alignment: .center) {
                    Image("Story/nav-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 0.4 * Screen.width)
                        .padding(.top, 50)

                    Spacer()

                    BurgerMenu()
                }
                .padding(.horizontal, 0.05 * Screen.width)

                Spacer()

                HStack {
                    HStack(spacing: 40) {
                        Image("Buttons/button-home")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .shadow(radius: 4, x: -2, y: 2)
                            .foregroundColor(.white)
                            .onTapGesture {
                                navigate.pop()
                            }

                        Text("Pilih Episode")
                            .customFont(.cherryBomb, size: 50)
                            .foregroundColor(Color.blueTxt)
                            .fontWeight(.bold)
                    }

                    Spacer()
                }.padding(.leading, 60).padding(.bottom, 30)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.flexible())]) {
                        if let availableEpisodes = episodeViewModel.availableEpisodes {
                            ForEach(
                                Array(availableEpisodes.enumerated()), id: \.element
                            ) { index, episode in
                                StoryBookNew(
                                    image: episode.pictureName,
                                    firstPageBackground: episode.pictureName,
                                    number: index + 1
                                ) {
                                    Task {
                                        episodeViewModel.setSelectedEpisode(episode)

                                        // open new story page
                                        storyViewModel.fetchStory(0, episodeViewModel.selectedEpisode!)
                                        storyContentViewModel.fetchStoryContents(storyViewModel.storyPage!)

                                        if storyViewModel.storyPage!.isHavePrompt {
                                            promptViewModel.fetchPrompt(storyViewModel.storyPage!)

                                            if promptViewModel.prompt!.hints != nil {
                                                hintViewModel.fetchHints(promptViewModel.prompt!)
                                            }
                                        }

                                        navigate.append(.story)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                }.scrollClipDisabled()

                Spacer()
                Spacer()
            }
        }
        .task {
            episodeViewModel.fetchEpisodes(storyThemeId: storyThemeViewModel.selectedStoryTheme!.uid)
            if navigate.previousRoute == .story {
                audioViewModel.clearAll()
                audioViewModel.playSound(soundFileName: "bg-shop", numberOfLoops: -1, category: .backsound)
            }
        }
    }
}

#Preview {
    EpisodeView()
}
