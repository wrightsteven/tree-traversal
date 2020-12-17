//
//  File.swift
//  Tree Traversal
//
//  Created by Steven Wright on 12/13/20.
//  Copyright © 2020 Steven Wright. All rights reserved.
//

import SwiftUI
// Circle border for nodes
struct CircleStyle: ButtonStyle {
    func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        Circle()
            .overlay(Circle()
                        .stroke(Color.white, lineWidth: 2)
                        .padding(10)
            )
            .overlay(configuration.label)
            .frame(width: 50, height: 50)
    }
}

/*
struct RoundedCircleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 50, height: 50)
            .background(Circle().stroke())
            .background(Circle().fill(Color.white))
            .padding(10)
    }
}
*/
