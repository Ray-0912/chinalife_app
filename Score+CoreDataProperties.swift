//
//  Score+CoreDataProperties.swift
//  HelloCoreData
//
//  Created by User on 2017/3/13.
//  Copyright © 2017年 楊昇融. All rights reserved.
//

import Foundation
import CoreData


extension Score {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Score> {
        return NSFetchRequest<Score>(entityName: "Score");
    }

    @NSManaged public var dateSelf: String?
    @NSManaged public var deal: String?
    @NSManaged public var digDemand: String?
    @NSManaged public var explain: String?
    @NSManaged public var firstFace: String?
    @NSManaged public var getDate: String?
    @NSManaged public var introduction: String?
    @NSManaged public var percent: String?
    @NSManaged public var todayDate: String?
    @NSManaged public var total: String?

}
