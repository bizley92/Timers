//
//  TimerRow.swift
//  Timers
//
//  Created by Matt on 18/07/2020.
//

import SwiftUI

struct TimerRow: View {
    @EnvironmentObject var data: Data
    @State var timer: NamedTimer
    
    var timerIndex: Int {
        data.timers.firstIndex(where: {$0.id == timer.id})!
    }
    
    var body: some View {
        HStack {
            Text(timer.name)
            Spacer()
            Button(action: {self.data.timers[self.timerIndex].isActive.toggle()}, label: {
                Image(systemName: self.data.timers[self.timerIndex].isActive ? "pause.circle" : "play.circle")
            })
            Button(action: {self.data.timers[self.timerIndex].interval = self.data.timers[self.timerIndex].initialInterval}, label: {
                Image(systemName: "arrow.clockwise.circle")
            })
            Text(String(self.data.timers[self.timerIndex].interval))
                .multilineTextAlignment(.trailing)
            Spacer()
            NavigationLink(
                destination: TimerDetail(timer: timer)
                    .environmentObject(data),
                label: {
                    Text("View")
            })
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct TimerRow_Previews: PreviewProvider {
    static var previews: some View {
        TimerRow(timer: NamedTimer(name: "Example", duration: 60))
    }
}
