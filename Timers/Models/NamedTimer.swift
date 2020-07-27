//
//  Timer.swift
//  Timers
//
//  Created by Matt on 18/07/2020.
//

import SwiftUI

class NamedTimer: Identifiable {
    var id = UUID()
    var name: String = ""
    var interval: TimeInterval = 60
    var isActive = true
    var initialInterval: TimeInterval = 0
    
    func intervalToString() -> String {
//        let ms = Int(interval.truncatingRemainder(dividingBy: 1) * 1000)
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter.string(from: self.interval)!// + ".\(ms)"
    }
    
    func spellOutInterval() -> String {
//        let ms = Int(interval.truncatingRemainder(dividingBy: 1) * 1000)
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .spellOut
        return formatter.string(from: self.interval)!.capitalized// + ".\(ms)"
    }
}

extension NamedTimer {
    convenience init(name: String, duration: TimeInterval) {
        self.init()
        self.name = name
        self.initialInterval = duration
        self.interval = duration
        if (self.name.isEmpty) {
            self.name = intervalToString()
        }
    }
}
