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
        RoundedRectangle(cornerRadius: 25.0)
            .fill(Color("coffee"))
            .overlay {
                VStack {
                    Text(graphModel.alertText)
                        .foregroundColor(Color("cream"))
                        .fontWeight(.semibold)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: {
                        withAnimation { graphModel.hideAlert() }
                    }) {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.clear)
                            .border(Color.white)
                            .frame(width: 200, height: 50)
                            .overlay {
                                Text("Continue!")
                                    .foregroundColor(Color("darkOrange"))
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
                        graphModel.InstructionPopup = false
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
                        .foregroundColor(Color("cream"))
                        .bold()
                        .font(.title)
                    
                    
                    Text("1. Attention to Detail:")
                        .foregroundColor(Color("cream"))
                        .fontWeight(.bold)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 50)
                        .padding(.top , 30)
                    
                    Text("Attention to Detail: Building a clear and understandable graph requires careful organization. Pay attention to the total number of nodes and edges, as well as potential intersections. Messy layouts can make visualization difficult.")
                        .foregroundColor(Color("cream"))
                        .fontWeight(.semibold)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding()
                        
                    Text("2.Node Management:")
                        .foregroundColor(Color("cream"))
                        .fontWeight(.bold)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 80)
                        .padding(.vertical)
                    
                    Text("> Tap on any node to remove it from the graph temporarily.")
                        .foregroundColor(Color("cream"))
                        .fontWeight(.semibold)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                       
                        
                    Text("> Tap again on a removed node to add it back to the graph.")
                        .foregroundColor(Color("cream"))
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
                .foregroundColor(Color("coffee"))
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



