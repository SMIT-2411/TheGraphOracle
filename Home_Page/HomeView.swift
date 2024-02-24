//
//  HomeView.swift
//  TheGraphOracle
//
//  Created by Smit Patel on 17/02/24.
//


import SwiftUI

var width = UIScreen.main.bounds.width

struct HomeView: View {
   
    @Binding var currentPage: Page
    @EnvironmentObject var homeModel: CarouselViewModel
    @Namespace var animation

    var body: some View {
        ZStack {
            Color("cream").ignoresSafeArea()
            VStack {
                HStack {
                    Button(action: {
                        self.currentPage = .welcomePage
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 30))
                            .foregroundColor(.black)
                            .padding(.leading)
                    })

                    Text("Graph Algorithm's")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.leading)

                    Spacer()

                }
                .padding(.top)
                
               
                
                Spacer()

                // Carousel
                ZStack {
                    ForEach(homeModel.cards.indices.reversed(), id: \.self) { index in
                        HStack {
                            Algo_Card_View(card: homeModel.cards[index], animation: animation)
                                .frame(
                                    width: getCardWidth(index: index),
                                    height: getCardHeight(index: index)
                                )
                                .offset(x: getCardOffset(index: index))
                                .rotationEffect(.init(degrees: getCardRotation(index: index)))

                            Spacer(minLength: 0)
                        }
                        .frame(height: 800)
                        .contentShape(Rectangle())
                        .offset(x: homeModel.cards[index].offset)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ value in
                                    onChanged(value: value, index: index)
                                })
                                .onEnded({ value in
                                    onEnd(value: value, index: index)
                                })
                        )
                    }
                }
                .padding(.top, 25)
                .padding(.horizontal, 30)

                Button(action: resetViews, label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                })
                .padding(.top, 35)

                Spacer()
            }

            // Detail view
            if homeModel.showCard {
                Algo_Detail_View(currentPage: .constant(.homePage), animation: animation)
            }
        }
    }

    // Rest views
    func resetViews() {
        for index in homeModel.cards.indices {
            withAnimation(.spring()) {
                homeModel.cards[index].offset = 0
                homeModel.swipedCard = 0
            }
        }
    }

    func onChanged(value: DragGesture.Value, index: Int) {
        // Only left swipe
        if value.translation.width < 0 {
            homeModel.cards[index].offset = value.translation.width
        }
    }

    func onEnd(value: DragGesture.Value, index: Int) {
        withAnimation {
            if -value.translation.width > width / 3 {
                homeModel.cards[index].offset = -width
                homeModel.swipedCard += 1
            } else {
                homeModel.cards[index].offset = 0
            }
        }
    }

    // Get rotation when card is being swiped
    func getCardRotation(index: Int) -> Double {
        let boxWidth = Double(width / 3)

        let offset = Double(homeModel.cards[index].offset)

        let angle: Double = 5

        return (offset / boxWidth) * angle
    }

    // Get width and height for card
    func getCardHeight(index: Int) -> CGFloat {
        let height: CGFloat = 400
        let cardHeight = index - homeModel.swipedCard <= 2 ? CGFloat(index - homeModel.swipedCard) * 35: 70
        return height - cardHeight
    }

    func getCardWidth(index: Int) -> CGFloat {
        let boxWidth = UIScreen.main.bounds.width - 60 - 60

        // For first three cards
        //let cardWidth = index <= 2 ? CGFloat(index) * 30 : 60
        return boxWidth
    }

    // Get offset
    func getCardOffset(index: Int) -> CGFloat {
        return index - homeModel.swipedCard <= 2 ? CGFloat(index - homeModel.swipedCard) * 30 : 60
    }
}


