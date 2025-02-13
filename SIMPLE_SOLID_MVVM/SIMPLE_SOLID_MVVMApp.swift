//
//  SIMPLE_SOLID_MVVMApp.swift
//  SIMPLE_SOLID_MVVM
//
//  Created by Arthdi Putra Anna on 12/02/25.
//

import SwiftUI
import CoreData

@main
struct SIMPLE_SOLID_MVVMApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}


struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "MovieModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
