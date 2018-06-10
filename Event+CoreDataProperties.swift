//
//  Event+CoreDataProperties.swift
//  HelloCoreData
//
//  Created by User on 2017/3/13.
//  Copyright © 2017年 楊昇融. All rights reserved.
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event");
    }

    @NSManaged public var clientClass: String?
    @NSManaged public var clientYear: String?
    @NSManaged public var eventClientName: String?
    @NSManaged public var eventClientPhone: String?
    @NSManaged public var eventClientSeperate: String?
    @NSManaged public var eventDate: String?
    @NSManaged public var eventDone: Bool
    @NSManaged public var identifier: String?

}
