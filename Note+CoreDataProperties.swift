//
//  Note+CoreDataProperties.swift
//  HelloCoreData
//
//  Created by 楊昇融 on 2018/1/14.
//  Copyright © 2018年 楊昇融. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var clientBuildDate: String?
    @NSManaged public var clientName: String?
    @NSManaged public var clientPhoneNumber: String?
    @NSManaged public var content: String?
    @NSManaged public var creatDate: String?
    @NSManaged public var updateStatus: Int16
    @NSManaged public var normalTOnoteBuildDate: Client?
    @NSManaged public var normalTOnoteName: Client?
    @NSManaged public var normalTOnotePhone: Client?
    @NSManaged public var ocTOnoteBuildDate: OrangeClient?
    @NSManaged public var ocTOnoteName: OrangeClient?
    @NSManaged public var ocTOnotePhone: OrangeClient?

}
