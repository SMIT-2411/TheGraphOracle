//
//  Graph_Operations.swift
//  TheGraphOracle
//
//  Created by Smit Patel on 21/02/24.
//

import Foundation
import SwiftUI

class Graph_Operations: ObservableObject, Copying {
    
    // MARK: - Type Properties
    
    static let maxNodesQuant = NodePosition.nodesPositions.count
    static let maxHiddenNodesQuantCover = NodePosition.coverHiddenNodesPositions.count
    static let nodeSize: CGFloat = 40
    
    // MARK: - Properties
    
    @Published var nodes: [Node]
    @Published var edges: [[Edge]]
    @Published var visitedFinalNodeId: Int?
    @Published var visitedNodesIds = [Int]()
    @Published var algorithmState: AlgorithmState = .notStarted
    
    var selectedAlgorithm: Algorithm?
    var timer: Timer?
    var finalNodeId: Int?
    var tree = [Edge]()
    
    // MARK: - Computed Properties
    
    var visitedAllNodes: Bool {
        return visitedNodesIds.count == unhiddenNodes.count
    }
    
    var unhiddenNodes: [Node] {
        return nodes.filter({!$0.isHidden})
    }
    
    // MARK: - Init
    
    init(nodes: [Node]) {
        self.nodes = nodes
        self.edges = [[Edge]]()
        
        for _ in nodes {
            edges.append([Edge]())
        }
    }
    
    init(nodes: [Node], edges: [[Edge]]) {
        self.nodes = nodes
        self.edges = edges
    }
    
    required convenience init(_ prototype: Graph_Operations) {
        self.init(nodes: prototype.nodes, edges: prototype.edges)
    }
    
    // MARK: - Timer
    
    func stopTimer() {
        timer?.invalidate()
        algorithmState = .notStarted
    }
    
    // MARK: - Nodes
    
    func addNode(_ node: Node) {
        nodes.append(node)
        edges.append([Edge]())
    }
    
    func retrieveAllNodes() {
        nodes.forEach { $0.setAsNotVisited() }
    }
    
    func randomizeNodeSelection() {
        nodes.forEach { $0.randomizeSelection() }
        nodes.filter({ !$0.isHidden }).forEach({ $0.randomizeSelection() })
    }
    
    // MARK: Visitation
    
    func eraseVisitedNodesIdsArray() {
        visitedNodesIds = []
    }
    
    func unvisitAllNodes() {
        eraseVisitedNodesIdsArray()
        for node in unhiddenNodes where node.isVisited {
            node.setAsNotVisited()
        }
    }
    
    func removeEdgesFromTree() {
        for nodeEdges in edges {
            for edge in nodeEdges {
                if !tree.contains(where: {$0 == edge}) {
                    edge.setAsOutOfTree()
                }
            }
        }
        unvisitAllNodes()
    }
    
    func resetTree() {
        for nodeEdges in edges {
            for edge in nodeEdges {
                edge.setAsInTree()
            }
        }
        tree = []
    }
    
}

// MARK: - Edges

extension Graph_Operations {
    
    // MARK: Create edges
    
    func addEdge(_ edge: Edge) {
        return addEdge(edge, on: &edges)
    }
    
    private func addEdge(_ edge: Edge, on graphEdges: inout [[Edge]]) {
        let rev = edge.reversed
        graphEdges[edge.source.id].append(edge)
        graphEdges[edge.dest.id].append(rev)
    }
    
    func getRandomEdges() -> [[Edge]] {
        let randomEdges = generateRandomTree()
        /*
        let nodes = unhiddenNodes

        for sourceNode in nodes {
            let destNodes = unhiddenNodes.filter {$0 != sourceNode}
            var destNodesQuant = 1 // Int.random(in: 0...destNodes.count)

            while (destNodesQuant > 0) {
                guard let destNode = destNodes.randomElement() else { break }
                if edgeConnects(sourceNode, to: destNode, on: randomEdges) { continue }

                let edge = Edge(from: sourceNode, to: destNode)
                addEdge(edge, on: &randomEdges)
                destNodesQuant -= 1
            }
        }
        */
        return randomEdges
    }
    
