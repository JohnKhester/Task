//
//  TaskData+CoreDataProperties.swift
//  Task
//
//  Created by Andrey on 02.07.2023.
//
//

import Foundation
import CoreData


extension TaskData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskData> {
        return NSFetchRequest<TaskData>(entityName: "TaskData")
    }

    @NSManaged public var completedTaskCount: Int16
    @NSManaged public var isDone: Bool
    @NSManaged public var titleTask: String?
    @NSManaged public var deadline: Date?

}

extension TaskData : Identifiable {

}