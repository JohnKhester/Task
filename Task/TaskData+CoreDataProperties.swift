//
//  TaskData+CoreDataProperties.swift
//  Task
//
//  Created by Andrey on 06.07.2023.
//
//

import Foundation
import CoreData


extension TaskData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskData> {
        return NSFetchRequest<TaskData>(entityName: "TaskData")
    }

    @NSManaged public var completedTaskCount: Int16
    @NSManaged public var deadline: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var isDone: Bool
    @NSManaged public var titleTask: String?

}

extension TaskData : Identifiable {

}
