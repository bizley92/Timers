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
    var stoppedTime : Date?
    var notificationRequest: UNNotificationRequest? = nil
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
        return formatter.string(from: self.initialInterval)!.capitalized// + ".\(ms)"
    }
    
    func createNotification() -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = "Timer complete: \(self.name)"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: self.initialInterval, repeats: false)
        return UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
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
        self.notificationRequest = createNotification()
        UNUserNotificationCenter.current().add(self.notificationRequest!)
    }
}
