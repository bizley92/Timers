//
//  Timer.swift
//  Timers
//
//  Created by Matt on 18/07/2020.
//

import SwiftUI

struct NamedTimer: Identifiable {
    var id = UUID()
    var name: String
    var count: Int = 10
    var remaining: Int = 10
    var isActive = true
}
