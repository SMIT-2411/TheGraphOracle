//
//  Bar.swift
//  TheGraphOracle
//
//  Created by Smit Patel on 21/02/24.
//

import Foundation
import SwiftUI
import Combine

struct TopBar: View {
    var text: String
    var body: some View {
                RoundedRectangle(cornerRadius: 30)
            .fill(Color("coffee"))
                    .overlay {
                        Text(text)
                            .foregroundColor(Color("cream"))
                            .font(.title)
                            .fontWeight(.semibold)
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
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color("cream"))
                
            HStack {
                Spacer()
                BottomBarButton(image: Image("list1"), text: "Select algorithm") {
                    withAnimation {
                        graphModel.showAlgorithmsList()
                    }
                }.padding(.trailing)
                Spacer()
                
                BottomBarButton(image: Image("play"),
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

#Preview{
    SelectAlgorithmAndRunBar(graphModel: GraphAlgoModel())
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
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color("cream"))
               
            
            HStack {
                Spacer()
                BottomBarButton(image: Image("stop"), text: "Stop") {
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
                secButtonImage = Image("pause")
                secButtonText = "Pause"
            default:
                secButtonImage = Image("play")
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
            VStack {
                image.resizable()
                    .frame(width:60 , height:60)
                    .font(.title)
                    .foregroundColor(disabled ? .gray : .black)
                    
                Text(text)
                    .foregroundColor(disabled ? .gray : .black)
                    .font(.title)
                    .fontWeight(.semibold)
            }
        }
    }
}


struct BottomBar: View {
    @ObservedObject var graphModel: GraphAlgoModel
    
    private let w = UIScreen.main.bounds.width * 415/750
    private let h = UIScreen.main.bounds.width * 70/1200
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .fill(Color("cream"))
                
                
            
            HStack {
                Spacer()
                
                BottomBarButton(image: Image("reset"), text: "Reset") {
                    withAnimation { graphModel.clearButtonTapped() }
                }.padding(.trailing)
                    .padding(.leading , 35)
                
                Spacer()
                Spacer()
                
                BottomBarButton(image: Image("random"), text: "Randomly") {
                    withAnimation { graphModel.randomButtonTapped() }
                }.padding(.leading , 17)
                
                Spacer()
            }
        }
        .frame(height: h)
        .frame(maxWidth: w)
    }
}



