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
    @State var timerActionString = "Pause"
    
    func setTimerActionString() -> Void {
        timerActionString = timer.isActive ? "Pause" : "Continue"
    }
    
    var body: some View {
        VStack {
            HStack {
                NavigationLink(
                    destination: TimerDetail(timer: timer)
                        .environmentObject(data)
                ) {
                    Text(timer.name)
                        .font(.system(size: 22))
                        .lineLimit(2)
                        .frame(minWidth: 110, idealWidth: 170, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 35, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
//                    Spacer()
                    Text(timer.intervalToString())
                        .frame(minWidth: 30, idealWidth: 130, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 35, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                        .font(Font.title.monospacedDigit())
//                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .padding(.trailing, 2)
                }
            }
            .padding(.bottom, 5)
            HStack {
                //            VStack {
                if timer.interval > 0 {
                Button(action: {
                    timer.isActive.toggle()
                    setTimerActionString()
                    if timer.isActive {
                        timer.addNotification()
                    } else {
                        timer.cancelNotification()
                    }
                }) {
                    Text(timerActionString).foregroundColor(.white)
                }
                .frame(minWidth: 100, idealWidth: 100, maxWidth: .infinity, minHeight: 35, alignment: .center)
                .background(Color.blue)
                .cornerRadius(22)
                .padding(.trailing, 5)
                Spacer()
                }
                Button(action: {timer.reset()}, label: {
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
