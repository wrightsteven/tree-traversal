//
//  File.swift
//  Tree Traversal
//
//  Created by Steven Wright on 12/13/20.
//  Copyright © 2020 Steven Wright. All rights reserved.
//

import SwiftUI
// Hash table to store center points for each node
struct CollectDict<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key:Value] { [:] }
    static func reduce(value: inout [Key:Value], nextValue: () -> [Key:Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}
