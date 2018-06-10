//
//  Client+CoreDataProperties.swift
//  HelloCoreData
//
//  Created by 楊昇融 on 2018/1/8.
//  Copyright © 2018年 楊昇融. All rights reserved.
//
//

import Foundation
import CoreData


extension Client {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Client> {
        return NSFetchRequest<Client>(entityName: "Client")
    }

    @NSManaged public var basic_others: String?
    @NSManaged public var buildBasicConcept_others: String?
    @NSManaged public var buildBasicConceptBasket: Bool
    @NSManaged public var buildBasicConceptFourQ: Bool
    @NSManaged public var buildBasicConceptLifeTour: Bool
    @NSManaged public var buildBasicConceptMeal: Bool
    @NSManaged public var buildBasicConceptYoungMan: Bool
    @NSManaged public var children: String?
    @NSManaged public var date: String?
    @NSManaged public var decideRight: Bool
    @NSManaged public var decideRight2: Bool
    @NSManaged public var fivePointDemand_orhers: String?
    @NSManaged public var fivePointDemandAssetTransport: Bool
    @NSManaged public var fivePointDemandCareRefund: Bool
    @NSManaged public var fivePointDemandLifeGuarantee: Bool
    @NSManaged public var fivePointDemandMedicalGuarantee: Bool
    @NSManaged public var fivePointDemandRetireRefund: Bool
    @NSManaged public var history: String?
    @NSManaged public var insuranceConcept: Bool
    @NSManaged public var insuranceConcept2: Bool
    @NSManaged public var interesting: String?
    @NSManaged public var lifeProblem_others: String?
    @NSManaged public var lifeProblemNoSense: Bool
    @NSManaged public var lifeProblemNoService: Bool
    @NSManaged public var lifeProblemWorkUnstable: Bool
    @NSManaged public var mainProduct_others: String?
    @NSManaged public var mainProductAustralia: Bool
    @NSManaged public var mainProductLongCare: Bool
    @NSManaged public var mainProductMedicalStrong: Bool
    @NSManaged public var mainProductUSAAndTW: Bool
    @NSManaged public var mainProductWealthAndHappy: Bool
    @NSManaged public var married: String?
    @NSManaged public var mortage: String?
    @NSManaged public var name: String?
    @NSManaged public var oppositeProblem_others: String?
    @NSManaged public var oppositeProblemBuyTooMore: Bool
    @NSManaged public var oppositeProblemConsidering: Bool
    @NSManaged public var oppositeProblemDiscussing: Bool
    @NSManaged public var oppositeProblemFriend: Bool
    @NSManaged public var oppositeProblemHealthHistory: Bool
    @NSManaged public var oppositeProblemInvestOthers: Bool
    @NSManaged public var oppositeProblemNoMoney: Bool
    @NSManaged public var personalityTraits_C: Bool
    @NSManaged public var personalityTraits_D: Bool
    @NSManaged public var personalityTraits_I: Bool
    @NSManaged public var personalityTraits_others: String?
    @NSManaged public var personalityTraits_S: Bool
    @NSManaged public var phone: String?
    @NSManaged public var reasonCome: Int16
    @NSManaged public var salary: Int16
    @NSManaged public var salary2: String?
    @NSManaged public var salePlan: String?
    @NSManaged public var sense: Bool
    @NSManaged public var sense2: Bool
    @NSManaged public var seperate: String?
    @NSManaged public var seventh_mainProduct_lifeGuarantee: String?
    @NSManaged public var seventh_mainProduct_medicalCare: String?
    @NSManaged public var seventh_mainProduct_moneySaving: String?
    @NSManaged public var seventh_mainProduct_others: String?
    @NSManaged public var sex: String?
    @NSManaged public var strategy_others: String?
    @NSManaged public var strategyCardHeart: Bool
    @NSManaged public var strategyEvent: Bool
    @NSManaged public var strategyHealthPassword: Bool
    @NSManaged public var strategyMedicalHome: Bool
    @NSManaged public var strategyPeriodical: Bool
    @NSManaged public var strategyTaxationLecture: Bool
    @NSManaged public var updateStatus: Int16
    @NSManaged public var work: String?
    @NSManaged public var year: String?
    @NSManaged public var normalTOeventName: Event?
    @NSManaged public var normalTOeventPhone: Event?
    @NSManaged public var normalTOnoteBuildDate: Note?
    @NSManaged public var normalTOnoteName: Note?
    @NSManaged public var normalTOnotePhone: Note?

}
