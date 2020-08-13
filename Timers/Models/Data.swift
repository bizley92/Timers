//
//  Data.swift
//  Timers
//
//  Created by Matt on 18/07/2020.
//

import SwiftUI

final class Data: ObservableObject {
    @Published var timers: [NamedTimer] = []
}
