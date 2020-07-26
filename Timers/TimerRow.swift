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
        VStack {
            HStack {
                NavigationLink(
                    destination: TimerDetail(timer: timer)
                        .environmentObject(data)
                ) {
                    Text(timer.name)
                    Spacer()
                    Text(self.data.timers[self.timerIndex].intervalToString())
                        .padding(.trailing, 10.0)
                        .frame(minWidth: 90, alignment: .trailing)
                }
            }
            .padding(.bottom, 5)
            HStack {
                //            VStack {
                //                if self.data.timers[self.timerIndex].isActive || self.data.timers[self.timerIndex].interval != 0 {
                Button(action: {self.data.timers[self.timerIndex].isActive.toggle()}) {
                    Text(self.data.timers[self.timerIndex].isActive ? "Pause" : "Continue").foregroundColor(.white)
                }
                .frame(minWidth: 100, idealWidth: 100, maxWidth: .infinity, minHeight: 35, alignment: .center)
                .background(Color.blue)
                .cornerRadius(22)
                .padding(.trailing, 5)
                //                }
                Spacer()
                Button(action: {
                    self.data.timers[self.timerIndex].interval = self.data.timers[self.timerIndex].initialInterval
                    self.data.timers[self.timerIndex].isActive = true
                }, label: {
                    Text("Restart").foregroundColor(.white)
                })
                .frame(minWidth: 100, idealWidth: 100, maxWidth: .infinity, minHeight: 35, alignment: .center)
                .background(Color.blue)
                .cornerRadius(22)
                .padding(.leading, 5)
                //            }
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10)
    }
}

struct TimerRow_Previews: PreviewProvider {
    static var previews: some View {
        TimerRow(timer: NamedTimer(name: "Example", duration: 60))
    }
}
