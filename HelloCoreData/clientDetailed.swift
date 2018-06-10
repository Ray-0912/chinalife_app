//
//  ViewController.swift
//  HelloCoreData
//
//  Created by 楊昇融 on 2017/2/7.
//  Copyright © 2017年 楊昇融. All rights reserved.
//

import UIKit
import EventKit

class clientDetailed: UIViewController,UIPopoverPresentationControllerDelegate,passParameter,ChildrenPickpassParameter,ChildrenPickpassParameter2,UITextFieldDelegate {
    
    func passParameter(Str: String){

        let split = Str.components(separatedBy: ",")
        txt_year.text = split[0]
        TheBirth = split[1]
        
    }
    func  ChildrenPickpassParameter(Str: String){
        
        
        txt_children.text = Str
        
    }
    
    
    func  ChildrenPickpassParameter2(Str: String){
        
        
        txt_married.text = Str
        
    }
    var update : Int16 = 0
    
    var preName : String = ""
    var preSex : String = ""
    var preBuildDate : String = ""
    var preYear : String = ""
    var TheBirth : String = ""
  
    var clientClass : String = "一般"
    var index :Int = 0
    var isSearchState : Bool?
    var passName: String = ""
    var passSex: String = ""
    var passBuildDate : String = ""
    var nameArr : [module] = [module]()
    
    
    @IBOutlet weak var txt_name: UITextField!
    @IBOutlet weak var btn_reasonA: UIButton! //緣故
    @IBOutlet weak var btn_reasonB: UIButton! //隨緣
    @IBOutlet weak var btn_reasonC: UIButton! //轉介紹
    @IBOutlet weak var txt_buildDate: UITextField!
    
    @IBOutlet weak var btn_boy: UIButton!
    @IBOutlet weak var btn_girl: UIButton!
    
    var reason : Int16 = 4 //reasonA=0 , reasonB=1 , reasonC=2
    var sex : String = ""
    
    //1.基本資料
    
    @IBOutlet weak var txt_phone: UITextField!
    @IBOutlet weak var txt_year: UITextField!
    @IBOutlet weak var txt_children: UITextField!
    @IBOutlet weak var txt_married: UITextField!
    @IBOutlet weak var txt_motage: UITextField!
    @IBOutlet weak var txt_work: UITextField!
    @IBOutlet weak var txt_salary: UITextField!
    @IBOutlet weak var txt_interesting: UITextField!
    @IBOutlet weak var txt_history: UITextField!
    @IBOutlet weak var txt_basicOthers: UITextField!
    
    //2.人格特質
    @IBOutlet weak var txt_personalityTraitsOthers: UITextField!
    @IBOutlet weak var sec_perD: UIButton!
    @IBOutlet weak var sec_perI: UIButton!
    @IBOutlet weak var sec_perS: UIButton!
    @IBOutlet weak var sec_perC: UIButton!
    @IBOutlet weak var sec_decideYes: UIButton!
    @IBOutlet weak var sec_decideNo: UIButton!
    @IBOutlet weak var sec_conceptYes: UIButton!
    @IBOutlet weak var sec_conceptNo: UIButton!
    @IBOutlet weak var sec_senseYes: UIButton!
    @IBOutlet weak var sec_senseNo: UIButton!
    
    
    var secPersonalityTraits_D : Bool = false
    var secPersonalityTraits_I : Bool = false
    var secPersonalityTraits_S : Bool = false
    var secPersonalityTraits_C : Bool = false
    
    var secDecidedRight : Bool = false
    var secAntiDecidedRight : Bool = false
    
    var secInsuranceConcept : Bool = false
    var secAntiInsuranceConcept : Bool = false
    
    var secSense : Bool = false
    var secAntiSense : Bool = false
    
    //3.人生問題
    @IBOutlet weak var txt_lifeProblemOthers: UITextField!
    @IBOutlet weak var third_noService: UIButton!
    @IBOutlet weak var third_workUnstable: UIButton!
    @IBOutlet weak var third_unclear: UIButton!
    
    var thirdLifeProblem_noService : Bool = false
    var thirdLifeProblem_workUnstable : Bool = false
    var thirdLifeProblem_noSense : Bool = false
    
    
    //4.五大需求
    @IBOutlet weak var txt_fivePointDemandOthers: UITextField!
    @IBOutlet weak var fourth_retireFund: UIButton!
    @IBOutlet weak var fourth_lifeGuarantee: UIButton!
    @IBOutlet weak var fourth_medicalGuarantee: UIButton!
    @IBOutlet weak var fourth_careFund: UIButton!
    @IBOutlet weak var fourth_assetTrans: UIButton!
    
    var fourthFivePointDemand_retireRefund : Bool = false
    var fourthFivePointDemand_lifeGuarantee : Bool = false
    var fourthFivePointDemand_medicalGuarantee : Bool = false
    var fourthFivePointDemand_careRefund : Bool = false
    var fourthFivePointDemand_assetTransport : Bool = false
    
    
    //5.建立保險觀念
    @IBOutlet weak var txt_buidConceptOthers: UITextField!
    @IBOutlet weak var fifth_youngMan: UIButton!
    @IBOutlet weak var fifth_lifeTour: UIButton!
    @IBOutlet weak var fifth_basket: UIButton!
    @IBOutlet weak var fifth_fourQ: UIButton!
    @IBOutlet weak var fifth_meal: UIButton!
    
    var fifthBuildConcept_youngMan : Bool = false
    var fifthBuildConcept_lifeTour : Bool = false
    var fifthBuildConcept_basket : Bool = false
    var fifthBuildConcept_fourQ : Bool = false
    var fifthBuildConcept_meal : Bool = false
    
    
    //6.策略
    @IBOutlet weak var txt_strategyOthers: UITextField!
    @IBOutlet weak var six_healthPassport: UIButton!
    @IBOutlet weak var six_cardHeart: UIButton!
    @IBOutlet weak var six_medicalHome: UIButton!
    @IBOutlet weak var six_taxationLexture: UIButton!
    @IBOutlet weak var six_event: UIButton!
    @IBOutlet weak var six_periodical: UIButton!
    
    var sixthStrategy_healthPassword : Bool = false
    var sixthStrategy_cardHeart : Bool = false
    var sixthStrategy_medicalHome : Bool = false
    var sixthStrategy_taxationLexture : Bool = false
    var sixthStrategy_event : Bool = false
    var sixthStrategy_periodical : Bool = false
    
    
    //7.主力商品
    @IBOutlet weak var txt_mainProductOthers: UITextField!
    @IBOutlet weak var seventh_lifeGuarantee: UITextField!
    @IBOutlet weak var seventh_medicalCare: UITextField!
    @IBOutlet weak var seventh_savingMoney: UITextField!
    @IBOutlet weak var seventh_wealthAndHappy: UIButton!
    @IBOutlet weak var seventh_longCare: UIButton!
    @IBOutlet weak var seventh_medicalStrong: UIButton!
    @IBOutlet weak var seventh_USAandTW: UIButton!
    @IBOutlet weak var seventh_Australia: UIButton!
    
    var seventhMainProduct_wealthAndHappy : Bool = false
    var seventhMainProduct_longCare : Bool = false
    var seventhMainProduct_medicalStrong : Bool = false
    var seventhMainProduct_USAandTW : Bool = false
    var seventhMainProduct_Australia : Bool = false
    
    
    //8.反對問題
    @IBOutlet weak var txt_oppositeProblemOthers: UITextField!
    @IBOutlet weak var eighth_noMoney: UIButton!
    @IBOutlet weak var eighth_buyTooMore: UIButton!
    @IBOutlet weak var eighth_considering: UIButton!
    @IBOutlet weak var eighth_discussing: UIButton!
    @IBOutlet weak var eighth_friend: UIButton!
    @IBOutlet weak var eighth_history: UIButton!
    @IBOutlet weak var eighth_investOthers: UIButton!
    
