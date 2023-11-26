//
//  CoreDataBootcampApp.swift
//  CoreDataBootcamp
//
//  Created by Hassan Alkhafaji on 11/25/23.
//

import SwiftUI

@main
struct CoreDataBootcampApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
