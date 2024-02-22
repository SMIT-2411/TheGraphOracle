//
//  Graph_Structure.swift
//  TheGraphOracle
//
//  Created by Smit Patel on 21/02/24.
//

import SwiftUI

struct Graph_Structure: View {
    @Binding var page: Page
    @Binding var showPopupAgain: Bool
    @StateObject private var graphModel = GraphAlgoModel()
    
    var body: some View {
        ZStack {
            Color.darkGray
                .ignoresSafeArea()
            
            // MARK: Graph
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
            
            // MARK: Alerts and popup
            
            if showPopupAgain && graphModel.showGenericInstructionPopup {
                GenericInstructionView(graphModel: graphModel, showPopupAgain: $showPopupAgain)
            }
            
            if graphModel.showAlert {
                AlertView(graphModel: graphModel)
            }
            
            if graphModel.showAlgorithmExplanationBox {
                ExplanationBoxView(graphModel: graphModel, algorithm:
                                    graphModel.selectedAlgorithmForExplanation)
            }
            
            VStack {
                // MARK: Top part
                if !graphModel.showAlert {
                    Image("LiveAlgorithmsInline")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 32)
                }
                
                if !graphModel.showAlert {
                    Bar(text: graphModel.topBarText)
                        .frame(height: UIScreen.main.bounds.height * 64/1133)
                        .padding(.top, 32)
                        .opacity(graphModel.topBarOpacity)
                }
                
                // MARK: Graph space
                Spacer()
                
                // MARK: Bottom bar
                HStack {
                    // Previous step
                    if graphModel.showPreviousButton {
                        Button(action: {
                            withAnimation {
                                if graphModel.isChoosingNodes {
                                    page = .welcomePage
                                } else {
                                    graphModel.previousButtonTapped()
                                }
                            }
                        }) {
                            Arrow(next: false)
                        }
                        .opacity(graphModel.previousButtonOpacity)
                    }
                    
                    // Options bar
                    if graphModel.isEditingNodesAndEdges {
                        ClearRandomBar(graphModel: graphModel)
                            .padding()
                            .opacity(graphModel.clearRandomBarOpacity)
                        
                    } else if graphModel.isSettingEdgesWeights {
                       AlgorithmNameBar(text: graphModel.selectedAlgorithm?.id ?? "").padding()
                        
                    } else if graphModel.isAboutToPickOrRunAlgorithm {
                        SelectAlgorithmAndRunBar(graphModel: graphModel).padding()
                        
                    } else if graphModel.algorithmIsLive {
                        StopPauseResumeBar(graphModel: graphModel).padding()
                        
                    } else {
                        AlgoPicker(graphModel: graphModel)
                            .padding()
                            .opacity(graphModel.algorithmsListOpacity)
                    }
                    
                    // Next step
                    if graphModel.showNextButton {
                        Button(action: {
                            withAnimation {
                                if graphModel.isAboutToPickOrRunAlgorithm {
                                    page = .finalPage
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

            } // VStack
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                if showPopupAgain {
                    withAnimation {
                        graphModel.showGenericInstructionPopup = true
                    }
                }
            })
        }
        // ZStack
    }
}



