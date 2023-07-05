//
//  TargetData+CoreDataProperties.swift
//  Task
//
//  Created by Andrey on 06.07.2023.
//
//

import Foundation
import CoreData


extension TargetData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TargetData> {
        return NSFetchRequest<TargetData>(entityName: "TargetData")
    }

    @NSManaged public var targetCount: Int16

}

extension TargetData : Identifiable {

}
