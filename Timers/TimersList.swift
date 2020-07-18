//
//  TimersList.swift
//  Timers
//
//  Created by Matt on 16/07/2020.
//

import SwiftUI
import UserNotifications

struct TimersList: View {
    @EnvironmentObject var data: Data
    @State private var editMode = EditMode.inactive
    @State var secondsTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(data.timers) { timer in
                        NavigationLink(destination: TimerDetail(timer: timer)) {
                            TimerRow(timer: timer)
                        }
                        .environmentObject(self.data)
                    }
                    .onDelete(perform: onDelete)
                    .onMove(perform: onMove)
                }
                .navigationBarTitle(Text("Timers"))
                .navigationBarItems(leading: EditButton(), trailing: addButton)
                .environment(\.editMode, $editMode)
            }
        }
        .onAppear(perform: {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.sound,.alert]) { (_, _) in
            }
        })
        .onReceive(self.secondsTimer) { (_) in
            for var timer in self.data.timers {
                if timer.isActive {
                    if timer.remaining > 0 {
                        timer.remaining -= 1
                        self.data.timers[self.data.timers.firstIndex(where: {$0.id == timer.id})!] = timer
                    }
                    else
                    {
                        timer.isActive.toggle()
                        self.data.timers[self.data.timers.firstIndex(where: {$0.id == timer.id})!] = timer
                        self.notify()
                    }
                }
            }
        }
    }
    
    private var addButton: some View {
        switch editMode {
        case .inactive:
            return AnyView(Button(action: onAdd) { Image(systemName: "plus")})
        default:
            return AnyView(EmptyView())
        }
    }
    
    func onDelete(at offsets: IndexSet) {
        data.timers.remove(atOffsets: offsets)
    }
    
    func onMove(source: IndexSet, destination: Int) {
        data.timers.move(fromOffsets: source, toOffset: destination)
    }
    
    func onAdd() {
        let timerDetail = TimerDetail(timer: NamedTimer(name: ""))
//        if (timerDetail.timer) {
        data.timers.append(timerDetail.timer)
//        }
    }
    
    func notify() {
        let content = UNMutableNotificationContent()
        content.title = "Timers"
        content.body = "Timer complete"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let req = UNNotificationRequest(identifier: "MSG", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    }
}


struct TimersList_Previews: PreviewProvider {
    static var previews: some View {
        TimersList()
    }
}
