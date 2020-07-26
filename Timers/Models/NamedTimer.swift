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
    var interval: TimeInterval = TimeInterval(60)
    var isActive = true
    var initialInterval: TimeInterval
}

extension NamedTimer {
    init(name: String, duration: TimeInterval) {
        self.name = name
        self.initialInterval = duration
        self.interval = duration
    }
}
