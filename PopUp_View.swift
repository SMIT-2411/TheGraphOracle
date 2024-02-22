//
//  PopUp_View.swift
//  TheGraphOracle
//
//  Created by Smit Patel on 21/02/24.
//

import SwiftUI

struct AlertView: View {
    @ObservedObject var graphModel: GraphAlgoModel
    
    var body: some View {
        Rectangle()
            .fill(Color.blackGray)
            .blur(radius: 10)
            .overlay {
                VStack {
                    Text(graphModel.alertText)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: {
                        withAnimation { graphModel.hideAlert() }
                    }) {
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundColor(.clear)
                            .border(Color.white)
                            .frame(width: 100, height: 50)
                            .overlay {
                                Text("Ok")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .padding()
                            }
                    }
                }
            }
    }
}

struct ExplanationBoxView: View {
    @ObservedObject var graphModel: GraphAlgoModel
    let explanationBoxWidth = UIScreen.main.bounds.width * 0.85
    let explanationBoxHeight = UIScreen.main.bounds.height * 0.45
    let algorithm: Algorithm
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blackGray)
                .blur(radius: 10)
                .frame(width: explanationBoxWidth,
                       height: explanationBoxHeight)
            
            VStack {
                Spacer()
                Text(algorithm.rawValue)
                    .foregroundColor(.white)
                    .bold()
                    .font(.title)
                
                Text(GraphAlgoExplanation.getAlgorithmExplanationText(for: algorithm))
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 80)
                    .padding(.vertical)
                
                Button(action: {
                    withAnimation {
                        graphModel.showAlgorithmExplanationBox = false
                    }
                } ) {
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(.clear)
                        .border(Color.white)
                        .frame(width: 100, height: 50)
                        .padding()
                        .overlay {
                            Text("Ok")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .padding()
                        }
                }
                
                Spacer()
            } // VStack
        }
    }
}


struct GenericInstructionView: View {
    @ObservedObject var graphModel: GraphAlgoModel
    @Binding var showPopupAgain: Bool
    
    var body: some View {
        Rectangle()
            .fill(Color.blackGray)
            .blur(radius: 10)
            .frame(maxWidth: UIScreen.main.bounds.width * 0.75,
                   maxHeight: UIScreen.main.bounds.height * 0.3)
            .overlay {
                VStack {
                    Text("Attention!")
                        .foregroundColor(.white)
                        .bold()
                        .font(.title)
                    
                    Text("To build a nice graph, care about its organization, i.e., the total number of nodes/edges and edges intersections. If it is too messy, you will have a hard visualization.")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 80)
                        .padding(.vertical)
                    
                    Button(action: {
                        withAnimation {
                            graphModel.showGenericInstructionPopup = false
                            showPopupAgain = false
                        }
                    } ) {
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundColor(.clear)
                            .border(Color.white)
                            .frame(width: 200, height: 50)
                            .padding()
                            .overlay {
                                Text("I understand")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .padding()
                            }
                    }
                }
            }
    }
}

