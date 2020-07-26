//
//  TimerDetail.swift
//  Timers
//
//  Created by Matt on 18/07/2020.
//

import SwiftUI

struct TimerDetail: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var data: Data
    @State var timer: NamedTimer
    
    var timerIndex: Int {
        data.timers.firstIndex(where: {$0.id == timer.id})!
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: Binding(get: {self.data.timers[self.timerIndex].name}, set: {self.data.timers[self.timerIndex].name = $0}))
                Text(String(self.data.timers[self.timerIndex].interval))
                Text(self.data.timers[self.timerIndex].isActive ? "Running" : "Stopped")
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button("Delete") {
                            self.mode.wrappedValue.dismiss()
//                            self.data.timers.remove(at: self.timerIndex)
                        }
                        Button(self.data.timers[self.timerIndex].isActive ? "Pause" : "Continue") {
                            self.data.timers[self.timerIndex].isActive.toggle()
                        }
                    }
                }
            }
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
