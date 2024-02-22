//
//  Card.swift
//  TheGraphOracle
//
//  Created by Smit Patel on 17/02/24.
//


import Foundation


struct Card: Identifiable {
    let id : Int
    var title : String
    var description : String
   
    
}

var testData:[Card] = [
    
    Card(
        id: 1,
        title: "Unlock Graph Algorithm Power",
        description: "Graphs are not just mathematical structures; they're powerful tools for solving real-world problems. Dive into the world of graph algorithms and uncover their potential. From finding the shortest path in a network to identifying communities in social networks, graphs offer a versatile framework for tackling a wide range of problems. Let's harness the power of graphs together!"
    ),

    Card(
        id: 2,
        title: "Visualize Graph Complexity",
        description: "Visualizing graphs can offer unique insights into complex data structures. With Graphify's visualization tools, you can unravel the complexity of graphs and gain a deeper understanding of their structure and relationships. From interactive visualizations to customizable layouts, exploring graphs has never been easier. Step into the world of graph visualization and see your data in a whole new light!"
    )

]

