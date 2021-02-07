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
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: Binding(get: {timer.name}, set: {timer.name = $0}))
                Text(timer.intervalToString())
                Text(timer.isActive ? "Running" : "Stopped")
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button("Delete") {
                            self.mode.wrappedValue.dismiss()
//                            self.data.timers.remove(at: self.timerIndex)
                        }
                        Button(timer.isActive ? "Pause" : "Continue") {
                            timer.isActive.toggle()
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
