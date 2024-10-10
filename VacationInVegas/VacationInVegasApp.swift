//
//  VacationInVegasApp.swift
//  VacationInVegas
//
//  Created by Nasir on 09/10/24.
//

import SwiftUI

@main
struct VacationInVegasApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
//        for production we'll use this
        .modelContainer(for: Place.self)
    }
}