    private func generateRandomTree() -> [[Edge]] {
        var edgesMatrix = Self.createEmptyEdgesMatrix(quantity: nodes.count)
        var nodes = unhiddenNodes
        
        guard var sourceNode = nodes.randomElement() else { return edgesMatrix }
        nodes.removeAll(where: {$0.id == sourceNode.id})
        
        while !nodes.isEmpty {
            guard let destNode = nodes.randomElement() else { break }
            let edge = Edge(from: sourceNode, to: destNode)
            addEdge(edge, on: &edgesMatrix)
            nodes.removeAll(where: {$0.id == destNode.id})
            sourceNode = destNode
        }
        
        return edgesMatrix
    }
    
    static func createEmptyEdgesMatrix(quantity: Int) -> [[Edge]] {
        var newEdges = [[Edge]]()
        for _ in 0..<quantity {
            newEdges.append([Edge]())
        }
        return newEdges
    }
    
    // MARK: Checking for existing connections
    
    func edgeConnects(_ sourceNode: Node, to destNode: Node) -> Bool {
        return edgeConnects(sourceNode, to: destNode, on: edges)
    }
    
    private func edgeConnects(_ sourceNode: Node, to destNode: Node, on graphEdges: [[Edge]]) -> Bool {
        for sourceNodeEdge in graphEdges[sourceNode.id] {
            if sourceNodeEdge.dest == destNode { return true }
        }
        return false
    }
    
    // MARK: Weights
    
    func setWeightOn(edge: Edge, weight: Int) {
        edges[edge.source.id].forEach {
            if $0 == edge {
                $0.weight = weight
                return
            }
        }
        
        edges[edge.dest.id].forEach {
            if $0 ~= edge {
                $0.weight = weight
                return
            }
        }

    }
    
    // MARK: Remove edges
    
    func removeEdge(_ edge: Edge) {
        let sourceNode = nodes[edge.source.id]
        let destNode = nodes[edge.dest.id]
        edges[sourceNode.id].removeAll(where: { $0 == edge })
        edges[destNode.id].removeAll(where: { $0 == edge.reversed })
    }
    
    func removeAllEdges() {
        for nodeEdges in edges {
            for edge in nodeEdges {
                removeEdge(edge)
            }
        }
    }
    
    // MARK: Remove reversed in array
    
    static func removeReversedIn(_ edgesArray: inout [Edge]) {
        var toRemove = [Edge]()
        
        for ed in 0..<edgesArray.count-1 {
            for next in ed+1..<edgesArray.count {
                if edgesArray[ed] ~= edgesArray[next] {
                    toRemove.append(edgesArray[next] )
                }
            }
        }
        
        for ed in toRemove {
            edgesArray.removeAll(where: { $0 == ed })
        }
    }
    
    // MARK: Cover graph
    
    func build(withNewNodeOfId id: Int) {
        if !(1...25).contains(id) { return }
        
        let positions = NodePosition.coverUnhiddenNodesPositions
        var destNodeId = 0
        
        if (1...9).contains(id) || (11...13).contains(id) || id == 15
            || (17...19).contains(id) || (21...23).contains(id) || id == 25 {
            // Connecting to the previous node
            destNodeId = id-1
        } else {
            // Connecting to specific node
            switch id {
                case 10, 16: destNodeId = 3
                case 14: destNodeId = 10
                case 20: destNodeId = 18
                case 24: destNodeId = 22
                default: break
            }
        }
        
        let node = Node(id: id, position: positions[id])
        if id == 25 { node.toggleFinalStatus() }
        addNode(node)
        let edge = Edge(from: nodes[id], to: nodes[destNodeId])
        addEdge(edge)
    }
}

// MARK: - Generate graph

extension Graph_Operations {
    static func generate() -> Graph_Operations {
        var nodes = [Node]()
        for i in 0..<maxNodesQuant {
            let point = NodePosition.nodesPositions[i]
            let node = Node(id: i, position: point)
            nodes.append(node)
        }
        return Graph_Operations(nodes: nodes)
    }
    
