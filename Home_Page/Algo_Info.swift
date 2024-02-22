//
//  Algo_Info.swift
//  TheGraphOracle
//
//  Created by Smit Patel on 22/02/24.
//

import Foundation


import SwiftUI


struct Algo_Card: Identifiable {
    var id = UUID().uuidString
    var cardColor: Color
    var offset: CGFloat = 0
    var title: String
    var description: String
}

class CarouselViewModel: ObservableObject {
    
    
    @Published var cards = [
        Algo_Card(cardColor: Color("blue"), title: "Breadth First Search" , description: "Breadth-First Search (BFS) is a graph traversal algorithm that explores the vertices of a graph level by level. It starts at a chosen vertex (often called the Soucre or Starting vertex) and explores all of its neighbors at the present depth level before moving on to the vertices at the next level.\"" ),
        
        Algo_Card(cardColor: Color("purple"), title: "Depth First Search" , description: "Imagine exploring a complex maze, where paths branch and twist endlessly. Depth-First Search (DFS) tackles this challenge by plunging headfirst down one path at a time, systematically visiting each connected node before backtracking."),
        
        Algo_Card(cardColor: Color("green"), title: "Dijkstra's algorithm",description: "Like a seasoned traveler seeking the quickest route, Dijkstra's algorithm starts at a chosen city and meticulously calculates the shortest paths to every other destination. It spreads like ripples on a pond, marking distances as it goes. Each iteration selects the unvisited city with the shortest known distance, expanding its reach until all cities are mapped. This approach ensures you'll always reach your destination in the least amount of travel time, making it ideal for tasks like planning road trips or navigating complex transportation systems."),
        
        Algo_Card(cardColor: Color("orange"), title: "Prim's algorithm",description: " This algorithm acts like a cost-conscious builder, aiming to connect all cities with the least total road construction expense. It starts at any city and carefully chooses the cheapest edge leading to an unvisited city, building the network one step at a time. Imagine connecting dots on a map with minimal line segments – that's the essence of Prim's. This approach creates a minimum spanning tree, ensuring all cities are connected while minimizing the overall cost. This makes it perfect for tasks like laying down communication cables or designing efficient electrical grids."),
    ]

    @Published var swipedCard = 0

    // Detail content
    @Published var showCard = false
    @Published var selectedCard = Algo_Card(cardColor: .clear, title: "" , description: "")

    @Published var showContent = false

    
}
