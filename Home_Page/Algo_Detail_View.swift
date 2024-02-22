//
//  Algo_Detail_View.swift
//  TheGraphOracle
//
//  Created by Smit Patel on 22/02/24.
//

import SwiftUI

struct Algo_Detail_View: View {
    @EnvironmentObject var model: CarouselViewModel
    var animation: Namespace.ID

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("Monday 28 December")
                    .font(.caption)
                    .foregroundColor(Color.white.opacity(0.85))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.top, 10)
                    .matchedGeometryEffect(id: "Date-\(model.selectedCard.id)", in: animation)

                HStack {
                    Spacer()
                    Text(model.selectedCard.title)
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 500, alignment: .center)
                        .padding()
                        .matchedGeometryEffect(id: "Title-\(model.selectedCard.id)", in: animation)

                    Spacer()
                }

                // Detail text content
                // Show content some delay for better animation
                
                if model.showContent 
                {
                    Text(model.selectedCard.description)
                        .fontWeight(.semibold)
                        .font(.system(size: 35))
                        .foregroundColor(.white)
                        .padding()
                }

                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                model.selectedCard.cardColor
                    .cornerRadius(25)
                    .matchedGeometryEffect(id: "bgColor-\(model.selectedCard.id)", in: animation)
                    .ignoresSafeArea(.all, edges: .bottom)
            )

            // Close button
            VStack {
                Spacer()

                if model.showContent {
                    Button(action: closeView, label: {
                        Image(systemName: "arrow.down")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.white.opacity(0.6))
                            .clipShape(Circle())
                            .padding(5)
                            .background(Color.white.opacity(0.7))
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    })
                    .padding(.bottom)
                }
            }
        }
    }

    func closeView() {
        withAnimation(.spring()) {
            model.showCard.toggle()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeIn) {
                    model.showContent = false
                }
            }
        }
    }
}