    static func generateHiddenForCover() -> Graph_Operations {
        var nodes = [Node]()
        for i in 0..<maxHiddenNodesQuantCover {
            let point = NodePosition.coverHiddenNodesPositions[i]
            let node = Node(id: i, position: point)
            node.type = .hidden
            nodes.append(node)
        }
        return Graph_Operations(nodes: nodes)
    }
    
    static func generateUnhiddenForCover() -> Graph_Operations {
        var edges = [[Edge]]()
        for _ in 0...25 {edges.append([Edge]())}
        
        let positions = NodePosition.coverUnhiddenNodesPositions
        let graph = Graph_Operations(nodes: [Node](), edges: edges)
        let node = Node(id: 0, position: positions[0])
        
        node.toggleInitialStatus()
        graph.addNode(node)
        
        return graph
    }
    
    static func randomPlacedNodes() -> Graph_Operations {
        var nodes = [Node]()
        
        for i in 0..<maxNodesQuant {
            
            let randomX = CGFloat.random(in: getHRange())
            let randomY = CGFloat.random(in: getHRange())
            let randomPoint = CGPoint(x: randomX, y: randomY)
            let node = Node(id: i, position: randomPoint)
            nodes.append(node)
            
            func getHRange() -> ClosedRange<CGFloat> 
            {
                let lowerBound = Self.nodeSize*2
                let higherBound = UIScreen.main.bounds.width - Self.nodeSize*2
                return lowerBound...higherBound
            }
            
            func getVRange() -> ClosedRange<CGFloat> {
                let lowerBound = UIScreen.main.bounds.height * 0.278
                let higherBound = UIScreen.main.bounds.width * 0.823
                return lowerBound...higherBound
            }
        }
        
        return Graph_Operations(nodes: nodes)
    }
}

public protocol Copying: AnyObject {
    init(_ prototype: Self)
}

extension Copying {
    public func copy() -> Self {
        return type(of: self).init(self)
    }
}


extension Graph_Operations {
    
    // MARK: DFS
    
    func runDFS(startingFrom node: Node) {
        selectedAlgorithm = .dfs
        finalNodeId = nil
        visitedFinalNodeId = nil
        
        dfs(startingFrom: node)
        animateAlgorithm()
    }
    
    func dfs(startingFrom node: Node) {
        visitedNodesIds.append(node.id)
        
        if node.isFinal {
            finalNodeId = node.id
            return
        }
        
        for edge in edges[node.id] {
            if finalNodeId != nil { return }
            if !visitedNodesIds.contains(edge.dest.id) {
                dfs(startingFrom: edge.dest)
            }
        }
    }
    
    // MARK: BFS
    
    func runBFS(startingFrom node: Node) {
        selectedAlgorithm = .bfs
        finalNodeId = nil
        visitedFinalNodeId = nil
        
        bfs(startingFrom: node)
        animateAlgorithm()
    }
    
    private func bfs(startingFrom node: Node) {
        var queue: Queue<Node> = Queue()
        queue.enqueue(node)
        visitedNodesIds.append(node.id)
        
        while(!queue.isEmpty) {
            guard let dequeuedNode = queue.dequeue() else { break }
            
            for edge in edges[dequeuedNode.id] {
                if visitedNodesIds.contains(edge.dest.id) { continue }
                queue.enqueue(edge.dest)
                visitedNodesIds.append(edge.dest.id)
                
                if edge.dest.isFinal {
                    finalNodeId = edge.dest.id
                    return
                }
            }
        }
    }
    
    // MARK: - Djikstra
    
    func runDjikstra(startingFrom node: Node) {
        selectedAlgorithm = .dijkstra
        djikstra(startingFrom: node)
        animateAlgorithm()
    }
    
    private func djikstra(startingFrom node: Node) {
        var distances = [Int:Int]()
        
        unhiddenNodes.forEach { node in
            distances[node.id] = .max
        }
        
        distances[node.id] = 0
        
        while visitedNodesIds.count < unhiddenNodes.count {
            let currentNodeId = minDistance(in: distances)
            visitedNodesIds.append(currentNodeId)
            
            for edge in edges[currentNodeId] where !visitedNodesIds.contains(edge.dest.id) {
                guard let currentDistance = distances[currentNodeId] else { continue }
                guard let destDistance = distances[edge.dest.id] else { continue }
                
                let distanceToNeighbor = currentDistance + edge.weight
                
                if destDistance > distanceToNeighbor {
                    distances[edge.dest.id] = distanceToNeighbor
                    addToTree(edge: edge)
                }
            }
        }
    }
    
