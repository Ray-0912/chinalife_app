//
//  AccData+CoreDataProperties.swift
//  HelloCoreData
//
//  Created by 楊昇融 on 2018/1/6.
//  Copyright © 2018年 楊昇融. All rights reserved.
//
//

import Foundation
import CoreData


extension AccData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccData> {
        return NSFetchRequest<AccData>(entityName: "AccData")
    }

    @NSManaged public var userAccount: String?
    @NSManaged public var userNumber: String?
    @NSManaged public var userPassword: String?

}
