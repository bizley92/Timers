//
//  TimerDetail.swift
//  Timers
//
//  Created by Matt on 18/07/2020.
//

import SwiftUI

struct TimerDetail: View {
    @EnvironmentObject var data: Data
    var timer: NamedTimer
    
    var timerIndex: Int {
        data.timers.firstIndex(where: {$0.id == timer.id})!
    }
    
    var body: some View {
        VStack {
            Text(timer.name)
            Text(String(self.data.timers[self.timerIndex].remaining))
            Text(timer.isActive ? "Running" : "Stopped")
        }
    }
}

struct TimerDetail_Previews: PreviewProvider {
    static var previews: some View {
        let data = Data()
        TimerDetail(timer: data.timers[0])
            .environmentObject(data)
    }
}
