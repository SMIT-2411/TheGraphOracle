//
//  Node.swift
//  TheGraphOracle
//
//  Created by Smit Patel on 21/02/24.
//

import Foundation
import SwiftUI


class Node: Identifiable, ObservableObject {
    let id: Int
    let position: CGPoint
    @Published var type: NodeType = .notVisited
    @Published var place: NodePlace = .normal
    
    // Types
    
    var isHidden: Bool {
        return type == .hidden
    }
    
    var isVisited: Bool {
        return type == .visited
    }
    
    var isNotVisited: Bool {
        return type == .notVisited
    }
    
    // Places
    
    var isInitial: Bool {
        return place == .initial
    }
    
    var isFinal: Bool {
        return place == .final
    }
    
    init(id: Int, position: CGPoint) {
        self.id = id
        self.position = position
    }
    
    // MARK: - Methods
    
    func toggleHiddenStatus() {
        if type == .hidden {
            type = .notVisited
        } else {
            type = .hidden
        }
    }
    
    func randomizeSelection() {
        let types: [NodeType] = [.hidden, .notVisited]
        type = types.randomElement() ?? .hidden
    }
    
    func setAsVisited() {
        type = .visited
    }
    
    func setAsNotVisited() {
        type = .notVisited
    }
    
    func toggleInitialStatus() {
        if place == .initial {
            place = .normal
        } else {
            place = .initial
        }
    }
    
    func toggleFinalStatus() {
        if place == .final {
            place = .normal
        } else {
            place = .final
        }
    }
}

extension Node: Equatable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.id == rhs.id
    }
}

struct NodePosition {
    
    // MARK: - Positions
    
    static let greenCirclePosition = CGPoint(x: UIScreen.main.bounds.width * 260/744, y: UIScreen.main.bounds.height * 1022/1133)
    
    static var nodesPositions: [CGPoint] {
        return [
            Self.pointOnScreen(x: 270, y: 300), Self.pointOnScreen(x: 470, y: 300),
            Self.pointOnScreen(x: 070, y: 500), Self.pointOnScreen(x: 470, y: 500),
            Self.pointOnScreen(x: 070, y: 700), Self.pointOnScreen(x: 670, y: 700),
            Self.pointOnScreen(x: 270, y: 900), Self.pointOnScreen(x: 470, y: 900),
            Self.pointOnScreen(x: 170, y: 400), Self.pointOnScreen(x: 370, y: 400),
            Self.pointOnScreen(x: 570, y: 400), Self.pointOnScreen(x: 170, y: 600),
            Self.pointOnScreen(x: 370, y: 600), Self.pointOnScreen(x: 570, y: 600),
            Self.pointOnScreen(x: 170, y: 800), Self.pointOnScreen(x: 370, y: 800),
            Self.pointOnScreen(x: 570, y: 800), Self.pointOnScreen(x: 270, y: 500),
            Self.pointOnScreen(x: 470, y: 500), Self.pointOnScreen(x: 270, y: 700),
            Self.pointOnScreen(x: 470, y: 700), Self.pointOnScreen(x: 170, y: 500),
            Self.pointOnScreen(x: 370, y: 500), Self.pointOnScreen(x: 170, y: 700),
            Self.pointOnScreen(x: 370, y: 700), Self.pointOnScreen(x: 670, y: 500),
            Self.pointOnScreen(x: 570, y: 500), Self.pointOnScreen(x: 570, y: 700),
        ]
    }

    static var coverHiddenNodesPositions: [CGPoint] {
        return [
            Self.pointOnScreen(x: 100, y: 100), Self.pointOnScreen(x: 300, y: 100),
            Self.pointOnScreen(x: 500, y: 100), Self.pointOnScreen(x: 700, y: 100),
            Self.pointOnScreen(x: 900, y: 100), Self.pointOnScreen(x: 100, y: 300),
            Self.pointOnScreen(x: 300, y: 300), Self.pointOnScreen(x: 500, y: 300),
            Self.pointOnScreen(x: 700, y: 300), Self.pointOnScreen(x: 900, y: 300),
            Self.pointOnScreen(x: 100, y: 500), Self.pointOnScreen(x: 300, y: 500),
            Self.pointOnScreen(x: 500, y: 500), Self.pointOnScreen(x: 700, y: 500),
            Self.pointOnScreen(x: 900, y: 500), Self.pointOnScreen(x: 100, y: 700),
            Self.pointOnScreen(x: 300, y: 700), Self.pointOnScreen(x: 500, y: 700),
            Self.pointOnScreen(x: 700, y: 700), Self.pointOnScreen(x: 900, y: 700),
            Self.pointOnScreen(x: 100, y: 900), Self.pointOnScreen(x: 300, y: 900),
            Self.pointOnScreen(x: 500, y: 900), Self.pointOnScreen(x: 700, y: 900),
            Self.pointOnScreen(x: 900, y: 900)
        ]
    }

