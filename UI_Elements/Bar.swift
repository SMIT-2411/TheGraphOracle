//
//  Bar.swift
//  TheGraphOracle
//
//  Created by Smit Patel on 21/02/24.
//

import Foundation
import SwiftUI
import Combine

struct Bar: View {
    var text: String
    var body: some View {
        Rectangle()
            .fill(Color.blackGray)
            .blur(radius: 10)
            .overlay {
                Text(text)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.title3)
                    .multilineTextAlignment(.center)
            }
    }
}

struct AlgorithmNameBar: View {
    var text: String
    private let w = UIScreen.main.bounds.width * 415/744
    private let h = UIScreen.main.bounds.width * 70/1133
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blackGray)
                .blur(radius: 10)
            
            Text(text)
                .foregroundColor(.white)
                .font(.title2)
                .fontWeight(.semibold)
        }
        .frame(height: h)
        .frame(maxWidth: w)
    }
}

struct SelectAlgorithmAndRunBar: View {
    @ObservedObject var graphModel: GraphAlgoModel
    
    private let w = UIScreen.main.bounds.width * 415/744
    private let h = UIScreen.main.bounds.width * 70/1133
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blackGray)
                .blur(radius: 10)
            
            HStack {
                Spacer()
                BottomBarButton(image: Image(systemName: "arrow.uturn.up"), text: "Select algorithm") {
                    withAnimation {
                        graphModel.showAlgorithmsList()
                    }
                }.padding(.trailing)
                Spacer()
                
                BottomBarButton(image: Image(systemName: "play.fill"),
                                text: "Run",
                                disabled: graphModel.selectedAlgorithm == nil) {
                    withAnimation { graphModel.runAlgorithm() }
                }.padding(.leading)
                Spacer()
            }
        }
        .frame(height: h)
        .frame(maxWidth: w)

    }
}





struct StopPauseResumeBar: View {
    @ObservedObject var graphModel: GraphAlgoModel
    @State private var secButtonImage: Image = Image(systemName: "pause.fill")
    @State private var secButtonText: String = "Pause"
    @State private var cancellables = Set<AnyCancellable>()
    
    private let w = UIScreen.main.bounds.width * 415/744
    private let h = UIScreen.main.bounds.width * 70/1133
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blackGray)
                .blur(radius: 10)
            
            HStack {
                Spacer()
                BottomBarButton(image: Image(systemName: "stop.fill"), text: "Stop") {
                    withAnimation { graphModel.stopAlgorithm() }
                }.padding(.trailing)
                Spacer()
                
                BottomBarButton(image: secButtonImage, text: secButtonText) {
                    withAnimation { graphModel.pauseResumeAlgorithm() }
                }.padding(.leading)
                Spacer()
            }
        }
        .frame(height: h)
        .frame(maxWidth: w)
        .onAppear {
            observeAlgorithmRunningStatus()
        }
    }
    
    private func observeAlgorithmRunningStatus() {
        graphModel.graph.$algorithmState.sink { state in
            switch state {
            case .running:
                secButtonImage = Image(systemName: "pause.fill")
                secButtonText = "Pause"
            default:
                secButtonImage = Image(systemName: "play.fill")
                secButtonText = "Resume"
            }
        }.store(in: &cancellables)
    }
}

struct BottomBarButton: View {
    var image: Image
    var text: String
    var disabled: Bool = false
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            if !disabled { self.action() }
        } ) {
            HStack {
                image
                    .foregroundColor(disabled ? .gray : .white)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(text)
                    .foregroundColor(disabled ? .gray : .white)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
        }
    }
}


struct ClearRandomBar: View {
    @ObservedObject var graphModel: GraphAlgoModel
    
    private let w = UIScreen.main.bounds.width * 415/744
    private let h = UIScreen.main.bounds.width * 70/1133
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blackGray)
                .blur(radius: 10)
            
            HStack {
                Spacer()
                BottomBarButton(image: Image(systemName: "x.circle"), text: "Clear") {
                    withAnimation { graphModel.clearButtonTapped() }
                }.padding(.trailing)
                Spacer()
                
                BottomBarButton(image: Image(systemName: "shuffle.circle"), text: "Random") {
                    withAnimation { graphModel.randomButtonTapped() }
                }.padding(.leading)
                Spacer()
            }
        }
        .frame(height: h)
        .frame(maxWidth: w)
    }
}

