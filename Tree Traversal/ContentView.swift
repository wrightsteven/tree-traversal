//
//  ContentView.swift
//  Tree Traversal
//
//  Created by Steven Wright on 6/12/20.
//  Copyright © 2020 Steven Wright. All rights reserved.
//

import SwiftUI

// Create tree
struct Tree<A> {
    var value: A
    var children: [Tree<A>] = []
    init(_ value: A, children: [Tree<A>] = []) {
        self.value = value
        self.children = children
    }
}

// Define binaryTree
let binaryTree = Tree<Int>(50, children: [
    Tree(17, children: [
    Tree(12),
    Tree(23)
    ]),
    Tree(72, children: [
    Tree(54),
    Tree(91)
    ])
])

extension Tree {
    func map<B>(_ transform: (A) -> B) -> Tree<B> {
        return Tree<B>(transform(value), children: children.map({ $0.map(transform) }))
    }
}

class Unique<A>: Identifiable {
    let value: A
    init(_ value: A) { self.value = value }
}

struct CollectDict<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key:Value] { [:] }
    static func reduce(value: inout [Key:Value], nextValue: () -> [Key:Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

// Circle border for nodes
struct RoundedCircleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 50, height: 50)
            .background(Circle().stroke())
            .background(Circle().fill(Color.white))
            .padding(10)
    }
}

// Lines connecting nodes
struct Line: Shape {
    var from: CGPoint
    var to: CGPoint
    var animatableData: AnimatablePair<CGPoint, CGPoint> {
        get { AnimatablePair(from, to) }
        set {
            from = newValue.first
            to = newValue.second
        }
    }

    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: self.from)
            p.addLine(to: self.to)
        }
    }
}

// Draw diagram
struct Diagram<A: Identifiable, V: View>: View {
    let tree: Tree<A>
    let node: (A) -> V
    
    typealias Key = CollectDict<A.ID, Anchor<CGPoint>>

    var body: some View {
        VStack(alignment: .center) {
            node(tree.value)
               .anchorPreference(key: Key.self, value: .center, transform: {
                   [self.tree.value.id: $0]
               })
            HStack(alignment: .bottom, spacing: 10) {
                ForEach(tree.children, id: \.value.id, content: { child in
                    Diagram(tree: child, node: self.node)
                })
            }
        }.backgroundPreferenceValue(Key.self, { (centers: [A.ID: Anchor<CGPoint>]) in
            GeometryReader { proxy in
                ForEach(self.tree.children, id: \.value.id, content: {
                 child in
                    Line(
                        from: proxy[centers[self.tree.value.id]!],
                        to: proxy[centers[child.value.id]!])
                    .stroke()
                })
            }
        })
    }
}

struct ContentView: View {
    @State var tree: Tree<Unique<Int>> = binaryTree.map(Unique.init)
    var body: some View {
        Diagram(tree: tree, node: {
            value in Text("\(value.value)").modifier(RoundedCircleStyle())
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
