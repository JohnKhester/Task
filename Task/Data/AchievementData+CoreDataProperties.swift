//
//  AchievementData+CoreDataProperties.swift
//  Task
//
//  Created by Andrey on 02.07.2023.
//
//

import Foundation
import CoreData


extension AchievementData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AchievementData> {
        return NSFetchRequest<AchievementData>(entityName: "AchievementData")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isUnlocked: Bool

}

extension AchievementData : Identifiable {

}