    private func addToTree(edge: Edge) {
        if !tree.contains(where: { $0 == edge && $0 ~= edge }) {
            tree.removeAll(where: { $0.dest == edge.dest })
            tree.append(edge)
        }
    }
    
    private func minDistance(in distances: [Int:Int]) -> Int {
        var closestNodeId = -1
        var shortestDistance = Int.max
        
        for (nodeId,dist) in distances where !visitedNodesIds.contains(nodeId) {
            if dist < shortestDistance {
                closestNodeId = nodeId
                shortestDistance = dist
            }
        }
        
        return closestNodeId
    }
    
    // MARK: - Prim
    
    func runPrim(startingFrom node: Node) {
        selectedAlgorithm = .prim
        prim(startingFrom: node)
        animateAlgorithm()
    }
    
    private func prim(startingFrom node: Node) {
        var distances = [Int:Int]()
        
        for node in unhiddenNodes {
            distances[node.id] = .max
        }
        
        distances[node.id] = 0
        
        while visitedNodesIds.count < unhiddenNodes.count {
            let currentNodeId = minDistance(in: distances)
            visitedNodesIds.append(currentNodeId)
            
            for edge in edges[currentNodeId] where !visitedNodesIds.contains(edge.dest.id) {
                guard let destDistance = distances[edge.dest.id] else { continue }
                if destDistance > edge.weight {
                    distances[edge.dest.id] = edge.weight
                    addToTree(edge: edge)
                }
            }
        }
    }
}

// MARK: - Animations

extension Graph_Operations  {
    private func animateAlgorithm() {
        algorithmState = .running
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { algTimer in
            if self.algorithmState != .running { return }
            
            if self.visitedNodesIds.isEmpty {
                algTimer.invalidate()
                self.timer?.invalidate()
                self.algorithmState = .notStarted
                
                if self.selectedAlgorithm == .dijkstra || self.selectedAlgorithm == .prim {
                    self.removeEdgesFromTree()
                }
                
                self.selectedAlgorithm = nil
                return
            }
            
            let id = self.visitedNodesIds.removeFirst()
            self.nodes[id].setAsVisited()
            
            // DFS and BFS
            if id == self.finalNodeId {
                self.visitedFinalNodeId = self.finalNodeId
            }
        })
    }
    
}

struct GraphAlgoExplanation {
    
    
    static func getAlgorithmExplanationText(for algorithm: Algorithm) -> String {
        switch algorithm {
            case .dfs:
                return "Depth-first search performs a search in a graph. It starts from a source node and explores as far as possible (visiting the neighbors of the neighbors) along each branch before backtracking, i.e., visiting the remaining node's neighbors and repeating this process.\n\nA graph can have more than one DFS, depending on the order the neighbors were added to the neighborhoods. Also, each node must be marked as visited since a graph may contain cycles and, therefore, each node can be processed twice or more."
            case .bfs:
                return "The breadth-first search performs a search in a graph. It starts from a source node and visits all nodes at the current depth level (neighborhood) before moving to the nodes at the next depth level (neighbors of the neighbors).\n\nA graph can have more than one BFS, depending on the order the neighbors were added to the neighborhoods. Also, each node must be marked as visited since a graph may contain cycles and, therefore, each node can be processed twice or more."
            case .dijkstra:
                return "This algorithm finds the shortest path from a source node to all the other nodes in a graph considering the cost (edge's weights) to reach them. At the end of it's execution, it produces what we call Shortest Path Tree (SPT).\n\nIn comparison with Prim's algorithm, the sum of the costs of the edges in the SPT can be much larger than the cost of a Minimum Spanning Tree."
            case .prim:
                return "This algorithm finds the called Minimum Spanning Tree (MST), that is a subset of edges that forms a tree including all nodes, where the total weight of these edges is minimized.\n\nIn comparison with Djisktra's algorithm, the length of a path between any two nodes in the MST might not be the shortest path between them in the original graph."
        }
    }
    
}
