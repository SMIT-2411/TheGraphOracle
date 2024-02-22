//
//  Algo_Picker.swift
//  TheGraphOracle
//
//  Created by Smit Patel on 21/02/24.
//

import SwiftUI

struct AlgoPicker: View {
    @ObservedObject var graphModel: GraphAlgoModel
    private let list = Algorithm.allCases
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blackGray)
                .blur(radius: 10)
            
            VStack {
                Spacer()
                Text("Select algorithm")
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                
                ForEach(list) { alg in
                    HStack {
                        Button(action: {
                            withAnimation {
                                graphModel.selectedAlgorithmForExplanation = alg
                                graphModel.showAlgorithmExplanationBox = true
                            }
                        }) {
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(.white)
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        
                        Button(action: {
                            withAnimation {
                                graphModel.selectAlgorithm(alg)
                            }
                        }) {
                            Text(alg.id)
                                .fontWeight(.semibold)
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                        }
                    }
                }
                Spacer()
            }
        }
        .frame(height: UIScreen.main.bounds.width * 0.35)
        .frame(maxWidth: UIScreen.main.bounds.width * 0.86)
    }
}

