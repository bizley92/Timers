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
                        TimerRow(timer: timer)
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
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.sound,.alert]) { granted, error in
            }
        })
        .onReceive(self.secondsTimer) { (_) in
            for timer in self.data.timers {
                if timer.isActive {
                    if timer.interval > 0 {
                        timer.interval -= 1
                        self.data.timers[self.data.timers.firstIndex(where: {$0.id == timer.id})!] = timer
                    }
                    else
                    {
                        timer.isActive.toggle()
                        self.data.timers[self.data.timers.firstIndex(where: {$0.id == timer.id})!] = timer
//                        self.notify(timer: timer)
                    }
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.data.timers.map {
                if $0.isActive {
                    $0.isActive = false
                    $0.stoppedTime = Date()
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            let timeInterval = Date()
            self.data.timers.map {
                if $0.stoppedTime != nil {
                    $0.isActive = true
                    $0.interval = $0.interval - Date().timeIntervalSince(timeInterval)
                    $0.stoppedTime = nil
                }
            }
        }
    }
    
    private var addButton: some View {
        switch editMode {
        case .inactive:
            return AnyView(
                NavigationLink(
                    destination: AddTimer()
                        .environmentObject(data),
                    label: {
                        Text("Add")
                    }))
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
    
//    func notify(timer: NamedTimer, notificationInterval: TimeInterval = 0) {
//        let content = UNMutableNotificationContent()
//        content.title = "Timer complete"
//        content.body = "Name: \(timer.name)"
//        content.sound = UNNotificationSound.default
//
//        var trigger: UNTimeIntervalNotificationTrigger? = nil
//        if notificationInterval > 0 {
//            trigger = UNTimeIntervalNotificationTrigger(timeInterval: notificationInterval, repeats: false)
//        }
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request)
//    }
}


struct TimersList_Previews: PreviewProvider {
    static var previews: some View {
        TimersList()
    }
}
