//
//  TimersApp.swift
//  Timers
//
//  Created by Matt on 16/07/2020.
//

import SwiftUI

@main
struct TimersApp: App {
    var body: some Scene {
        WindowGroup {
            TimersList().environmentObject(Data())
        }
    }
}
