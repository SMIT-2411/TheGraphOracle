//
//  Datastructures.swift
//  TheGraphOracle
//
//  Created by Smit Patel on 21/02/24.
//

import Foundation


//queue DataStructure

struct Queue<T> {
    private var content = [T]()
    
    var isEmpty: Bool { content.isEmpty }
    
    mutating func enqueue(_ element: T) {
        content.append(element)
    }
    
    mutating func dequeue() -> T? {
        isEmpty ? nil : content.removeFirst()
    }
}

extension Queue: CustomStringConvertible {
    var description: String {
        String(describing: content)
    }
}


//stack Datastructure

struct Stack<T> {
    private var content = [T]()
    
    var isEmpty: Bool { content.isEmpty }
    
    mutating func push(_ element: T) {
        content.append(element)
    }
    
    mutating func pop() -> T? {
        isEmpty ? nil : content.removeLast()
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
         """
        (TOP)
        \(content.map { "\($0)" }.reversed().joined(separator:"\n"))
        (BOTTOM)
        """
    }
}

