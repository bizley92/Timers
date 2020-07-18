//
//  TimerRow.swift
//  Timers
//
//  Created by Matt on 18/07/2020.
//

import SwiftUI

struct TimerRow: View {
    var timer: NamedTimer
    
    var body: some View {
        HStack {
            Text(timer.name)
            Text(timer.isActive ? "Pause" : "Play")
            Spacer()
            Text(String(timer.remaining))
                .multilineTextAlignment(.trailing)
//            Text(timer.timer)
            // timer, stop, pause..
            Spacer()
        }
    }
}

struct TimerRow_Previews: PreviewProvider {
    static var previews: some View {
        TimerRow(timer: NamedTimer(name: "Example"))
    }
}
