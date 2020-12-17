//
//  Tree.swift
//  Tree Traversal
//
//  Created by Steven Wright on 12/13/20.
//  Copyright © 2020 Steven Wright. All rights reserved.
//

import Foundation
import SwiftUI

// Create tree
struct Tree<A> {
    var value: A
    var children: [Tree<A>] = []
    init(_ value: A, children: [Tree<A>] = []) {
        self.value = value
        self.children = children
    }
    
    // DFS to find depth of selected node
    func search(element: A) {
        self.dfs(self.rootNode, element)
    }
        
    private func dfs(_ rootNode: TreeNode<A>?, _ element:A) -> Int {
        let rootNode = rootNode
        let leftNode = rootNode.left
        let rightNode = rootNode.right
        var count = 0
        
        if element != rootNode.data {
            count += 1
            self.dfs(rootNode.right)
            self.dfs(rootNode.left)
        } else{return count}
    
    }
}

// Define binaryTree
let binaryTree = Tree<Int>(50, children: [
    Tree(17, children: [
    Tree(12, children: [Tree(35), Tree(41)]),
    Tree(23)
    ]),
    Tree(72, children: [
    Tree(54),
    Tree(91, children: [Tree(23)])
    ])
])

// Transform Tree<Int> to Tree <Int<Unique>>
extension Tree {
    func map<B>(_ transform: (A) -> B) -> Tree<B> {
        return Tree<B>(transform(value), children: children.map({ $0.map(transform) }))
        
    }
}

let uniqueTree = binaryTree.map(Unique.init)
