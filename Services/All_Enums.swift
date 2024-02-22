//
//  All_Enums.swift
//  TheGraphOracle
//
//  Created by Smit Patel on 19/02/24.
//

import Foundation

enum Page {
    case welcomePage
    case homePage
    case finalPage
}

enum Step: CaseIterable {
    case nodeSelection
    case edgeSelection
    case askingForAlgorithmSelection
    case algorithmsList
    case initialFinalNodesSelection
    case onlyInitialNodeSelection
    case edgesWeigthsSelection
    case liveAlgorithm
}



enum NodeType {
    case hidden, notVisited, visited
}

enum NodePlace {
    case initial, normal, final
}


enum EdgeError: Error {
    case nilSourceNode
}


enum Algorithm: String, CaseIterable, Identifiable {
    case dfs = "Depth-first search"
    case bfs = "Breadth-first search"
    case djikstra = "Djikstra's shortest path"
    case prim = "Prim's minimum spanning tree"
    
    var id: String { self.rawValue }
}

enum AlgorithmState {
    case notStarted, running, paused
}