    static var coverUnhiddenNodesPositions: [CGPoint] {
        return [
            greenCirclePosition,
            Self.pointOnScreen(x: 400, y: 200), Self.pointOnScreen(x: 600, y: 200),
            Self.pointOnScreen(x: 200, y: 400), Self.pointOnScreen(x: 800, y: 400),
            Self.pointOnScreen(x: 200, y: 600), Self.pointOnScreen(x: 800, y: 600),
            Self.pointOnScreen(x: 400, y: 800), Self.pointOnScreen(x: 600, y: 800),
            Self.pointOnScreen(x: 300, y: 300), Self.pointOnScreen(x: 500, y: 300),
            Self.pointOnScreen(x: 700, y: 300), Self.pointOnScreen(x: 300, y: 500),
            Self.pointOnScreen(x: 500, y: 500), Self.pointOnScreen(x: 700, y: 500),
            Self.pointOnScreen(x: 300, y: 700), Self.pointOnScreen(x: 500, y: 700),
            Self.pointOnScreen(x: 700, y: 700), Self.pointOnScreen(x: 400, y: 400),
            Self.pointOnScreen(x: 600, y: 400), Self.pointOnScreen(x: 400, y: 600),
            Self.pointOnScreen(x: 600, y: 600), Self.pointOnScreen(x: 300, y: 400),
            Self.pointOnScreen(x: 500, y: 400), Self.pointOnScreen(x: 300, y: 600),
            Self.pointOnScreen(x: 500, y: 600)
        ]
    }


    static func pointOnScreen(x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: UIScreen.main.bounds.width * x/744, y: UIScreen.main.bounds.height * y/1133)
    }
}


// views


import SwiftUI

struct NodeView: View {
    @ObservedObject var node: Node
    var decreasedZIndex: Bool = true
    
    private var nodeIsVisited: Bool {
        node.type == .visited
    }
    private var nodeIsUnhidden: Bool {
        node.type != .hidden
    }
    
    var body: some View {
        if node.place == .initial {
            InitialNode(isVisited: nodeIsVisited)
        } else if node.place == .final {
            FinalNode(isVisited: nodeIsVisited)
        } else {
            if nodeIsUnhidden {
                NormalNode(isVisited: nodeIsVisited)
            } else {
                HiddenNode()
                    .zIndex(decreasedZIndex ? -2 : 0)
            }
        }
    }
}


struct InitialNode: View {
    var isVisited: Bool
    
    var body: some View {
        Circle()
            .fill(Color.myGreen)
            .frame(width: Graph_Operations.nodeSize, height: Graph_Operations.nodeSize)
            .overlay {
                Circle()
                    .stroke(Color.black, lineWidth: 4)
            }
            .blur(radius: isVisited ? 10 : 0)
    }
}

struct HiddenNode: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10 , style: .continuous)
            .fill(Color("cream"))
            .frame(width: Graph_Operations.nodeSize, height: Graph_Operations.nodeSize)
            .overlay {
                RoundedRectangle(cornerRadius: 10 , style: .continuous)
                    .stroke(Color.black, lineWidth: 4)
            }
    }
}


struct FinalNode: View {
    var isVisited: Bool
    
    var body: some View {
       Rectangle()
            .fill(Color.red)
            .frame(width: Graph_Operations.nodeSize, height: Graph_Operations.nodeSize)
            .border(Color.black, width: 4)
            .blur(radius: isVisited ? 10 : 0)
    }
}


struct NormalNode: View {
    var isVisited: Bool
    
    var body: some View {
        if isVisited {
            RoundedRectangle(cornerRadius: 10 , style: .continuous)
                .fill(Color.black)
                .frame(width: Graph_Operations.nodeSize, height: Graph_Operations.nodeSize)
                .blur(radius: 10)
        } else {
            RoundedRectangle(cornerRadius: 10 , style: .continuous)
                .fill(Color("orange"))
                .frame(width: Graph_Operations.nodeSize, height: Graph_Operations.nodeSize)
                .overlay {
                    RoundedRectangle(cornerRadius: 10 , style: .continuous)
                        .stroke(Color.black, lineWidth: 4)
                }
        }
    }
}




