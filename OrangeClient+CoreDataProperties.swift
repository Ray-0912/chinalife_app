//
//  OrangeClient+CoreDataProperties.swift
//  HelloCoreData
//
//  Created by 楊昇融 on 2018/1/8.
//  Copyright © 2018年 楊昇融. All rights reserved.
//
//

import Foundation
import CoreData


extension OrangeClient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrangeClient> {
        return NSFetchRequest<OrangeClient>(entityName: "OrangeClient")
    }

    @NSManaged public var basic_other: String?
    @NSManaged public var buildDate: String?
    @NSManaged public var children: String?
    @NSManaged public var education: String?
    @NSManaged public var eighth_objectionProblem_familyOpposite: Bool
    @NSManaged public var eighth_objectionProblem_incomeUnstable: Bool
    @NSManaged public var eighth_objectionProblem_marketSaturation: Bool
    @NSManaged public var eighth_objectionProblem_noBusiness: Bool
    @NSManaged public var eighth_objectionProblem_noClient: Bool
    @NSManaged public var eighth_objectionProblem_others: String?
    @NSManaged public var fifth_careerConcept_duelCareer: Bool
    @NSManaged public var fifth_careerConcept_ESBI: Bool
    @NSManaged public var fifth_careerConcept_introduceTeam: Bool
    @NSManaged public var fifth_careerConcept_others: String?
    @NSManaged public var fifth_careerConcept_threeLineInLife: Bool
    @NSManaged public var fourht_fivePointDemand_others: String?
    @NSManaged public var fourth_fivePointDeamnd_prospect: Bool
    @NSManaged public var fourth_fivePointDemand_chancePromotion: Bool
    @NSManaged public var fourth_fivePointDemand_growUp: Bool
    @NSManaged public var fourth_fivePointDemand_resonablePay: Bool
    @NSManaged public var fourth_fovePointDemand_worthOnWork: Bool
    @NSManaged public var live: String?
    @NSManaged public var married: String?
    @NSManaged public var mateWork: String?
    @NSManaged public var name: String?
    @NSManaged public var ninth_salePlan: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var reason: Bool
    @NSManaged public var reason2: String?
    @NSManaged public var salary: String?
    @NSManaged public var sec_personalityTraits_C: Bool
    @NSManaged public var sec_personalityTraits_D: Bool
    @NSManaged public var sec_personalityTraits_haveTarget: Bool
    @NSManaged public var sec_personalityTraits_I: Bool
    @NSManaged public var sec_personalityTraits_likeFreedomLife: Bool
    @NSManaged public var sec_personalityTraits_makeMoney: Bool
    @NSManaged public var sec_personalityTraits_nowUnstable: Bool
    @NSManaged public var sec_personalityTraits_others: String?
    @NSManaged public var sec_personalityTraits_S: Bool
    @NSManaged public var sec_personalityTraits_wantBeLeader: Bool
    @NSManaged public var seniority: String?
    @NSManaged public var seventh_mainProduct_lifeGuarantee: String?
    @NSManaged public var seventh_mainProduct_medicalCare: String?
    @NSManaged public var seventh_mainProduct_moneySaving: String?
    @NSManaged public var seventh_mainProduct_others: String?
    @NSManaged public var sex: String?
    @NSManaged public var sixth_stragegy_eventDepartment: String?
    @NSManaged public var sixth_stragegy_eventPersonal: String?
    @NSManaged public var sixth_stragegy_eventWork: String?
    @NSManaged public var sixth_stragegy_others: String?
    @NSManaged public var sixth_stragegy_prefessionTrain: String?
    @NSManaged public var sixth_stragegy_professionBasic: String?
    @NSManaged public var sixth_stragegy_professionLicenses: String?
    @NSManaged public var third_lifeProblem_home: String?
    @NSManaged public var third_lifeProblem_others: String?
    @NSManaged public var third_lifeProblem_work: String?
    @NSManaged public var traffic: String?
    @NSManaged public var updateStatus: Int16
    @NSManaged public var work: String?
    @NSManaged public var year: String?
    @NSManaged public var ocTOeventName: Event?
    @NSManaged public var ocTOeventPhoneNumber: Event?
    @NSManaged public var ocTOnoteBuildDate: Note?
    @NSManaged public var ocTOnoteName: Note?
    @NSManaged public var ocTOnotePhone: Note?

}
