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

struct AlertPopUpView: View {
    @ObservedObject var graphModel: GraphAlgoModel
    @Binding var showPopupAgain: Bool
    
    @State private var currHeight : CGFloat = 500
    let minHeight : CGFloat = 500
    let maxHeight : CGFloat = 700
    
    var body: some View {
        
        ZStack(alignment: .bottom){
        if showPopupAgain{
            
            
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        graphModel.showGenericInstructionPopup = false
                        showPopupAgain = false
                    }
                
                secondaryView
                .transition(.move(edge: .bottom))
            }
            
        }.frame(maxWidth: .infinity , maxHeight: .infinity , alignment: .bottom)
            .ignoresSafeArea()
            .animation(.easeInOut)
    }
    
    var secondaryView: some View {
        VStack{
            ZStack{
                Capsule()
                    .frame(width: 100 , height: 15)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001))
            .gesture(dragGesture)
            
            ZStack{
                VStack{
                    Text("Instruction: Organizing Your Graph")
                        .foregroundColor(.black)
                        .bold()
                        .font(.title)
                    
                    
                    Text("1. Attention to Detail:")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 50)
                        .padding(.top , 30)
                    
                    Text("Attention to Detail: Building a clear and understandable graph requires careful organization. Pay attention to the total number of nodes and edges, as well as potential intersections. Messy layouts can make visualization difficult.")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding()
                        
                    Text("2.Node Management:")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 80)
                        .padding(.vertical)
                    
                    Text("> Tap on any node to remove it from the graph temporarily.")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                       
                        
                    Text("> Tap again on a removed node to add it back to the graph.")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .font(.title3)
                        .multilineTextAlignment(.leading)
                       
                        
                    
                }
                .padding(.horizontal,30)
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom , 30)
        }
        .frame(height:currHeight)
        .frame(maxWidth:.infinity)
        .background(
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                Rectangle()
                    .frame(height: currHeight / 2)
                
            }
                .foregroundColor(.white)
        )
        
    }
    
    @State private var prevDragTranslation = CGSize.zero
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0 , coordinateSpace: .global)
            .onChanged { val in
                let dragAmount = val.translation.height - prevDragTranslation.height
                
                if currHeight > maxHeight || currHeight < minHeight{
                    currHeight -= dragAmount / 6
                }
                else
                {
                    currHeight -= dragAmount
                }
                prevDragTranslation = val.translation
                
            }.onEnded { val in
                prevDragTranslation = .zero
                
            }
    }
}



