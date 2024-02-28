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
                .fill(Color.black)
        
            
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


struct BFSPicker: View {
    @ObservedObject var graphModel: GraphAlgoModel
    private let list = Algorithm.allCases
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color("coffee"))
        
            
            VStack {
                Spacer()
                Text("Select algorithm")
                    .font(.system(size: 40))
                    .foregroundColor(Color("cream"))
                    .bold()
                
               
                    HStack {
                        Button(action: {
                            withAnimation {
                                graphModel.selectAlgorithm(Algorithm.bfs)
                            }
                        }) {
                            Text(Algorithm.bfs.id)
                                .fontWeight(.semibold)
                                .font(.title)
                                .foregroundColor(Color("darkOrange"))
                                .padding(.vertical, 10)
                        }
                    }
                Spacer()
            }
        }
        .frame(height: UIScreen.main.bounds.width * 0.1)
        .frame(maxWidth: UIScreen.main.bounds.width * 0.5)
    }
}

struct DFSPicker: View {
    @ObservedObject var graphModel: GraphAlgoModel
    private let list = Algorithm.allCases
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color("coffee"))
        
            
            VStack {
                Spacer()
                Text("Select algorithm")
                    .font(.system(size: 40))
                    .foregroundColor(Color("cream"))
                    .bold()
                
               
                    HStack {
                        Button(action: {
                            withAnimation {
                                graphModel.selectAlgorithm(Algorithm.dfs)
                            }
                        }) {
                            Text(Algorithm.dfs.id)
                                .fontWeight(.semibold)
                                .font(.title)
                                .foregroundColor(Color("darkOrange"))
                                .padding(.vertical, 10)
                        }
                    }
                Spacer()
            }
        }
        .frame(height: UIScreen.main.bounds.width * 0.1)
        .frame(maxWidth: UIScreen.main.bounds.width * 0.5)
    }
}

struct DijkstraPicker: View {
    @ObservedObject var graphModel: GraphAlgoModel
    private let list = Algorithm.allCases
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color("coffee"))
        
            
            VStack {
                Spacer()
                Text("Select algorithm")
                    .font(.system(size: 40))
                    .foregroundColor(Color("cream"))
                    .bold()
                
               
                    HStack {
                        Button(action: {
                            withAnimation {
                                graphModel.selectAlgorithm(Algorithm.dijkstra)
                            }
                        }) {
                            Text(Algorithm.dijkstra.id)
                                .fontWeight(.semibold)
                                .font(.title)
                                .foregroundColor(Color("darkOrange"))
                                .padding(.vertical, 10)
                        }
                    }
                Spacer()
            }
        }
        .frame(height: UIScreen.main.bounds.width * 0.1)
        .frame(maxWidth: UIScreen.main.bounds.width * 0.5)
    }
}

struct PrimsPicker: View {
    @ObservedObject var graphModel: GraphAlgoModel
    private let list = Algorithm.allCases
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color("coffee"))
        
            
            VStack {
                Spacer()
                Text("Select algorithm")
                    .font(.system(size: 40))
                    .foregroundColor(Color("cream"))
                    .bold()
                
               
                    HStack {
                        Button(action: {
                            withAnimation {
                                graphModel.selectAlgorithm(Algorithm.prim)
                            }
                        }) {
                            Text(Algorithm.prim.id)
                                .fontWeight(.semibold)
                                .font(.title)
                                .foregroundColor(Color("darkOrange"))
                                .padding(.vertical, 10)
                        }
                    }
                Spacer()
            }
        }
        .frame(height: UIScreen.main.bounds.width * 0.1)
        .frame(maxWidth: UIScreen.main.bounds.width * 0.5)
    }
}

#Preview {
    BFSPicker(graphModel: GraphAlgoModel())
}
