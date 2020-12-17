//
//  Unique.swift
//  Tree Traversal
//
//  Created by Steven Wright on 12/7/20.
//  Copyright © 2020 Steven Wright. All rights reserved.
//

import Foundation
import SwiftUI

// Make each node uniquely identifiable
class Unique<A>: Identifiable {
    let value: A
    init(_ value: A) { self.value = value }
}
