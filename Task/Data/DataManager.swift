//
//  DataManager.swift
//  Task
//
//  Created by Andrey on 30.06.2023.
//

import CoreData
import Foundation

class DataManager: NSObject, ObservableObject {
    let container: NSPersistentContainer = NSPersistentContainer(name: "DataModel")
    override init() {
        super.init()
        container.loadPersistentStores { _, _ in }
    }
}

