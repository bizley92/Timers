//
//  AddTimer.swift
//  Timers
//
//  Created by Matt on 25/07/2020.
//

import SwiftUI
import Combine

struct AddTimer: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var data: Data
    @State var duration = TimeInterval(60)
    @State var name = ""
    @State var time = 0
    
    var body: some View {
//        let formattedNumber = Binding<String>(
//                    get: {
//                        switch self.time {
//                        case ..<0: return "???"
//                        case ..<10: return "00:00:0\(self.time)"
//                        case ..<100: return "00:00:\(self.time)"
//                        case ..<1000: return "00:0:\(self.time)"
//                        case ..<10000: return "00:\(self.time)"
//                        case ..<100000: return "0\(self.time)"
//                        case 100...: return String(format: "%02f", Double(self.time)/100)
//                        default: return "???"
//                        }
//                },
//                    set: {
//                        if let value = NumberFormatter().number(from: $0) {
//                            self.time = value.intValue
//                        }
//                    }
//                )
        NavigationView {
            Form {
                DurationPicker(duration: Binding(get: {self.duration}, set: {self.duration = $0}))
//                TextField("Time", text: formattedNumber)
                    .keyboardType(.numberPad)
                TextField("Optional name", text: $name)
//                Text(String(self.data.timers[self.timerIndex].remaining))
//                Text(timer.isActive ? "Running" : "Stopped")
                
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
//                        Button("Cancel") {
//                            print("Cancelled")
//                        }
                        Button("Start") {
//                            self.data.timers.append(NamedTimer(name: self.name, duration: self.duration))
                            self.data.timers.append(NamedTimer(name: self.name, duration: TimeInterval(self.duration)))
                            self.mode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }
}

struct AddTimer_Previews: PreviewProvider {
    static var previews: some View {
        let data = Data()
        AddTimer()
            .environmentObject(data)
    }
}
