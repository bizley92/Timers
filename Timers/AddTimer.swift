//
//  AddTimer.swift
//  Timers
//
//  Created by Matt on 25/07/2020.
//

import SwiftUI

struct AddTimer: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var data: Data
    @State var duration: TimeInterval = TimeInterval(60)
    @State var name: String = ""
    
//    var timerIndex: Int {
//        data.timers.firstIndex(where: {$0.id == timer.id})!
//    }
    
    var body: some View {
        
        NavigationView {
            Form {
                DurationPicker(duration: Binding(get: {self.duration}, set: {self.duration = $0}))
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
                            self.data.timers.append(NamedTimer(name: self.name, duration: self.duration))
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
