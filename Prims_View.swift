//
//  Prims_View.swift
//  TheGraphOracle
//
//  Created by Smit Patel on 25/02/24.
//

import SwiftUI

struct Prims_View: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var showPopupAgain: Bool
    @StateObject private var graphModel = GraphAlgoModel()
    
       
       var body: some View {
           ZStack {
               Color("cream").edgesIgnoringSafeArea(.all)
               
               // Graph
               ZStack {
                   // Edges and weights
                   ForEach(0..<graphModel.graph.nodes.count, id: \.self) { i in
                       let nodeEdges = graphModel.graph.edges[i].filter({$0.inTree})
                       
                       ForEach(0..<nodeEdges.count, id: \.self) { j in
                           let edge = nodeEdges[j]
                           
                           EdgeView(edge: edge)
                               .onTapGesture {
                                   withAnimation {
                                       graphModel.handleEdgeTap(edge)
                                   }
                               }
                           
                           if edge.weight != 0 {
                               let x = edge.weightPosition.x
                               let y = edge.weightPosition.y
                               
                               WeightCard(edge: edge)
                                   .position(x: x, y: y)
                                   .zIndex(1)
                                   .onTapGesture {
                                       withAnimation {
                                           graphModel.setRandomWeightOn(edge)
                                       }
                                   }
                           }
                       } // ForEach
                   }
                   
                   // Nodes
                   ForEach(graphModel.graph.nodes) { node in
                       NodeView(node: node)
                           .position(node.position)
                           .onTapGesture {
                               withAnimation {
                                   graphModel.handleNodeTap(node)
                               }
                           }
                   }
               }
               
               // Alerts and popup
               if showPopupAgain && graphModel.showGenericInstructionPopup {
                   AlertPopUpView(graphModel: graphModel, showPopupAgain: $showPopupAgain)
                       .transition(.move(edge: .bottom)) // Slide in from bottom animation
               }
               
               if graphModel.showAlert {
                   AlertView(graphModel: graphModel)
                       .transition(.opacity) // Fade in animation
               }
               
               if graphModel.showAlgorithmExplanationBox {
                   ExplanationBoxView(graphModel: graphModel, algorithm: graphModel.selectedAlgorithmForExplanation)
                       .transition(.move(edge: .top)) // Slide in from top animation
               }
               
               VStack {
                   
                   Text("B F S")
                       .font(.system(size: 50))
                       .fontWeight(.bold)
                   
                   if !graphModel.showAlert {
                       TopBar(text: graphModel.topBarText)
                           .frame(height: UIScreen.main.bounds.height * 0.1)
                           .padding(.top,10)
                           .opacity(graphModel.topBarOpacity)
                   }
                   
                   Spacer()
                   
                   // Bottom bar
                   
                   HStack {
                       if graphModel.showPreviousButton {
                           Button(action: {
                               withAnimation {
                                   if graphModel.isChoosingNodes {
                                      // page = .welcomePage
                                       presentationMode.wrappedValue.dismiss()
                                   } else {
                                       graphModel.previousButtonTapped()
                                   }
                               }
                           }) {
                               Arrow(next: false)
                           }
                           .opacity(graphModel.previousButtonOpacity)
                       }
                       
                       if graphModel.isEditingNodesAndEdges
                       {
                          BottomBar(graphModel: graphModel)
                               .padding()
                               .opacity(graphModel.clearRandomBarOpacity)
                           
                       } else if graphModel.isSettingEdgesWeights {
                           
                           AlgorithmNameBar(text: graphModel.selectedAlgorithm?.id ?? "").padding()
                           
                       } else if graphModel.isAboutToPickOrRunAlgorithm {
                           SelectAlgorithmAndRunBar(graphModel: graphModel).padding()
                           
                       } else if graphModel.algorithmIsLive {
                           StopPauseResumeBar(graphModel: graphModel).padding()
                           
                       }else {
                          PrimsPicker(graphModel: graphModel)
                               .padding()
                               .opacity(graphModel.algorithmsListOpacity)
                           
                          // graphModel.selectAlgorithm(Algorithm.bfs)
                       }
                       
                       if graphModel.showNextButton {
                           Button(action: {
                               withAnimation {
                                   if graphModel.isAboutToPickOrRunAlgorithm {
                                      // page = .homePage
                                   } else {
                                       graphModel.nextButtonTapped()
                                   }
                               }
                           }) {
                               Arrow(next: true)
                           }
                           .opacity(graphModel.nextButtonOpacity)
                       }
                   }
                   .opacity(graphModel.showAlert ? 0 : 1)
                   .padding(.bottom, 16)

               }
               .padding()
           }
           .onAppear {
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                   if showPopupAgain {
                       withAnimation {
                           graphModel.showGenericInstructionPopup = true
                       }
                   }
               }
           }.navigationBarBackButtonHidden()
       }
}

#Preview {
    Prims_View( showPopupAgain: .constant(true))
}