    var eighthOppositeProblem_noMoney : Bool = false
    var eighthOppositeProblem_buyTooMore : Bool = false
    var eighthOppositeProblem_considering : Bool = false
    var eighthOppositeProblem_discussing : Bool = false
    var eighthOppositeProblem_friend : Bool = false
    var eighthOppositeProblem_healthHistory : Bool = false
    var eighthOppositeProblem_investOthers : Bool = false
    
    //9.行銷計畫
    @IBOutlet weak var txt_salePlan: UITextField!
    
    @IBAction func btn_sex(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            sender.setImage(UIImage(named:"check"), for: .normal)
            btn_girl.setImage(UIImage(named:"checkbox"), for: .normal)
            sex = "男"
        default:
            sender.setImage(UIImage(named:"check"), for: .normal)
            btn_boy.setImage(UIImage(named:"checkbox"), for: .normal)
            sex = "女"
        }
    }
    
    @IBAction func marryPick(_ sender: Any) {
        
        performSegue(withIdentifier: "popover_marry", sender: self)
    }
    @IBAction func childrenPick(_ sender: Any) {
        
        performSegue(withIdentifier: "popover_child", sender: self)
    }
    
    @IBAction func yearpick(_ sender: Any) {
        
        performSegue(withIdentifier: "popover_date", sender: self)
        
    }
 
    
    @IBAction func reason(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            sender.setImage(UIImage(named:"check"), for: .normal)
            btn_reasonB.setImage(UIImage(named:"checkbox"), for: .normal)
            btn_reasonC.setImage(UIImage(named:"checkbox"), for: .normal)
            reason = Int16(sender.tag)
        case 1:
            sender.setImage(UIImage(named:"check"), for: .normal)
            btn_reasonA.setImage(UIImage(named:"checkbox"), for: .normal)
            btn_reasonC.setImage(UIImage(named:"checkbox"), for: .normal)
            reason = Int16(sender.tag)
        default:
            sender.setImage(UIImage(named:"check"), for: .normal)
            btn_reasonA.setImage(UIImage(named:"checkbox"), for: .normal)
            btn_reasonB.setImage(UIImage(named:"checkbox"), for: .normal)
            reason = Int16(sender.tag)
        }
    }
    
    @IBAction func btn_sec_personalityTraits(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            sender.setImage(UIImage(named:(secPersonalityTraits_D ? "checkbox" : "check")), for: .normal)
            secPersonalityTraits_D = secPersonalityTraits_D ? false : true
        case 1:
            sender.setImage(UIImage(named:(secPersonalityTraits_I ? "checkbox" : "check")), for: .normal)
            secPersonalityTraits_I = secPersonalityTraits_I ? false : true
        case 2:
            sender.setImage(UIImage(named:(secPersonalityTraits_S ? "checkbox" : "check")), for: .normal)
            secPersonalityTraits_S = secPersonalityTraits_S ? false : true
        default:
            sender.setImage(UIImage(named:(secPersonalityTraits_C ? "checkbox" : "check")), for: .normal)
            secPersonalityTraits_C = secPersonalityTraits_C ? false : true
        }
    }
    
    @IBAction func btn_sec_decidedRight(_ sender: UIButton) {
        switch sender.tag {
        case 0 :
            sender.setImage(UIImage(named : "check"), for: .normal)
            sec_decideNo.setImage(UIImage(named : "checkbox"), for: .normal)
            secDecidedRight = true
            secAntiDecidedRight = false
        default :
            sender.setImage(UIImage(named:"check"), for: .normal)
            sec_decideYes.setImage(UIImage(named : "checkbox"), for: .normal)
            secAntiDecidedRight = true
            secDecidedRight = false
        }
    }
    
    @IBAction func btn_sec_insuranceConcept(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            sender.setImage(UIImage(named: "check"), for: .normal)
            sec_conceptNo.setImage(UIImage(named : "checkbox"), for: .normal)
            secInsuranceConcept = true
            secAntiInsuranceConcept = false
        default:
            sender.setImage(UIImage(named: "check"), for: .normal)
            sec_conceptYes.setImage(UIImage(named : "checkbox"), for: .normal)
            secInsuranceConcept = false
            secAntiInsuranceConcept = true
        }
    }
    
    @IBAction func btn_sec_sense(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            sender.setImage(UIImage(named: "check"), for: .normal)
            sec_senseNo.setImage(UIImage(named : "checkbox"), for: .normal)
            secSense = true
            secAntiSense = false
        default:
            sender.setImage(UIImage(named: "check"), for: .normal)
            sec_senseYes.setImage(UIImage(named : "checkbox"), for: .normal)
            secAntiSense = true
            secSense = false
        }
    }
    
    @IBAction func third_lifeProblem(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            sender.setImage(UIImage(named:(thirdLifeProblem_noService ? "checkbox" : "check")), for: .normal)
            thirdLifeProblem_noService = thirdLifeProblem_noService ? false : true
        case 1:
            sender.setImage(UIImage(named:(thirdLifeProblem_workUnstable ? "checkbox" : "check")), for: .normal)
            thirdLifeProblem_workUnstable = thirdLifeProblem_workUnstable ? false : true
        default:
            sender.setImage(UIImage(named:(thirdLifeProblem_noSense ? "checkbox" : "check")), for: .normal)
            thirdLifeProblem_noSense = thirdLifeProblem_noSense ? false : true
        }
    }
    
    @IBAction func btn_fourth_fivePointDemand(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            sender.setImage(UIImage(named:(fourthFivePointDemand_retireRefund ? "checkbox" : "check")), for: .normal)
            fourthFivePointDemand_retireRefund = fourthFivePointDemand_retireRefund ? false : true
        case 1:
            sender.setImage(UIImage(named:(fourthFivePointDemand_lifeGuarantee ? "checkbox" : "check")), for: .normal)
            fourthFivePointDemand_lifeGuarantee = fourthFivePointDemand_lifeGuarantee ? false : true
        case 2:
            sender.setImage(UIImage(named:(fourthFivePointDemand_medicalGuarantee ? "checkbox" : "check")), for: .normal)
            fourthFivePointDemand_medicalGuarantee = fourthFivePointDemand_medicalGuarantee ? false : true
        case 3:
            sender.setImage(UIImage(named:(fourthFivePointDemand_careRefund ? "checkbox" : "check")), for: .normal)
            fourthFivePointDemand_careRefund = fourthFivePointDemand_careRefund ? false : true
        default:
            sender.setImage(UIImage(named:(fourthFivePointDemand_assetTransport ? "checkbox" : "check")), for: .normal)
            fourthFivePointDemand_assetTransport = fourthFivePointDemand_assetTransport ? false : true
        }
    }
    
    
    
    func edit() {
        let appDel = UIApplication.shared.delegate as? AppDelegate
        
        rightButton3.isEnabled = true
        
        
        //確認是否有重複
        //當複合鍵沒有被修改過
        var checkwhetherduplicate : Bool = false
        do{
            guard let context2 =  appDel?.persistentContainer.viewContext else{ return }
            let result2 = try context2.fetch(Client.fetchRequest())
            for item in result2{
                let aClient = item as? Client
                
                if aClient?.name! == preName && aClient?.sex == preSex && aClient?.date! == preBuildDate && aClient?.year == preYear{
                    checkwhetherduplicate = true
                    break
                    
                }else{
                    checkwhetherduplicate = false
                    
                }
            }
        }catch let error as NSError{    print(error)    }
        
        
        //確認是否有重複
        //當複合鍵被修改過後
        var checkwhetherduplicate_MODIFY : Bool = false
        do{
            guard let context2 =  appDel?.persistentContainer.viewContext else{ return }
            let result2 = try context2.fetch(Client.fetchRequest())
            for item in result2{
                let aClient = item as? Client
                
                //若是文字框與資料庫值一樣且不與傳入值一樣的話代表重複
                if (aClient?.name! == txt_name.text! && aClient?.sex == sex && aClient?.date! == txt_buildDate.text! && aClient?.year == TheBirth) && (txt_name.text! != preName || sex != preSex || txt_buildDate.text! != preBuildDate || TheBirth != preYear){
                    checkwhetherduplicate_MODIFY = true
                   
                    break
                    
                }else{
                    
                    checkwhetherduplicate_MODIFY = false
                   
                    
                }
            }
        }catch let error as NSError{    print(error)    }
        
        
        
        
        if txt_name.text == "" {  //若名字沒打的話顯示錯誤
            let alert = UIAlertController(title: "錯誤", message: "姓名還沒填喔！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) {
                (action:UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            present(alert , animated: true,completion:  nil)
            
            
            //若名字有且這筆資料是沒有與資料庫裡資料重複
        }else if txt_name.text != "" {

            // 其複合鍵不與資料庫相同才能建立
            //點新增頁面進來的，沒有傳直，index == 10000
            if index >= 10000 && checkwhetherduplicate_MODIFY == false {
                
                //設置好資料庫儲存資料單位aClient
                guard let context =  appDel?.persistentContainer.viewContext else{ return }
                let aClient = Client(context: context)
                
                aClient.name = txt_name.text
                aClient.reasonCome = reason
                aClient.sex = sex
                aClient.date = txt_buildDate.text
                aClient.phone = txt_phone.text
                
                aClient.year = TheBirth
                
                aClient.married = txt_married.text
                aClient.work = txt_work.text
                if txt_salary.text == ""{
                    
                }else{
                    aClient.salary2 = txt_salary.text!
                }
                
                aClient.interesting = txt_interesting.text
                aClient.history = txt_history.text
                aClient.children = txt_children.text
                aClient.mortage = txt_motage.text
                aClient.basic_others = txt_basicOthers.text
                aClient.personalityTraits_D = secPersonalityTraits_D
                aClient.personalityTraits_I = secPersonalityTraits_I
                aClient.personalityTraits_S = secPersonalityTraits_S
                aClient.personalityTraits_C = secPersonalityTraits_C
                
                aClient.decideRight = secDecidedRight
                aClient.decideRight2 = secAntiDecidedRight
                
                aClient.insuranceConcept = secInsuranceConcept
                aClient.insuranceConcept2 = secAntiInsuranceConcept
                
                aClient.sense = secSense
                aClient.sense2 = secAntiSense
                
                aClient.personalityTraits_others = txt_personalityTraitsOthers.text
                aClient.lifeProblemNoService = thirdLifeProblem_noService
                aClient.lifeProblemWorkUnstable = thirdLifeProblem_workUnstable
                aClient.lifeProblemNoSense = thirdLifeProblem_noSense
                aClient.lifeProblem_others = txt_lifeProblemOthers.text
                aClient.fivePointDemandRetireRefund = fourthFivePointDemand_retireRefund
                aClient.fivePointDemandLifeGuarantee = fourthFivePointDemand_lifeGuarantee
                aClient.fivePointDemandMedicalGuarantee = fourthFivePointDemand_medicalGuarantee
                aClient.fivePointDemandCareRefund = fourthFivePointDemand_careRefund
                aClient.fivePointDemandAssetTransport = fourthFivePointDemand_assetTransport
                aClient.fivePointDemand_orhers = txt_fivePointDemandOthers.text
                aClient.buildBasicConceptYoungMan = fifthBuildConcept_youngMan
                aClient.buildBasicConceptLifeTour = fifthBuildConcept_lifeTour
                aClient.buildBasicConceptBasket = fifthBuildConcept_basket
                aClient.buildBasicConceptFourQ = fifthBuildConcept_fourQ
                aClient.buildBasicConceptMeal = fifthBuildConcept_meal
                aClient.buildBasicConcept_others = txt_buidConceptOthers.text
                aClient.strategyHealthPassword = sixthStrategy_healthPassword
                aClient.strategyCardHeart = sixthStrategy_cardHeart
                aClient.strategyMedicalHome = sixthStrategy_medicalHome
                aClient.strategyTaxationLecture = sixthStrategy_taxationLexture
                aClient.strategyEvent = sixthStrategy_event
                aClient.strategyPeriodical = sixthStrategy_periodical
                aClient.strategy_others = txt_strategyOthers.text
                
                //主力商品 新的～
                aClient.seventh_mainProduct_medicalCare = seventh_medicalCare.text
                aClient.seventh_mainProduct_lifeGuarantee = seventh_lifeGuarantee.text
                aClient.seventh_mainProduct_moneySaving = seventh_savingMoney.text
                aClient.seventh_mainProduct_others = txt_mainProductOthers.text
                aClient.salePlan = txt_salePlan.text
                aClient.oppositeProblemNoMoney = eighthOppositeProblem_noMoney
                aClient.oppositeProblemBuyTooMore = eighthOppositeProblem_buyTooMore
                aClient.oppositeProblemConsidering = eighthOppositeProblem_considering
                aClient.oppositeProblemDiscussing = eighthOppositeProblem_discussing
                aClient.oppositeProblemFriend = eighthOppositeProblem_friend
                aClient.oppositeProblemHealthHistory = eighthOppositeProblem_healthHistory
                aClient.oppositeProblemInvestOthers = eighthOppositeProblem_investOthers
                aClient.oppositeProblem_others = txt_oppositeProblemOthers.text
                
                aClient.seperate = "No"
                aClient.updateStatus = 0
                appDel?.saveContext()  //資料庫儲存
               
                performSegue(withIdentifier: "goNextToEnd", sender: nil)
                
                
                
                //在同一複合鍵（傳值內容）下得以修改資料
                //點客戶資料頁面進來的，有傳直,index == 客戶資料的索引值
            }else if index < 10000 && checkwhetherduplicate == true{
                
                
                //若是改了複合鍵的值，檢查是否與資料庫內容重複
                if checkwhetherduplicate_MODIFY == false{
                    let eventStore = EKEventStore()
                    
                    //設置好資料庫儲存資料單位aClient
                    do{
                        guard let context =  appDel?.persistentContainer.viewContext else{ return }
                        let result = try context.fetch(Client.fetchRequest())
                        for item in result{
                            let aClient = item as? Client
                            if (aClient?.name)! == preName && aClient?.date == preBuildDate && (aClient?.year)! == preYear && (aClient?.sex)! == preSex{
                                
                                aClient?.name = txt_name.text
                                aClient?.reasonCome = reason
                                aClient?.sex = sex
                                aClient?.date = txt_buildDate.text
                                aClient?.phone = txt_phone.text
                                aClient?.year = TheBirth
                                aClient?.married = txt_married.text
                                aClient?.work = txt_work.text
                                
                                if txt_salary.text! != ""{
                                    aClient?.salary2 = txt_salary.text!
                                }else{       }
                                
                                aClient?.interesting = txt_interesting.text
                                aClient?.history = txt_history.text
                                aClient?.children = txt_children.text
                                aClient?.mortage = txt_motage.text
                                aClient?.basic_others = txt_basicOthers.text
                                aClient?.personalityTraits_D = secPersonalityTraits_D
                                aClient?.personalityTraits_I = secPersonalityTraits_I
                                aClient?.personalityTraits_S = secPersonalityTraits_S
                                aClient?.personalityTraits_C = secPersonalityTraits_C
                                
                                aClient?.decideRight = secDecidedRight
                                aClient?.decideRight2 = secAntiDecidedRight
                                
                                
                                aClient?.insuranceConcept = secInsuranceConcept
                                aClient?.insuranceConcept2 = secAntiInsuranceConcept
                                
                                aClient?.sense = secSense
                                aClient?.sense2 = secAntiSense
                                
                                aClient?.personalityTraits_others = txt_personalityTraitsOthers.text
                                
                                aClient?.lifeProblemNoService = thirdLifeProblem_noService
                                aClient?.lifeProblemWorkUnstable = thirdLifeProblem_workUnstable
                                aClient?.lifeProblemNoSense = thirdLifeProblem_noSense
                                aClient?.lifeProblem_others = txt_lifeProblemOthers.text
                                
                                aClient?.fivePointDemandRetireRefund = fourthFivePointDemand_retireRefund
                                aClient?.fivePointDemandLifeGuarantee = fourthFivePointDemand_lifeGuarantee
                                aClient?.fivePointDemandMedicalGuarantee = fourthFivePointDemand_medicalGuarantee
                                aClient?.fivePointDemandCareRefund = fourthFivePointDemand_careRefund
                                aClient?.fivePointDemandAssetTransport = fourthFivePointDemand_assetTransport
                                aClient?.fivePointDemand_orhers = txt_fivePointDemandOthers.text
                                
                                aClient?.buildBasicConceptYoungMan = fifthBuildConcept_youngMan
                                aClient?.buildBasicConceptLifeTour = fifthBuildConcept_lifeTour
                                aClient?.buildBasicConceptBasket = fifthBuildConcept_basket
                                aClient?.buildBasicConceptFourQ = fifthBuildConcept_fourQ
                                aClient?.buildBasicConceptMeal = fifthBuildConcept_meal
                                aClient?.buildBasicConcept_others = txt_buidConceptOthers.text
                                
                                aClient?.strategyHealthPassword = sixthStrategy_healthPassword
                                aClient?.strategyCardHeart = sixthStrategy_cardHeart
                                aClient?.strategyMedicalHome = sixthStrategy_medicalHome
                                aClient?.strategyTaxationLecture = sixthStrategy_taxationLexture
                                aClient?.strategyEvent = sixthStrategy_event
                                aClient?.strategyPeriodical = sixthStrategy_periodical
                                aClient?.strategy_others = txt_strategyOthers.text
                                
                                //新的主力商品
                                aClient?.seventh_mainProduct_medicalCare = seventh_medicalCare.text
                                aClient?.seventh_mainProduct_lifeGuarantee = seventh_lifeGuarantee.text
                                aClient?.seventh_mainProduct_moneySaving = seventh_savingMoney.text
                                aClient?.seventh_mainProduct_others = txt_mainProductOthers.text
                                 aClient?.salePlan = txt_salePlan.text
                                aClient?.oppositeProblemNoMoney = eighthOppositeProblem_noMoney
                                aClient?.oppositeProblemBuyTooMore = eighthOppositeProblem_buyTooMore
                                aClient?.oppositeProblemConsidering = eighthOppositeProblem_considering
                                aClient?.oppositeProblemDiscussing = eighthOppositeProblem_discussing
                                aClient?.oppositeProblemFriend = eighthOppositeProblem_friend
                                aClient?.oppositeProblemHealthHistory = eighthOppositeProblem_healthHistory
                                aClient?.oppositeProblemInvestOthers = eighthOppositeProblem_investOthers
                                aClient?.oppositeProblem_others = txt_oppositeProblemOthers.text
                                
                                if self.update != 0 {
                                    aClient?.updateStatus = 1
                                }
                                if preName != txt_name.text {
                                    
                                    aClient?.updateStatus = 0
                                    
                                }
                                appDel?.saveContext()  //資料庫儲存
                                
                                performSegue(withIdentifier: "goNextToEnd", sender: nil)
                            }
                        }
                    }catch let error as NSError{    print(error)    }
                    
                    if preName != txt_name.text {
                        do{
                            guard let context = appDel?.persistentContainer.viewContext else{ return }
                            let result = try context.fetch(Event.fetchRequest())
                            for item in result{
                                let oldEvent = item as? Event
                                
                                if oldEvent?.eventClientName == preName && oldEvent?.clientYear == preYear {
                                    if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized) {
                                        eventStore.requestAccess(to: .event, completion: { (granted, error) -> Void in
                                            self.UpdateEvent(eventStore, eventIdentifier: (oldEvent?.identifier)!, title: "客戶 " + self.txt_name.text!)
                                        })
                                    } else {
                                        UpdateEvent(eventStore, eventIdentifier: (oldEvent?.identifier)!, title: "客戶 " + txt_name.text!)
                                    }
                                    
                                    
                                }
                            }
                        }catch let error as NSError{
                            print(error)
                        }
                        changeEventData()
                    }
                }
                
            }
            
            
            
            //點新增頁面進來然後輸入玩資料發現跟資料庫裡的資料有重複的話
        }
        if checkwhetherduplicate_MODIFY == true{
            
            SaveFailedAlert()
            
        }
        
    }
     func store() {
        
        rightButton3.isEnabled = true
        
        let appDel = UIApplication.shared.delegate as? AppDelegate
        
       // changeEventData()
        
        
        //確認是否有重複
        //當複合鍵沒有被修改過
        var checkwhetherduplicate : Bool = false
        do{
            guard let context2 =  appDel?.persistentContainer.viewContext else{ return }
            let result2 = try context2.fetch(Client.fetchRequest())
            for item in result2{
                let aClient = item as? Client
                if aClient?.name! == preName && aClient?.sex == preSex && aClient?.date! == preBuildDate && aClient?.year == preYear{
                    checkwhetherduplicate = true

                    break
                }else{
                    checkwhetherduplicate = false
                }
            }
        }catch let error as NSError{    print(error)    }
        
        
        //確認是否有重複
        //當複合鍵被修改過後
        var checkwhetherduplicate_MODIFY : Bool = false
        do{
            guard let context2 =  appDel?.persistentContainer.viewContext else{ return }
            let result2 = try context2.fetch(Client.fetchRequest())
            for item in result2{
                let aClient = item as? Client
                
                //若是文字框與資料庫值一樣且不與傳入值一樣的話代表重複
                if (aClient?.name! == txt_name.text! && aClient?.sex == sex && aClient?.date! == txt_buildDate.text! && aClient?.year == TheBirth) && (txt_name.text! != preName || sex != preSex || txt_buildDate.text! != preBuildDate || TheBirth != preYear){
                    checkwhetherduplicate_MODIFY = true
                    
                    break
                    
                }else{
                    
                    checkwhetherduplicate_MODIFY = false
                }
            }
        }catch let error as NSError{    print(error)    }
        
        


        
        if txt_name.text == "" {  //若名字沒打的話顯示錯誤
            let alert = UIAlertController(title: "錯誤", message: "姓名還沒填喔！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) {
                (action:UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            present(alert , animated: true,completion:  nil)
            
            
            //若名字有且這筆資料是沒有與資料庫裡資料重複
        }else if txt_name.text != ""{
           
            //其複合鍵不與資料庫相同才能建立
            //點新增頁面進來的，沒有傳直，index == 10000
            if index >= 10000 && checkwhetherduplicate_MODIFY == false {
                
                //設置好資料庫儲存資料單位aClient
                guard let context =  appDel?.persistentContainer.viewContext else{ return }
                let aClient = Client(context: context)
                
                aClient.name = txt_name.text
                aClient.reasonCome = reason
                aClient.sex = sex
                aClient.date = txt_buildDate.text
                aClient.phone = txt_phone.text
                
                aClient.year = TheBirth
                
                aClient.married = txt_married.text
                aClient.work = txt_work.text
                if txt_salary.text == ""{
                    
                }else{
                    aClient.salary2 = txt_salary.text!
                }
                
                aClient.interesting = txt_interesting.text
                aClient.history = txt_history.text
                aClient.children = txt_children.text
                aClient.mortage = txt_motage.text
                aClient.basic_others = txt_basicOthers.text
                aClient.personalityTraits_D = secPersonalityTraits_D
                aClient.personalityTraits_I = secPersonalityTraits_I
                aClient.personalityTraits_S = secPersonalityTraits_S
                aClient.personalityTraits_C = secPersonalityTraits_C
                
                aClient.decideRight = secDecidedRight
                aClient.decideRight2 = secAntiDecidedRight
                
                aClient.insuranceConcept = secInsuranceConcept
                aClient.insuranceConcept2 = secAntiInsuranceConcept
                
                aClient.sense = secSense
                aClient.sense2 = secAntiSense
                
                aClient.personalityTraits_others = txt_personalityTraitsOthers.text
                aClient.lifeProblemNoService = thirdLifeProblem_noService
                aClient.lifeProblemWorkUnstable = thirdLifeProblem_workUnstable
                aClient.lifeProblemNoSense = thirdLifeProblem_noSense
                aClient.lifeProblem_others = txt_lifeProblemOthers.text
                aClient.fivePointDemandRetireRefund = fourthFivePointDemand_retireRefund
                aClient.fivePointDemandLifeGuarantee = fourthFivePointDemand_lifeGuarantee
                aClient.fivePointDemandMedicalGuarantee = fourthFivePointDemand_medicalGuarantee
                aClient.fivePointDemandCareRefund = fourthFivePointDemand_careRefund
                aClient.fivePointDemandAssetTransport = fourthFivePointDemand_assetTransport
                aClient.fivePointDemand_orhers = txt_fivePointDemandOthers.text
                aClient.buildBasicConceptYoungMan = fifthBuildConcept_youngMan
                aClient.buildBasicConceptLifeTour = fifthBuildConcept_lifeTour
                aClient.buildBasicConceptBasket = fifthBuildConcept_basket
                aClient.buildBasicConceptFourQ = fifthBuildConcept_fourQ
                aClient.buildBasicConceptMeal = fifthBuildConcept_meal
                aClient.buildBasicConcept_others = txt_buidConceptOthers.text
                aClient.strategyHealthPassword = sixthStrategy_healthPassword
                aClient.strategyCardHeart = sixthStrategy_cardHeart
                aClient.strategyMedicalHome = sixthStrategy_medicalHome
                aClient.strategyTaxationLecture = sixthStrategy_taxationLexture
                aClient.strategyEvent = sixthStrategy_event
                aClient.strategyPeriodical = sixthStrategy_periodical
                aClient.strategy_others = txt_strategyOthers.text
                
                
                aClient.seventh_mainProduct_medicalCare = seventh_medicalCare.text
                aClient.seventh_mainProduct_lifeGuarantee = seventh_lifeGuarantee.text
                aClient.seventh_mainProduct_moneySaving = seventh_savingMoney.text
                aClient.seventh_mainProduct_others = txt_mainProductOthers.text
                 aClient.salePlan = txt_salePlan.text
                aClient.oppositeProblemNoMoney = eighthOppositeProblem_noMoney
                aClient.oppositeProblemBuyTooMore = eighthOppositeProblem_buyTooMore
                aClient.oppositeProblemConsidering = eighthOppositeProblem_considering
                aClient.oppositeProblemDiscussing = eighthOppositeProblem_discussing
                aClient.oppositeProblemFriend = eighthOppositeProblem_friend
                aClient.oppositeProblemHealthHistory = eighthOppositeProblem_healthHistory
                aClient.oppositeProblemInvestOthers = eighthOppositeProblem_investOthers
                aClient.oppositeProblem_others = txt_oppositeProblemOthers.text
                
                aClient.seperate = "No"
                aClient.updateStatus = 0
                appDel?.saveContext()  //資料庫儲存
                SaveSuccessAlert()
             
                
                
                //在同一複合鍵（傳值內容）下得以修改資料
                //點客戶資料頁面進來的，有傳直,index == 客戶資料的索引值
            }else if index < 10000 && checkwhetherduplicate == true{
                let eventStore = EKEventStore()
               
                //若是改了複合鍵的值，檢查是否與資料庫內容重複
                if checkwhetherduplicate_MODIFY == false{
             
                    //設置好資料庫儲存資料單位aClient
                    do{
                        guard let context =  appDel?.persistentContainer.viewContext else{ return }
                        let result = try context.fetch(Client.fetchRequest())
                        for item in result{
                            let aClient = item as? Client
                            if (aClient?.name)! == preName && aClient?.date == preBuildDate && (aClient?.year)! == preYear && (aClient?.sex)! == preSex{
                            
                                aClient?.name = txt_name.text
                                aClient?.reasonCome = reason
                                aClient?.sex = sex
                                aClient?.date = txt_buildDate.text
                                aClient?.phone = txt_phone.text
                                aClient?.year = TheBirth
                                aClient?.married = txt_married.text
                                aClient?.work = txt_work.text
                            
                                if txt_salary.text! != ""{
                                    aClient?.salary2 = txt_salary.text!
                                }else{       }
                            
                                aClient?.interesting = txt_interesting.text
                                aClient?.history = txt_history.text
                                aClient?.children = txt_children.text
                                aClient?.mortage = txt_motage.text
                                aClient?.basic_others = txt_basicOthers.text
                                aClient?.personalityTraits_D = secPersonalityTraits_D
                                aClient?.personalityTraits_I = secPersonalityTraits_I
                                aClient?.personalityTraits_S = secPersonalityTraits_S
                                aClient?.personalityTraits_C = secPersonalityTraits_C
                            
                                aClient?.decideRight = secDecidedRight
                                aClient?.decideRight2 = secAntiDecidedRight
                            
                            
                                aClient?.insuranceConcept = secInsuranceConcept
                                aClient?.insuranceConcept2 = secAntiInsuranceConcept
                            
                                aClient?.sense = secSense
                                aClient?.sense2 = secAntiSense
                            
                                aClient?.personalityTraits_others = txt_personalityTraitsOthers.text
                                aClient?.lifeProblemNoService = thirdLifeProblem_noService
                                aClient?.lifeProblemWorkUnstable = thirdLifeProblem_workUnstable
                                aClient?.lifeProblemNoSense = thirdLifeProblem_noSense
                                aClient?.lifeProblem_others = txt_lifeProblemOthers.text
                                aClient?.fivePointDemandRetireRefund = fourthFivePointDemand_retireRefund
                                aClient?.fivePointDemandLifeGuarantee = fourthFivePointDemand_lifeGuarantee
                                aClient?.fivePointDemandMedicalGuarantee = fourthFivePointDemand_medicalGuarantee
                                aClient?.fivePointDemandCareRefund = fourthFivePointDemand_careRefund
                                aClient?.fivePointDemandAssetTransport = fourthFivePointDemand_assetTransport
                                aClient?.fivePointDemand_orhers = txt_fivePointDemandOthers.text
                                aClient?.buildBasicConceptYoungMan = fifthBuildConcept_youngMan
                                aClient?.buildBasicConceptLifeTour = fifthBuildConcept_lifeTour
                                aClient?.buildBasicConceptBasket = fifthBuildConcept_basket
                                aClient?.buildBasicConceptFourQ = fifthBuildConcept_fourQ
                                aClient?.buildBasicConceptMeal = fifthBuildConcept_meal
                                aClient?.buildBasicConcept_others = txt_buidConceptOthers.text
                                aClient?.strategyHealthPassword = sixthStrategy_healthPassword
                                aClient?.strategyCardHeart = sixthStrategy_cardHeart
                                aClient?.strategyMedicalHome = sixthStrategy_medicalHome
                                aClient?.strategyTaxationLecture = sixthStrategy_taxationLexture
                                aClient?.strategyEvent = sixthStrategy_event
                                aClient?.strategyPeriodical = sixthStrategy_periodical
                                aClient?.strategy_others = txt_strategyOthers.text
                            
                                aClient?.seventh_mainProduct_medicalCare = seventh_medicalCare.text
                                aClient?.seventh_mainProduct_lifeGuarantee = seventh_lifeGuarantee.text
                                aClient?.seventh_mainProduct_moneySaving = seventh_savingMoney.text
                                aClient?.seventh_mainProduct_others = txt_mainProductOthers.text
                                 aClient?.salePlan = txt_salePlan.text
                                aClient?.oppositeProblemNoMoney = eighthOppositeProblem_noMoney
                                aClient?.oppositeProblemBuyTooMore = eighthOppositeProblem_buyTooMore
                                aClient?.oppositeProblemConsidering = eighthOppositeProblem_considering
                                aClient?.oppositeProblemDiscussing = eighthOppositeProblem_discussing
                                aClient?.oppositeProblemFriend = eighthOppositeProblem_friend
                                aClient?.oppositeProblemHealthHistory = eighthOppositeProblem_healthHistory
                                aClient?.oppositeProblemInvestOthers = eighthOppositeProblem_investOthers
                                aClient?.oppositeProblem_others = txt_oppositeProblemOthers.text
                                
                                if self.update != 0 {
                                    aClient?.updateStatus = 1
                                }
                                appDel?.saveContext()  //資料庫儲存
                                SaveSuccessAlert()
                            }
                        }
                    }catch let error as NSError{    print(error)    }
                    
                     //使用者去改名字時
                    if preName != txt_name.text {
                        do{
                            guard let context = appDel?.persistentContainer.viewContext else{ return }
                            let result = try context.fetch(Event.fetchRequest())
                            for item in result{
                                let oldEvent = item as? Event
                                
                                if oldEvent?.eventClientName == preName && oldEvent?.clientYear == preYear {
                                    if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized) {
                                        eventStore.requestAccess(to: .event, completion: { (granted, error) -> Void in
                                            self.UpdateEvent(eventStore, eventIdentifier: (oldEvent?.identifier)!, title: "客戶 " + self.txt_name.text!)
                                        })
                                    } else {
                                        UpdateEvent(eventStore, eventIdentifier: (oldEvent?.identifier)!, title: "客戶 " + txt_name.text!)
                                        
                                    }
                                    
                                 
                                }
                            }
                        }catch let error as NSError{
                            print(error)
                        }
                        changeEventData()
                    }
                }
            }
            
            
           
            //點新增頁面進來然後輸入玩資料發現跟資料庫裡的資料有重複的話
        }
        if checkwhetherduplicate_MODIFY == true{
       
            SaveFailedAlert()
            
        }
        
       
    }
    
    
    func SaveFailedAlert() {
    
        let alert = UIAlertController(title: "警告", message: "客戶已重複", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        {
            (action:UIAlertAction) in
        }
        alert.addAction(okAction)
        present(alert , animated: true,completion:  nil)

    
    }
    
    func SaveSuccessAlert() {
    
        let alertController = UIAlertController(
            title: "提示",
            message: "儲存成功",
            preferredStyle: .alert)
        
        // 建立[確認]按鈕
        
        let okAction = UIAlertAction(
            title: "確認",
            style: .default,
            handler: {
                (action: UIAlertAction!) -> Void in
                print("按下確認後，閉包裡的動作")
        })
        alertController.addAction(okAction)
        
        // 顯示提示框
        self.present(
            alertController,
            animated: true,
            completion: nil)
        
    
    }

    func note() {
        
        performSegue(withIdentifier: "showNoteClient", sender: nil)
        
    }
    

    @IBAction func btn_fifth_buildInsuranceConcept(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            sender.setImage(UIImage(named:(fifthBuildConcept_youngMan ? "checkbox" : "check")), for: .normal)
            fifthBuildConcept_youngMan = fifthBuildConcept_youngMan ? false : true
        case 1:
            sender.setImage(UIImage(named:(fifthBuildConcept_lifeTour ? "checkbox" : "check")), for: .normal)
            fifthBuildConcept_lifeTour = fifthBuildConcept_lifeTour ? false : true
        case 2:
            sender.setImage(UIImage(named:(fifthBuildConcept_basket ? "checkbox" : "check")), for: .normal)
            fifthBuildConcept_basket = fifthBuildConcept_basket ? false : true
        case 3:
            sender.setImage(UIImage(named:(fifthBuildConcept_fourQ ? "checkbox" : "check")), for: .normal)
            fifthBuildConcept_fourQ = fifthBuildConcept_fourQ ? false : true
        default:
            sender.setImage(UIImage(named:(fifthBuildConcept_meal ? "checkbox" : "check")), for: .normal)
            fifthBuildConcept_meal = fifthBuildConcept_meal ? false : true
        }
    }


    @IBAction func btn_sixth_strategy(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            sender.setImage(UIImage(named:(sixthStrategy_healthPassword ? "checkbox" : "check")), for: .normal)
            sixthStrategy_healthPassword = sixthStrategy_healthPassword ? false : true
        case 1:
            sender.setImage(UIImage(named:(sixthStrategy_cardHeart ? "checkbox" : "check")), for: .normal)
            sixthStrategy_cardHeart = sixthStrategy_cardHeart ? false : true
        case 2:
            sender.setImage(UIImage(named:(sixthStrategy_medicalHome ? "checkbox" : "check")), for: .normal)
            sixthStrategy_medicalHome = sixthStrategy_medicalHome ? false : true
        case 3:
            sender.setImage(UIImage(named:(sixthStrategy_taxationLexture ? "checkbox" : "check")), for: .normal)
            sixthStrategy_taxationLexture = sixthStrategy_taxationLexture ? false : true
        case 4:
            sender.setImage(UIImage(named:(sixthStrategy_event ? "checkbox" : "check")), for: .normal)
            sixthStrategy_event = sixthStrategy_event ? false : true
        default:
            sender.setImage(UIImage(named:(sixthStrategy_periodical ? "checkbox" : "check")), for: .normal)
            sixthStrategy_periodical = sixthStrategy_periodical ? false : true
        }
    }
    
    @IBAction func btn_eighth_oppositeProblem(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            sender.setImage(UIImage(named:(eighthOppositeProblem_noMoney ? "checkbox" : "check")), for: .normal)
            eighthOppositeProblem_noMoney = eighthOppositeProblem_noMoney ? false : true
        case 1:
            sender.setImage(UIImage(named:(eighthOppositeProblem_buyTooMore ? "checkbox" : "check")), for: .normal)
            eighthOppositeProblem_buyTooMore = eighthOppositeProblem_buyTooMore ? false : true
        case 2:
            sender.setImage(UIImage(named:(eighthOppositeProblem_considering ? "checkbox" : "check")), for: .normal)
            eighthOppositeProblem_considering = eighthOppositeProblem_considering ? false : true
        case 3:
            sender.setImage(UIImage(named:(eighthOppositeProblem_discussing ? "checkbox" : "check")), for: .normal)
            eighthOppositeProblem_discussing = eighthOppositeProblem_discussing ? false : true
        case 4:
            sender.setImage(UIImage(named:(eighthOppositeProblem_friend ? "checkbox" : "check")), for: .normal)
            eighthOppositeProblem_friend = eighthOppositeProblem_friend ? false : true
        case 5:
            sender.setImage(UIImage(named:(eighthOppositeProblem_healthHistory ? "checkbox" : "check")), for: .normal)
            eighthOppositeProblem_healthHistory = eighthOppositeProblem_healthHistory ? false : true
        default:
            sender.setImage(UIImage(named:(eighthOppositeProblem_investOthers ? "checkbox" : "check")), for: .normal)
            eighthOppositeProblem_investOthers = eighthOppositeProblem_investOthers ? false : true
        }
    }
    
    
    
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goNextToEnd" {
            let controller = (segue.destination as! UINavigationController).topViewController  as! clientSeperate
            controller.clientClass = clientClass
            controller.prepreName = preName
            controller.preName = txt_name.text!
            controller.prebuildDate = txt_buildDate.text!
            if txt_year.text != ""{
                controller.preYear = TheBirth
            }
            else{
                controller.preYear = TheBirth
            }
            controller.prePhone = txt_phone.text!
            controller.strForClientSP = "客戶"
        }
        if segue.identifier == "showNoteClient"{
            let vc = (segue.destination as! UINavigationController).topViewController as! CustomerNoteViewController
            vc.preName = txt_name.text!
            vc.prePhoneNumber = txt_phone.text!
        }
        
        if segue.identifier == "popover_date"{
            
            let vc = segue.destination
            
            
            //調整pop出來視窗的大小
            vc.preferredContentSize = CGSize(width: 250, height: 200)
            
            let v = segue.destination as! birthViewController
            v.delegate = self
            
            
            
            let controller = vc.popoverPresentationController
            
            if controller != nil{
                
                controller?.delegate = self
                
            }
            
            
        }
        if segue.identifier == "popover_child"{
            
            let vc = segue.destination
            
            
            //調整pop出來視窗的大小
            vc.preferredContentSize = CGSize(width: 250, height: 200)
            
            let v = segue.destination as! childrenViewController
            v.delegate = self
            
            
            
            let controller = vc.popoverPresentationController
            
            if controller != nil{
                
                controller?.delegate = self
                
            }
            
            
        }
        
        if segue.identifier == "popover_marry"{
            
            let vc = segue.destination
            
            
            //調整pop出來視窗的大小
            vc.preferredContentSize = CGSize(width: 250, height: 200)
            
            let v = segue.destination as! marryViewController
            v.delegate = self
            
            
            
            let controller = vc.popoverPresentationController
            
            if controller != nil{
                
                controller?.delegate = self
                
            }
            
            
        }
        
        
        
    }
   
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func changeEventData() {
        let appDel2 = UIApplication.shared.delegate as? AppDelegate
        guard let context =  appDel2?.persistentContainer.viewContext else{ return }
        
        do{
            let result = try context.fetch(Event.fetchRequest())
            for item in result{
                let changeEvent = item as? Event
                
                if changeEvent?.eventClientName == preName && changeEvent?.clientYear == TheBirth {
                    
                    changeEvent?.eventClientName = txt_name.text
                    changeEvent?.eventClientPhone = txt_phone.text
                    
                }
                
                appDel2?.saveContext()
            }
        }
        catch let error as NSError {    print(error)    }

    }
    
    let rightButton = UIButton(type: .system)
    let rightButton2 = UIButton(type: .system)
    let rightButton3 = UIButton(type: .system)
    
    private func setupNavigationBarItems(){
        
        self.title = "客戶詳細資料"
        //        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        //        navigationController?.navigationBar.barTintColor = UIColor.init(red: 93/255, green: 186/255, blue: 228/255, alpha: 1)
        
        //
        //        let leftButton = UIButton(type: .system)
        //
        //        leftButton.setImage(#imageLiteral(resourceName: "list"),for: .normal)
        //        leftButton.frame = CGRect(x: 0,y: 0,width: 20 , height: 20)
        //        leftButton.contentMode = .scaleAspectFit
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        //        leftButton.tintColor = .white
        //        leftButton.addTarget(self, action: #selector(menuClick), for: .touchUpInside)
        //
        
        
        
        rightButton.setImage(#imageLiteral(resourceName: "edit").withRenderingMode(.alwaysOriginal),for: .normal)
        rightButton.frame = CGRect(x: 0,y: 0,width: 20 , height: 20)
        rightButton.contentMode = .scaleAspectFit
        
        rightButton.addTarget(self, action: #selector(edit), for: .touchUpInside)
        
        
        rightButton2.setImage(#imageLiteral(resourceName: "checkb").withRenderingMode(.alwaysOriginal),for: .normal)
        rightButton2.frame = CGRect(x: 0,y: 0,width: 20 , height: 20)
        rightButton2.contentMode = .scaleAspectFit
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton2)
        rightButton2.addTarget(self, action: #selector(store), for: .touchUpInside)
        
        
        
        rightButton3.setImage(#imageLiteral(resourceName: "note").withRenderingMode(.alwaysOriginal),for: .normal)
        rightButton3.frame = CGRect(x: 0,y: 0,width: 20 , height: 20)
        rightButton3.contentMode = .scaleAspectFit
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton3)
        rightButton3.addTarget(self, action: #selector(note), for: .touchUpInside)
        
        navigationItem.rightBarButtonItems = [ UIBarButtonItem(customView: rightButton),UIBarButtonItem(customView: rightButton2),UIBarButtonItem(customView: rightButton3)]
        
        
    }
    
    
    
//    @IBOutlet weak var note: UIBarButtonItem!
    override func viewDidLoad() {
        txt_buildDate.isEnabled = false
        setupNavigationBarItems()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        if index<1000 {
     
            preName = passName
            preSex = passSex
            preBuildDate = passBuildDate
            
            let appDel = UIApplication.shared.delegate as? AppDelegate
            guard let context =  appDel?.persistentContainer.viewContext else{ return }
            
            do{
                let result = try context.fetch(Client.fetchRequest())
                
                for item in result{
                    let oldClient = item as? Client
                    print ("hey!!!!!\(oldClient?.personalityTraits_D)")
                    if oldClient?.name! == preName && oldClient?.sex! == preSex && oldClient?.date! == preBuildDate && oldClient?.year == preYear {
                        self.update = (oldClient?.updateStatus)!
                        
                        txt_name.text = oldClient?.name!
                        
                        sex = (oldClient?.sex)!
                        reason = (oldClient?.reasonCome)!
                        
                        TheBirth = (oldClient?.year)!
                        secPersonalityTraits_D = (oldClient?.personalityTraits_D)!
                        secPersonalityTraits_I = (oldClient?.personalityTraits_I)!
                        secPersonalityTraits_S = (oldClient?.personalityTraits_S)!
                        secPersonalityTraits_C = (oldClient?.personalityTraits_C)!
                        secDecidedRight = (oldClient?.decideRight)!
                        secAntiDecidedRight = (oldClient?.decideRight2)!
                        secInsuranceConcept = (oldClient?.insuranceConcept)!
                        secAntiInsuranceConcept = (oldClient?.insuranceConcept2)!
                        secSense = (oldClient?.sense)!
                        secAntiSense = (oldClient?.sense2)!
                        
                        thirdLifeProblem_noSense = (oldClient?.lifeProblemNoSense)!
                        thirdLifeProblem_noService = (oldClient?.lifeProblemNoService)!
                        thirdLifeProblem_workUnstable = (oldClient?.lifeProblemWorkUnstable)!
                        
                        fourthFivePointDemand_retireRefund = (oldClient?.fivePointDemandRetireRefund)!
                        fourthFivePointDemand_lifeGuarantee = (oldClient?.fivePointDemandLifeGuarantee)!
                        fourthFivePointDemand_medicalGuarantee = (oldClient?.fivePointDemandMedicalGuarantee)!
                        fourthFivePointDemand_careRefund = (oldClient?.fivePointDemandCareRefund)!
                        fourthFivePointDemand_assetTransport = (oldClient?.fivePointDemandAssetTransport)!
                        
                        fifthBuildConcept_youngMan = (oldClient?.buildBasicConceptYoungMan)!
                        fifthBuildConcept_lifeTour = (oldClient?.buildBasicConceptLifeTour)!
                        fifthBuildConcept_basket = (oldClient?.buildBasicConceptBasket)!
                        fifthBuildConcept_fourQ = (oldClient?.buildBasicConceptFourQ)!
                        fifthBuildConcept_meal = (oldClient?.buildBasicConceptMeal)!
                        
                        sixthStrategy_healthPassword = (oldClient?.strategyHealthPassword)!
                        sixthStrategy_cardHeart = (oldClient?.strategyCardHeart)!
                        sixthStrategy_medicalHome = (oldClient?.strategyMedicalHome)!
                        sixthStrategy_taxationLexture = (oldClient?.strategyTaxationLecture)!
                        sixthStrategy_event = (oldClient?.strategyEvent)!
                        sixthStrategy_periodical = (oldClient?.strategyPeriodical)!
                        
                        eighthOppositeProblem_noMoney = (oldClient?.oppositeProblemNoMoney)!
                        eighthOppositeProblem_buyTooMore = (oldClient?.oppositeProblemBuyTooMore)!
                        eighthOppositeProblem_considering = (oldClient?.oppositeProblemConsidering)!
                        eighthOppositeProblem_discussing = (oldClient?.oppositeProblemDiscussing)!
                        eighthOppositeProblem_friend = (oldClient?.oppositeProblemFriend)!
                        eighthOppositeProblem_healthHistory = (oldClient?.oppositeProblemHealthHistory)!
                        eighthOppositeProblem_investOthers = (oldClient?.oppositeProblemInvestOthers)!
                        
                        if oldClient?.sex == "男" {
                            btn_boy.setImage(UIImage(named : "check"), for : .normal)
                        }else if oldClient?.sex == "女"{
                            btn_girl.setImage(UIImage(named : "check"), for : .normal)
                        }
                        
                        if oldClient?.reasonCome == 0 {
                            btn_reasonA.setImage(UIImage(named : "check"), for : .normal)
                        }else if oldClient?.reasonCome == 1{
                            btn_reasonB.setImage(UIImage(named : "check"), for : .normal)
                        }else if oldClient?.reasonCome == 2{
                            btn_reasonC.setImage(UIImage(named : "check"), for : .normal)
                        }
                        
                        let date = Date()
                        let formatter = DateFormatter()
                        let formatter2 = DateFormatter()
                        let formatter3 = DateFormatter()
                        formatter.dateFormat = "yyyy年MM月dd日"
                        formatter2.dateFormat = "yyyy"
                        formatter3.dateFormat = "MM"
                        var yearCal : Int = 0
                        
                        if oldClient?.year! != ""{
                            print ("hey year  \((oldClient?.year!))")
                            let split = oldClient?.year?.components(separatedBy: "年")
                            yearCal = Int(formatter2.string(from: date))! - Int((split?[0])!)!
                            let split2 = split?[1].components(separatedBy: "月")
                            
                            let month = Int(formatter3.string(from: date))! - Int((split2?[0])!)!
                            
                            if month < -6 || month > 6{
                                yearCal -= 1
                            }
                            txt_year.text = String(yearCal)
                        }
                        
                        txt_phone.text = oldClient?.phone
                        txt_children.text = oldClient?.children
                        txt_married.text = oldClient?.married
                        txt_motage.text = oldClient?.mortage
                        txt_work.text = oldClient?.work
                        txt_history.text = oldClient?.history
                        
                        txt_salary.text = oldClient?.salary2
                        
                        
                        txt_basicOthers.text = oldClient?.basic_others
                        txt_interesting.text = oldClient?.interesting
                        txt_buildDate.text = oldClient?.date
                        txt_personalityTraitsOthers.text = oldClient?.personalityTraits_others
                        txt_lifeProblemOthers.text = oldClient?.lifeProblem_others
                        txt_fivePointDemandOthers.text = oldClient?.fivePointDemand_orhers
                        txt_buidConceptOthers.text = oldClient?.buildBasicConcept_others
                        txt_strategyOthers.text = oldClient?.strategy_others
                        
                        //新加的主力商品
                        seventh_medicalCare.text = oldClient?.seventh_mainProduct_medicalCare
                        seventh_lifeGuarantee.text = oldClient?.seventh_mainProduct_lifeGuarantee
                        seventh_savingMoney.text = oldClient?.seventh_mainProduct_moneySaving
                        
                        txt_mainProductOthers.text = oldClient?.seventh_mainProduct_others
                        txt_oppositeProblemOthers.text = oldClient?.oppositeProblem_others
                        txt_salePlan.text = oldClient?.salePlan
                        
                        if oldClient?.personalityTraits_D == true{
                            sec_perD.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.personalityTraits_I == true{
                            sec_perI.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.personalityTraits_S == true{
                            sec_perS.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.personalityTraits_C == true{
                            sec_perC.setImage(UIImage(named : "check"), for: .normal)
                        }
                        
                        if oldClient?.decideRight == true{
                            sec_decideYes.setImage(UIImage(named : "check"), for: .normal)
                        }else if oldClient?.decideRight == false{
                            sec_decideYes.setImage(UIImage(named : "checkbox"), for: .normal)
                        }
                        
                        if oldClient?.decideRight2 == true{
                            sec_decideNo.setImage(UIImage(named : "check"), for: .normal)
                        }else if oldClient?.decideRight2 == false{
                            sec_decideNo.setImage(UIImage(named : "checkbox"), for: .normal)
                        }
                        
                        if oldClient?.sense == true{
                            sec_senseYes.setImage(UIImage(named : "check"), for: .normal)
                        }else if oldClient?.sense == false{
                            sec_senseYes.setImage(UIImage(named : "checkbox"), for: .normal)
                        }
                        
                        if oldClient?.sense2 == true{
                            sec_senseNo.setImage(UIImage(named : "check"), for: .normal)
                        }else if oldClient?.sense2 == false{
                            sec_senseNo.setImage(UIImage(named : "checkbox"), for: .normal)
                        }
                        
                        if oldClient?.insuranceConcept == true{
                            sec_conceptYes.setImage(UIImage(named : "check"), for: .normal)
                        }else if oldClient?.insuranceConcept == false{
                            sec_conceptYes.setImage(UIImage(named : "checkbox"), for: .normal)
                        }
                        if oldClient?.insuranceConcept2 == true{
                            sec_conceptNo.setImage(UIImage(named : "check"), for: .normal)
                        }else if oldClient?.insuranceConcept2 == false{
                            sec_conceptNo.setImage(UIImage(named : "checkbox"), for: .normal)
                        }
                        
                        if oldClient?.lifeProblemNoService == true{
                            third_noService.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.lifeProblemWorkUnstable == true{
                            third_workUnstable.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.lifeProblemNoSense == true{
                            third_unclear.setImage(UIImage(named : "check"), for: .normal)
                        }
                        
                        
                        if oldClient?.fivePointDemandRetireRefund == true{
                            fourth_retireFund.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.fivePointDemandLifeGuarantee == true{
                            fourth_lifeGuarantee.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.fivePointDemandMedicalGuarantee == true{
                            fourth_medicalGuarantee.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.fivePointDemandCareRefund == true{
                            fourth_careFund.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.fivePointDemandAssetTransport == true{
                            fourth_assetTrans.setImage(UIImage(named : "check"), for: .normal)
                        }
                        
                        
                        if oldClient?.buildBasicConceptYoungMan == true {
                            fifth_youngMan.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.buildBasicConceptLifeTour == true {
                            fifth_lifeTour.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.buildBasicConceptBasket == true{
                            fifth_basket.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.buildBasicConceptFourQ == true{
                            fifth_fourQ.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.buildBasicConceptMeal == true{
                            fifth_meal.setImage(UIImage(named : "check"), for: .normal)
                        }
                        
                        
                        if oldClient?.strategyHealthPassword == true{
                            six_healthPassport.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.strategyCardHeart == true {
                            six_cardHeart.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.strategyMedicalHome == true{
                            six_medicalHome.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.strategyTaxationLecture == true{
                            six_taxationLexture.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.strategyEvent == true{
                            six_event.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.strategyPeriodical == true{
                            six_periodical.setImage(UIImage(named : "check"), for: .normal)
                        }
                        
                        if oldClient?.oppositeProblemNoMoney == true{
                            eighth_noMoney.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.oppositeProblemBuyTooMore == true{
                            eighth_buyTooMore.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.oppositeProblemConsidering == true{
                            eighth_considering.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.oppositeProblemFriend == true{
                            eighth_friend.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.oppositeProblemDiscussing == true{
                            eighth_discussing.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.oppositeProblemHealthHistory == true{
                            eighth_history.setImage(UIImage(named : "check"), for: .normal)
                        }
                        if oldClient?.oppositeProblemInvestOthers == true{
                            eighth_investOthers.setImage(UIImage(named : "check"), for: .normal)
                        }
                    }
                }
            }catch{
            }
        }else{
            rightButton3.isEnabled = false
            let date = Date()
            let Formatter = DateFormatter()
            Formatter.dateFormat = "yyyy年MM月dd日"
            txt_buildDate.text = Formatter.string(from: date)  //自動在建檔日期的欄位填入當天日期
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // 修改event的function
    func UpdateEvent(_ eventStore: EKEventStore , eventIdentifier: String , title : String) {
        let eventUpDate = eventStore.event(withIdentifier: eventIdentifier)
        
        eventUpDate?.title = title
        
        if (eventUpDate != nil) {
            do {
                try eventStore.save(eventUpDate!, span: .thisEvent)
            } catch {  }
        }
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 && (txt_salePlan.isEditing || txt_lifeProblemOthers.isEditing || txt_personalityTraitsOthers.isEditing){
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    
}
