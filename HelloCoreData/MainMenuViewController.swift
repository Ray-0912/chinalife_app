//
//  MainMenuViewController.swift
//  HelloCoreData
//
//  Created by User on 2017/2/17.
//  Copyright © 2017年 楊昇融. All rights reserved.
//

import UIKit
import EventKit

class MainMenuViewController: UIViewController {
    
    var index : Int = 10000
    
    var data_sn : String = ""

    @IBAction func addCustomer(_ sender: Any) {
        performSegue(withIdentifier: "addNewCustomer", sender: self)
    }
    
    func upload() {
        var checkInternet : Bool = checkInternetFunction()
        if checkInternet == true {
            getData_sn()
            updateSQLclient()
            updateSQLorangeCLient()
            updateSQLNote()
            let alertController = UIAlertController(
                title: "提示",
                message: "上傳完成",
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
        } else if checkInternet == false {
            let alertController = UIAlertController(
                title: "提示",
                message: "目前沒有連線到網路，請先連線",
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
    }
    
    func getBoolean(input:Bool)->String {
        if input == false {
            return "'0',"
        }else{
            return "'1',"
        }
        return ""
    }
    
    let rightButton = UIButton(type: .system)
  
    
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
        
        
        
        rightButton.setImage(#imageLiteral(resourceName: "upload").withRenderingMode(.alwaysOriginal),for: .normal)
        rightButton.frame = CGRect(x: 0,y: 0,width: 50 , height: 50)
        rightButton.contentMode = .scaleAspectFit
//        rightButton.text
        rightButton.addTarget(self, action: #selector(upload), for: .touchUpInside)
        
        
     
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        //詢問使用者是否允許存取行事曆事件
        let eventStore = EKEventStore()
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized: break
        //access
        case .denied:
            print("Access denied")
        case .notDetermined:
            eventStore.requestAccess(to: .event, completion:
                {[weak self] (granted: Bool, error: Error?) -> Void in
                    if granted {
                        //access
                    } else {
                        print("Access denied")
                    }
            })
        default:
            print("Case Default")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNewCustomer" {
        let vc = segue.destination as! clientDetailed
            vc.index = index
            vc.clientClass = "一般"
            
        }
        
        if segue.identifier == "addmember" {
        
        let vc = segue.destination as! OCVC
            vc.index = index
            vc.clientClass = "增員"
        
        }
        
    }
    
    
    //先呼叫Reachability，並且讓他嘗試連線到"www.apple.com"
    var reachability = Reachability(hostName: "www.apple.com")
    
    //實作一個方法來檢查網路連線，讓其回傳一個布林值
    func checkInternetFunction() -> Bool {
        if reachability?.currentReachabilityStatus().rawValue == 0 {
            return false
        }else {
            return true
        }
    }
    
    func getData_sn(){
        do{
            let appDel = UIApplication.shared.delegate as? AppDelegate
            guard let context = appDel?.persistentContainer.viewContext else {  return  }
            let result = try context.fetch(AccData.fetchRequest())
            
            for item in result{
                let userInfo = item as? AccData
                data_sn = (userInfo?.userNumber)!
            }
        } catch { }
    }
    
    func updateSQLclient() {
        let appDel = UIApplication.shared.delegate as? AppDelegate
        guard let context =  appDel?.persistentContainer.viewContext else{ return }
        
        do{
            let result = try context.fetch(Client.fetchRequest())
            for item in result{
                
                let oldClient = item as? Client
                
                print("hey updateSQLclient status = \(oldClient?.updateStatus)")
                if (oldClient?.updateStatus)! == 0 {
                    //check sql
                    var updateSQL = "INSERT INTO `client` (`data_sn`,`name`,`sex`,`reasonCome`,`seperate`,`date`,`phone`,`married`,`work`,`salary2`,`interesting`,`history`,`children`,`mortage`,`basic_others`,`year`,`personalityTraits_D`,`personalityTraits_I`,`personalityTraits_S`,`personalityTraits_C`,`personalityTraits_others`,`decideRight`,`decideRight2`,`insuranceConcept`,`insuranceConcept2`,`sense`,`sense2`,`lifeProblemNoSense`,`lifeProblemNoService`,`lifeProblemWorkUnstable`,`lifeProblem_others`,`fivePointDemandRetireRefund`,`fivePointDemandLifeGuarantee`,`fivePointDemandMedicalGuarantee`,`fivePointDemandCareRefund`,`fivePointDemandAssetTransport`,`fivePointDemand_others`,`buildBasicConceptYoungMan`,`buildBasicConceptLifeTour`,`buildBasicConceptBasket`,`buildBasicConceptFourQ`,`buildBasicConceptMeal`,`buildBasicConcept_others`,`strategyHealthPassword`,`strategyCardHeart`,`strategyMedicalHome`,`strategyTaxationLecture`,`strategyEvent`,`strategyPeriodical`,`strategy_others`,`seventh_mainProduct_medicalCare`,`seventh_mainProduct_lifeGuarantee`,`seventh_mainProduct_moneySaving`,`seventh_mainProduct_others`,`oppositeProblemNoMoney`,`oppositeProblemBuyTooMore`,`oppositeProblemConsidering`,`oppositeProblemDiscussing`,`oppositeProblemFriend`,`oppositeProblemHealthHistory`,`oppositeProblemInvestOthers`,`oppositeProblem_others`,`salePlan`) VALUES ("
                    updateSQL += "'\(data_sn)',"
                    if let out = oldClient?.name { updateSQL += "'\(out)'," } else { updateSQL += "''," }
                    if let out = oldClient?.sex { updateSQL += "'\(out)'," } else { updateSQL += "''," }
                    if let out = oldClient?.reasonCome {
                    updateSQL += "'\(String(out))',"
                    }
                    if let seperate = oldClient?.seperate { updateSQL += "'\(seperate)'," } else { updateSQL += "''," }
                    
                    if let out = oldClient?.date { updateSQL += "'\(out)'," } else { updateSQL += "''," }
                    if let out = oldClient?.phone { updateSQL += "'\(out)'," } else { updateSQL += "''," }
                    if let out = oldClient?.married { updateSQL += "'\(out)'," } else { updateSQL += "''," }
                    if let out = oldClient?.work { updateSQL += "'\(out)'," } else { updateSQL += "''," }
                    if let salary = oldClient?.salary2 { updateSQL += "'\(salary)'," } else { updateSQL += "''," }
                    if let out = oldClient?.interesting { updateSQL += "'\(out)'," } else { updateSQL += "''," }
                    if let out = oldClient?.history { updateSQL += "'\(out)'," } else { updateSQL += "''," }
                    if let out = oldClient?.children { updateSQL += "'\(out)'," } else { updateSQL += "''," }
                    if let out = oldClient?.mortage { updateSQL += "'\(out)'," } else { updateSQL += "''," }
                    if let out = oldClient?.basic_others { updateSQL += "'\(out)'," } else { updateSQL += "''," }
                    if let out = oldClient?.year { updateSQL += "'\(out)'," } else { updateSQL += "''," }

                    updateSQL += getBoolean(input: ((oldClient?.personalityTraits_D)!))
                    updateSQL += getBoolean(input: ((oldClient?.personalityTraits_I)!))
                    updateSQL += getBoolean(input: ((oldClient?.personalityTraits_S)!))
                    updateSQL += getBoolean(input: ((oldClient?.personalityTraits_C)!))
                    if let out = oldClient?.personalityTraits_others { updateSQL += "'\(out)'," } else { updateSQL += "''," }
                    
                    updateSQL += getBoolean(input: ((oldClient?.decideRight)!))
                    updateSQL += getBoolean(input: ((oldClient?.decideRight2)!))
                    updateSQL += getBoolean(input: ((oldClient?.insuranceConcept)!))
                    updateSQL += getBoolean(input: ((oldClient?.insuranceConcept2)!))
                    updateSQL += getBoolean(input: ((oldClient?.sense)!))
                    updateSQL += getBoolean(input: ((oldClient?.sense2)!))
                    
                    updateSQL += getBoolean(input: ((oldClient?.lifeProblemNoSense)!))
                    updateSQL += getBoolean(input: ((oldClient?.lifeProblemNoService)!))
                    updateSQL += getBoolean(input: ((oldClient?.lifeProblemWorkUnstable)!))
                    if let out = oldClient?.lifeProblem_others { updateSQL += "'\(out)'," } else { updateSQL += "''," }
                    
                    updateSQL += getBoolean(input: ((oldClient?.fivePointDemandRetireRefund)!))
                    updateSQL += getBoolean(input: ((oldClient?.fivePointDemandLifeGuarantee)!))
                    updateSQL += getBoolean(input: ((oldClient?.fivePointDemandMedicalGuarantee)!))
                    updateSQL += getBoolean(input: ((oldClient?.fivePointDemandCareRefund)!))
                    updateSQL += getBoolean(input: ((oldClient?.fivePointDemandAssetTransport)!))
                    if let out = oldClient?.fivePointDemand_orhers { updateSQL += "'\(out)'," } else { updateSQL += "''," }
                    
                    updateSQL += getBoolean(input: ((oldClient?.buildBasicConceptYoungMan)!))
                    updateSQL += getBoolean(input: ((oldClient?.buildBasicConceptLifeTour)!))
                    updateSQL += getBoolean(input: ((oldClient?.buildBasicConceptBasket)!))
                    updateSQL += getBoolean(input: ((oldClient?.buildBasicConceptFourQ)!))
                    updateSQL += getBoolean(input: ((oldClient?.buildBasicConceptMeal)!))
                    if let out = oldClient?.buildBasicConcept_others { updateSQL += "'\(out)'," } else { updateSQL += "''," }
                    
                    updateSQL += getBoolean(input: ((oldClient?.strategyHealthPassword)!))
                    updateSQL += getBoolean(input: ((oldClient?.strategyCardHeart)!))
                    updateSQL += getBoolean(input: ((oldClient?.strategyMedicalHome)!))
                    updateSQL += getBoolean(input: ((oldClient?.strategyTaxationLecture)!))
                    updateSQL += getBoolean(input: ((oldClient?.strategyEvent)!))
                    updateSQL += getBoolean(input: ((oldClient?.strategyPeriodical)!))
                    if let out = oldClient?.strategy_others { updateSQL += "'\(out)'," } else { updateSQL += "''," }
                    
                    if let out = oldClient?.seventh_mainProduct_medicalCare { updateSQL += "'\(out)'," } else { updateSQL += "''," }
                    if let out = oldClient?.seventh_mainProduct_lifeGuarantee { updateSQL += "'\(out)'," } else { updateSQL += "''," }
                    if let out = oldClient?.seventh_mainProduct_moneySaving { updateSQL += "'\(out)'," } else { updateSQL += "''," }
                    if let out = oldClient?.seventh_mainProduct_others { updateSQL += "'\(out)'," } else { updateSQL += "''," }
//                    if let mainProduct_others = oldClient?.mainProduct_others { updateSQL += "'\(mainProduct_others)'," } else { updateSQL += "''," }
                    
                    updateSQL += getBoolean(input: ((oldClient?.oppositeProblemNoMoney)!))
                    updateSQL += getBoolean(input: ((oldClient?.oppositeProblemBuyTooMore)!))
                    updateSQL += getBoolean(input: ((oldClient?.oppositeProblemConsidering)!))
                    updateSQL += getBoolean(input: ((oldClient?.oppositeProblemDiscussing)!))
                    updateSQL += getBoolean(input: ((oldClient?.oppositeProblemFriend)!))
                    updateSQL += getBoolean(input: ((oldClient?.oppositeProblemHealthHistory)!))
                    updateSQL += getBoolean(input: ((oldClient?.oppositeProblemInvestOthers)!))
                    updateSQL += "'\(String(describing: (oldClient?.oppositeProblem_others)!))',"
                    
                    if let salePlan = oldClient?.salePlan { updateSQL += "'\(salePlan)')" } else { updateSQL += "'')" }
                    print("hhhh \(updateSQL)")
                    oldClient?.updateStatus = 3
                    appDel?.saveContext()
                    
                    DBconnect.executeQuery(query_string: updateSQL)
                } else if (oldClient?.updateStatus)! == 1 {
                    //check sql
                    var updateSQL = "UPDATE `client` SET "
                    if let out = oldClient?.name { updateSQL += "`name`='\(out)'," }
                    if let out = oldClient?.sex { updateSQL += "`sex`='\(out)'," }
                    
                    updateSQL += "`reasonCome`='\(String(describing: (oldClient?.reasonCome)!))',"
                    
                    if let out = oldClient?.seperate { updateSQL += "`seperate`='\(out)'," }
                    if let out = oldClient?.date { updateSQL += "`date`='\(out)'," }
                    if let out = oldClient?.phone { updateSQL += "`phone`='\(out)'," }
                    if let out = oldClient?.married { updateSQL += "`married`='\(out)'," }
                    if let out = oldClient?.work { updateSQL += "`work`='\(out)'," }
                    if let out = oldClient?.salary2 { updateSQL += "`salary2`='\(out)'," }
                    if let out = oldClient?.interesting { updateSQL += "`interesting`='\(out)'," }
                    if let out = oldClient?.history { updateSQL += "`history`='\(out)'," }
                    if let out = oldClient?.children { updateSQL += "`children`='\(out)'," }
                    if let out = oldClient?.mortage { updateSQL += "`mortage`='\(out)'," }
                    if let out = oldClient?.basic_others { updateSQL += "`basic_others`='\(out)'," }
                    if let out = oldClient?.year { updateSQL += "`year`='\(out)'," }
                    
                    updateSQL += "`personalityTraits_D`=\(getBoolean(input: (oldClient?.personalityTraits_D)!))"
                    updateSQL += "`personalityTraits_I`=\(getBoolean(input: (oldClient?.personalityTraits_I)!))"
                    updateSQL += "`personalityTraits_S`=\(getBoolean(input: (oldClient?.personalityTraits_S)!))"
                    updateSQL += "`personalityTraits_C`=\(getBoolean(input: (oldClient?.personalityTraits_C)!))"
                    if let out = oldClient?.personalityTraits_others { updateSQL += "`personalityTraits_others`='\(out)'," }
                    
                    updateSQL += "`decideRight`=\(getBoolean(input: (oldClient?.decideRight)!))"
                    updateSQL += "`decideRight2`=\(getBoolean(input: (oldClient?.decideRight2)!))"
                    updateSQL += "`insuranceConcept`=\(getBoolean(input: (oldClient?.insuranceConcept)!))"
                    updateSQL += "`insuranceConcept2`=\(getBoolean(input: (oldClient?.insuranceConcept2)!))"
                    updateSQL += "`sense`=\(getBoolean(input: (oldClient?.sense)!))"
                    updateSQL += "`sense2`=\(getBoolean(input: (oldClient?.sense2)!))"
                    
                    updateSQL += "`lifeProblemNoSense`=\(getBoolean(input: (oldClient?.lifeProblemNoSense)!))"
                    updateSQL += "`lifeProblemNoService`=\(getBoolean(input: (oldClient?.lifeProblemNoService)!))"
                    updateSQL += "`lifeProblemWorkUnstable`=\(getBoolean(input: (oldClient?.lifeProblemWorkUnstable)!))"
                    if let out = oldClient?.lifeProblem_others { updateSQL += "`lifeProblem_others`='\(out)'," }
                    
                    updateSQL += "`fivePointDemandRetireRefund`=\(getBoolean(input: (oldClient?.fivePointDemandRetireRefund)!))"
                    updateSQL += "`fivePointDemandLifeGuarantee`=\(getBoolean(input: (oldClient?.fivePointDemandLifeGuarantee)!))"
                    updateSQL += "`fivePointDemandMedicalGuarantee`=\(getBoolean(input: (oldClient?.fivePointDemandMedicalGuarantee)!))"
                    updateSQL += "`fivePointDemandCareRefund`=\(getBoolean(input: (oldClient?.fivePointDemandCareRefund)!))"
                    updateSQL += "`fivePointDemandAssetTransport`=\(getBoolean(input: (oldClient?.fivePointDemandAssetTransport)!))"
                    if let out = oldClient?.fivePointDemand_orhers { updateSQL += "`fivePointDemand_others`='\(out)'," }
                    
                    updateSQL += "`buildBasicConceptYoungMan`=\(getBoolean(input: (oldClient?.buildBasicConceptYoungMan)!))"
                    updateSQL += "`buildBasicConceptLifeTour`=\(getBoolean(input: (oldClient?.buildBasicConceptLifeTour)!))"
                    updateSQL += "`buildBasicConceptBasket`=\(getBoolean(input: (oldClient?.buildBasicConceptBasket)!))"
                    updateSQL += "`buildBasicConceptFourQ`=\(getBoolean(input: (oldClient?.buildBasicConceptFourQ)!))"
                    updateSQL += "`buildBasicConceptMeal`=\(getBoolean(input: (oldClient?.buildBasicConceptMeal)!))"
                    if let out = oldClient?.buildBasicConcept_others { updateSQL += "`buildBasicConcept_others`='\(out)'," }
                    
                    updateSQL += "`strategyHealthPassword`=\(getBoolean(input: (oldClient?.strategyHealthPassword)!))"
                    updateSQL += "`strategyCardHeart`=\(getBoolean(input: (oldClient?.strategyCardHeart)!))"
                    updateSQL += "`strategyMedicalHome`=\(getBoolean(input: (oldClient?.strategyMedicalHome)!))"
                    updateSQL += "`strategyTaxationLecture`=\(getBoolean(input: (oldClient?.strategyTaxationLecture)!))"
                    updateSQL += "`strategyEvent`=\(getBoolean(input: (oldClient?.strategyEvent)!))"
                    updateSQL += "`strategyPeriodical`=\(getBoolean(input: (oldClient?.strategyPeriodical)!))"
                    if let out = oldClient?.strategy_others { updateSQL += "`strategy_others`='\(out)'," }
                    
                    if let out = oldClient?.seventh_mainProduct_medicalCare { updateSQL += "`seventh_mainProduct_medicalCare`='\(out)'," }
                    if let out = oldClient?.seventh_mainProduct_lifeGuarantee { updateSQL += "`seventh_mainProduct_lifeGuarantee`='\(out)'," }
                    if let out = oldClient?.seventh_mainProduct_moneySaving { updateSQL += "`seventh_mainProduct_moneySaving`='\(out)'," }
                    if let out = oldClient?.seventh_mainProduct_others { updateSQL += "`seventh_mainProduct_others`='\(out)'," }
                      if let mainProduct_others = oldClient?.mainProduct_others { updateSQL += "`mainProduct_others`='\(mainProduct_others)'," }
                    updateSQL += "`oppositeProblemNoMoney`=\(getBoolean(input: (oldClient?.oppositeProblemNoMoney)!))"
                    updateSQL += "`oppositeProblemBuyTooMore`=\(getBoolean(input: (oldClient?.oppositeProblemBuyTooMore)!))"
                    updateSQL += "`oppositeProblemConsidering`=\(getBoolean(input: (oldClient?.oppositeProblemConsidering)!))"
                    updateSQL += "`oppositeProblemDiscussing`=\(getBoolean(input: (oldClient?.oppositeProblemDiscussing)!))"
                    updateSQL += "`oppositeProblemFriend`=\(getBoolean(input: (oldClient?.oppositeProblemFriend)!))"
                    updateSQL += "`oppositeProblemHealthHistory`=\(getBoolean(input: (oldClient?.oppositeProblemHealthHistory)!))"
                    updateSQL += "`oppositeProblemInvestOthers`=\(getBoolean(input: (oldClient?.oppositeProblemInvestOthers)!))"
                    if let out = oldClient?.oppositeProblem_others { updateSQL += "`oppositeProblem_others`='\(out)'," }
                    
                    if let out = oldClient?.salePlan { updateSQL += "`salePlan`='\(out)'" } else { updateSQL += "`salePlan`=''" }
                    
                    updateSQL += " WHERE `name`='\(String(describing: (oldClient?.name)!))' AND `sex`='\(String(describing: (oldClient?.sex)!))' AND `date`='\(String(describing: (oldClient?.date)!))'"
                    
                    print(updateSQL)
                    
                    oldClient?.updateStatus = 3
                    appDel?.saveContext()
                    DBconnect.executeQuery(query_string: updateSQL)
                } else if (oldClient?.updateStatus)! == 2 {
                    var updateSQL = "DELETE FROM `client` WHERE `data_sn`=\(data_sn) AND `name`='\(String(describing: (oldClient?.name)!))' AND `sex`='\(String(describing: (oldClient?.sex)!))' AND `date`='\(String(describing: (oldClient?.date)!))'"
                    
                    print(updateSQL)
                    context.delete(oldClient!)
                    appDel?.saveContext()
                    
                    DBconnect.executeQuery(query_string: updateSQL)
                }
            }
        }catch{
        }
    }
    
    func updateSQLorangeCLient() {
        let appDel = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDel?.persistentContainer.viewContext else { return }
        
        do{
            let result = try context.fetch(OrangeClient.fetchRequest())
            
            for item in result{
                let oldClient = item as? OrangeClient
                if oldClient?.updateStatus != nil {
                print("hey! updateSQL orangeClient ; status = \(oldClient?.updateStatus)")
                if (oldClient?.updateStatus)! == 0 {
                    var updateSQL = "INSERT INTO `OrangeClient`(`data_sn`, `name`, `buildDate`, `reason2`, `sex`, `phoneNumber`, `education`, `year`, `children`, `married`, `seniority`, `salary`, `work`, `mateWork`, `traffic`, `live`, `basic_other`, `sec_personalityTraits_D`, `sec_personalityTraits_I`, `sec_personalityTraits_S`, `sec_personalityTraits_C`, `sec_personalityTraits_haveTarget`, `sec_personalityTraits_nowUnstable`, `sec_personalityTraits_makeMoney`, `sec_personalityTraits_likeFreedomLife`, `sec_personalityTraits_wantBeLeader`, `sec_personalityTraits_others`, `third_lifeProblem_home`, `third_lifeProblem_work`, `third_lifeProblem_others`, `fourth_fivePointDemand_resonablePay`, `fourth_fivePointDemand_chancePromotion`, `fourth_fivePointDemand_growUp`, `fourth_fovePointDemand_worthOnWork`, `fourth_fivePointDeamnd_prospect`, `fourht_fivePointDemand_others`, `fifth_careerConcept_ESBI`, `fifth_careerConcept_duelCareer`, `fifth_careerConcept_threeLineInLife`, `fifth_careerConcept_introduceTeam`, `fifth_careerConcept_others`, `sixth_stragegy_eventWork`, `sixth_stragegy_eventDepartment`, `sixth_stragegy_eventPersonal`, `sixth_stragegy_professionBasic`, `sixth_stragegy_prefessionTrain`, `sixth_stragegy_professionLicenses`, `sixth_stragegy_others`, `seventh_mainProduct_lifeGuarantee`, `seventh_mainProduct_medicalCare`, `seventh_mainProduct_moneySaving`, `seventh_mainProduct_others`, `eighth_objectionProblem_incomeUnstable`, `eighth_objectionProblem_marketSaturation`, `eighth_objectionProblem_noBusiness`, `eighth_objectionProblem_noClient`, `eighth_objectionProblem_familyOpposite`, `eighth_objectionProblem_others`, `ninth_salePlan`) VALUES ("
                    
                    updateSQL += "'\(data_sn)',"
                    
                    if let out = oldClient?.name { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.buildDate { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.reason2 { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.sex { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.phoneNumber { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.education { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.year { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.children { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.married { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.seniority { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.salary { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.work { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.mateWork { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.traffic { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.live { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.basic_other { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    
                    updateSQL += getBoolean(input: (oldClient?.sec_personalityTraits_D)!)
                    updateSQL += getBoolean(input: (oldClient?.sec_personalityTraits_I)!)
                    updateSQL += getBoolean(input: (oldClient?.sec_personalityTraits_S)!)
                    updateSQL += getBoolean(input: (oldClient?.sec_personalityTraits_C)!)
                    updateSQL += getBoolean(input: (oldClient?.sec_personalityTraits_haveTarget)!)
                    updateSQL += getBoolean(input: (oldClient?.sec_personalityTraits_nowUnstable)!)
                    updateSQL += getBoolean(input: (oldClient?.sec_personalityTraits_makeMoney)!)
                    updateSQL += getBoolean(input: (oldClient?.sec_personalityTraits_likeFreedomLife)!)
                    updateSQL += getBoolean(input: (oldClient?.sec_personalityTraits_wantBeLeader)!)
                    if let out = oldClient?.sec_personalityTraits_others { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    
                    if let out = oldClient?.third_lifeProblem_home { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.third_lifeProblem_work { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.third_lifeProblem_others { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    
                    updateSQL += getBoolean(input: (oldClient?.fourth_fivePointDemand_resonablePay)!)
                    updateSQL += getBoolean(input: (oldClient?.fourth_fivePointDemand_chancePromotion)!)
                    updateSQL += getBoolean(input: (oldClient?.fourth_fivePointDemand_growUp)!)
                    updateSQL += getBoolean(input: (oldClient?.fourth_fovePointDemand_worthOnWork)!)
                    updateSQL += getBoolean(input: (oldClient?.fourth_fivePointDeamnd_prospect)!)
                    if let out = oldClient?.fourht_fivePointDemand_others { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    
                    updateSQL += getBoolean(input: (oldClient?.fifth_careerConcept_ESBI)!)
                    updateSQL += getBoolean(input: (oldClient?.fifth_careerConcept_duelCareer)!)
                    updateSQL += getBoolean(input: (oldClient?.fifth_careerConcept_threeLineInLife)!)
                    updateSQL += getBoolean(input: (oldClient?.fifth_careerConcept_introduceTeam)!)
                    if let out = oldClient?.fifth_careerConcept_others { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    
                    if let out = oldClient?.sixth_stragegy_eventWork { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.sixth_stragegy_eventDepartment { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.sixth_stragegy_eventPersonal { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.sixth_stragegy_professionBasic { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.sixth_stragegy_prefessionTrain { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.sixth_stragegy_professionLicenses { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.sixth_stragegy_others { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    
                    if let out = oldClient?.seventh_mainProduct_lifeGuarantee { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.seventh_mainProduct_medicalCare { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.seventh_mainProduct_moneySaving { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = oldClient?.seventh_mainProduct_others { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    
                    updateSQL += getBoolean(input: (oldClient?.eighth_objectionProblem_incomeUnstable)!)
                    updateSQL += getBoolean(input: (oldClient?.eighth_objectionProblem_marketSaturation)!)
                    updateSQL += getBoolean(input: (oldClient?.eighth_objectionProblem_noBusiness)!)
                    updateSQL += getBoolean(input: (oldClient?.eighth_objectionProblem_noClient)!)
                    updateSQL += getBoolean(input: (oldClient?.eighth_objectionProblem_familyOpposite)!)
                    if let out = oldClient?.eighth_objectionProblem_others { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    
                    if let out = oldClient?.ninth_salePlan { updateSQL += "'\(out)')" } else { updateSQL += "'')"}
                    
                    print(updateSQL)
                    
                    oldClient?.updateStatus = 3
                    appDel?.saveContext()
                    
                    DBconnect.executeQuery(query_string: updateSQL)
                }   else if (oldClient?.updateStatus)! == 1 {
                    var updateSQL = "UPDATE `OrangeClient` SET "
                    
                    if let out = oldClient?.name { updateSQL += "`name`='\(out)',"}
                    if let out = oldClient?.buildDate { updateSQL += "`buildDate`='\(out)',"}
                    
                    if let out = oldClient?.reason2 { updateSQL += "`reason2`='\(out)',"}
                    if let out = oldClient?.sex { updateSQL += "`sex`='\(out)',"}
                    if let out = oldClient?.phoneNumber { updateSQL += "`phoneNumber`='\(out)',"}
                    if let out = oldClient?.education { updateSQL += "`education`='\(out)',"}
                    if let out = oldClient?.year { updateSQL += "`year`='\(out)',"}
                    if let out = oldClient?.children { updateSQL += "`children`='\(out)',"}
                    if let out = oldClient?.married { updateSQL += "`married`='\(out)',"}
                    if let out = oldClient?.seniority { updateSQL += "`seniority`='\(out)',"}
                    if let out = oldClient?.salary { updateSQL += "`salary`='\(out)',"}
                    if let out = oldClient?.work { updateSQL += "`work`='\(out)',"}
                    if let out = oldClient?.mateWork { updateSQL += "`mateWork`='\(out)',"}
                    if let out = oldClient?.traffic { updateSQL += "`traffic`='\(out)',"}
                    if let out = oldClient?.live { updateSQL += "`live`='\(out)',"}
                    if let out = oldClient?.basic_other { updateSQL += "`basic_other`='\(out)',"}
                    
                    updateSQL += "`sec_personalityTraits_D`=\(getBoolean(input: (oldClient?.sec_personalityTraits_D)!))"
                    updateSQL += "`sec_personalityTraits_I`=\(getBoolean(input: (oldClient?.sec_personalityTraits_I)!))"
                    updateSQL += "`sec_personalityTraits_S`=\(getBoolean(input: (oldClient?.sec_personalityTraits_S)!))"
                    updateSQL += "`sec_personalityTraits_C`=\(getBoolean(input: (oldClient?.sec_personalityTraits_C)!))"
                    updateSQL += "`sec_personalityTraits_haveTarget`=\(getBoolean(input: (oldClient?.sec_personalityTraits_haveTarget)!))"
                    updateSQL += "`sec_personalityTraits_nowUnstable`=\(getBoolean(input: (oldClient?.sec_personalityTraits_nowUnstable)!))"
                    updateSQL += "`sec_personalityTraits_makeMoney`=\(getBoolean(input: (oldClient?.sec_personalityTraits_makeMoney)!))"
                    updateSQL += "`sec_personalityTraits_likeFreedomLife`=\(getBoolean(input: (oldClient?.sec_personalityTraits_likeFreedomLife)!))"
                    updateSQL += "`sec_personalityTraits_wantBeLeader`=\(getBoolean(input: (oldClient?.sec_personalityTraits_wantBeLeader)!))"
                    if let out = oldClient?.sec_personalityTraits_others { updateSQL += "`sec_personalityTraits_others`='\(out)',"}
                    
                    if let out = oldClient?.third_lifeProblem_home { updateSQL += "`third_lifeProblem_home`='\(out)',"}
                    if let out = oldClient?.third_lifeProblem_work { updateSQL += "`third_lifeProblem_work`='\(out)',"}
                    if let out = oldClient?.third_lifeProblem_others { updateSQL += "`third_lifeProblem_others`='\(out)',"}
                    
                    updateSQL += "`fourth_fivePointDemand_resonablePay`=\(getBoolean(input: (oldClient?.fourth_fivePointDemand_resonablePay)!))"
                    updateSQL += "`fourth_fivePointDemand_chancePromotion`=\(getBoolean(input: (oldClient?.fourth_fivePointDemand_chancePromotion)!))"
                    updateSQL += "`fourth_fivePointDemand_growUp`=\(getBoolean(input: (oldClient?.fourth_fivePointDemand_growUp)!))"
                    updateSQL += "`fourth_fovePointDemand_worthOnWork`=\(getBoolean(input: (oldClient?.fourth_fovePointDemand_worthOnWork)!))"
                    updateSQL += "`fourth_fivePointDeamnd_prospect`=\(getBoolean(input: (oldClient?.fourth_fivePointDeamnd_prospect)!))"
                    if let out = oldClient?.fourht_fivePointDemand_others { updateSQL += "`fourht_fivePointDemand_others`='\(out)',"}
                    
                    updateSQL += "`fifth_careerConcept_ESBI`=\(getBoolean(input: (oldClient?.fifth_careerConcept_ESBI)!))"
                    updateSQL += "`fifth_careerConcept_duelCareer`=\(getBoolean(input: (oldClient?.fifth_careerConcept_duelCareer)!))"
                    updateSQL += "`fifth_careerConcept_threeLineInLife`=\(getBoolean(input: (oldClient?.fifth_careerConcept_threeLineInLife)!))"
                    updateSQL += "`fifth_careerConcept_introduceTeam`=\(getBoolean(input: (oldClient?.fifth_careerConcept_introduceTeam)!))"
                    if let out = oldClient?.fifth_careerConcept_others { updateSQL += "`fifth_careerConcept_others`='\(out)',"}
                    
                    if let out = oldClient?.sixth_stragegy_eventWork { updateSQL += "`sixth_stragegy_eventWork`='\(out)',"}
                    if let out = oldClient?.sixth_stragegy_eventDepartment { updateSQL += "`sixth_stragegy_eventDepartment`='\(out)',"}
                    if let out = oldClient?.sixth_stragegy_eventPersonal { updateSQL += "`sixth_stragegy_eventPersonal`='\(out)',"}
                    if let out = oldClient?.sixth_stragegy_professionBasic { updateSQL += "`sixth_stragegy_professionBasic`='\(out)',"}
                    if let out = oldClient?.sixth_stragegy_prefessionTrain { updateSQL += "`sixth_stragegy_prefessionTrain`='\(out)',"}
                    if let out = oldClient?.sixth_stragegy_professionLicenses { updateSQL += "`sixth_stragegy_professionLicenses`='\(out)',"}
                    if let out = oldClient?.sixth_stragegy_others { updateSQL += "`sixth_stragegy_others`='\(out)',"}
                    
                    if let out = oldClient?.seventh_mainProduct_lifeGuarantee { updateSQL += "`seventh_mainProduct_lifeGuarantee`='\(out)',"}
                    if let out = oldClient?.seventh_mainProduct_medicalCare { updateSQL += "`seventh_mainProduct_medicalCare`='\(out)',"}
                    if let out = oldClient?.seventh_mainProduct_moneySaving { updateSQL += "`seventh_mainProduct_moneySaving`='\(out)',"}
                    if let out = oldClient?.seventh_mainProduct_others { updateSQL += "`seventh_mainProduct_others`='\(out)',"}
                    
                    updateSQL += "`eighth_objectionProblem_incomeUnstable`=\(getBoolean(input: (oldClient?.eighth_objectionProblem_incomeUnstable)!))"
                    updateSQL += "`eighth_objectionProblem_marketSaturation`=\(getBoolean(input: (oldClient?.eighth_objectionProblem_marketSaturation)!))"
                    updateSQL += "`eighth_objectionProblem_noBusiness`=\(getBoolean(input: (oldClient?.eighth_objectionProblem_noBusiness)!))"
                    updateSQL += "`eighth_objectionProblem_noClient`=\(getBoolean(input: (oldClient?.eighth_objectionProblem_noClient)!))"
                    updateSQL += "`eighth_objectionProblem_familyOpposite`=\(getBoolean(input: (oldClient?.eighth_objectionProblem_familyOpposite)!))"
                    if let out = oldClient?.eighth_objectionProblem_others { updateSQL += "`eighth_objectionProblem_others`='\(out)',"}
                    
                    if let out = oldClient?.ninth_salePlan { updateSQL += "`ninth_salePlan`='\(out)' "}
                    
                    updateSQL += " WHERE `data_sn`='\(data_sn)' AND `name`='\(String(describing: (oldClient?.name)!))' AND `buildDate`='\(String(describing: (oldClient?.buildDate)!))'"
                    
                    print(updateSQL)
                    
                    DBconnect.executeQuery(query_string: updateSQL)
                    oldClient?.updateStatus = 3
                    
                    appDel?.saveContext()
                }   else if oldClient?.updateStatus == 2 {
                    var updateSQL = "DELETE FROM `OrangeClient` WHERE `data_sn`=\(data_sn) AND `name`='\(String(describing: (oldClient?.name)!))' AND `sex`='\(String(describing: (oldClient?.sex)!))' AND `buildDate`='\(String(describing: (oldClient?.buildDate)!))'"
                    print(updateSQL)
                    
                    DBconnect.executeQuery(query_string: updateSQL)
                    
                    context.delete(oldClient!)
                    appDel?.saveContext()
                }
                }
            }
        } catch {}
    }
    
    func updateSQLNote() {
        let appDel = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDel?.persistentContainer.viewContext else { return }
        
        do {
            let result = try context.fetch(Note.fetchRequest())
            for item in result {
                let note = item as? Note
                print("notice above")
                print("hey updateSQLnote status = \((note?.updateStatus))")

                if note?.updateStatus != nil {
                     print("hey updateSQLnote status = \((note?.updateStatus)!)")
                if (note?.updateStatus)! == 0 {
                    var updateSQL = "INSERT INTO `note`(`data_sn`, `clientBuildDate`, `clientName`, `clientPhoneNumber`, `content`, `creatDate`) VALUES ("
                    
                    updateSQL += "'\(data_sn)',"
                    if let out = note?.clientBuildDate { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = note?.clientName { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = note?.clientPhoneNumber { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = note?.content { updateSQL += "'\(out)'," } else { updateSQL += "'',"}
                    if let out = note?.creatDate { updateSQL += "'\(out)')" } else { updateSQL += "'')"}
                    
                    print(updateSQL)
                    
                    DBconnect.executeQuery(query_string: updateSQL)
                    
                    note?.updateStatus = 3
                    appDel?.saveContext()
                } else if (note?.updateStatus)! == 1 {
                    var updateSQL = "UPDATE `note` SET "
                    
                    if let out = note?.content { updateSQL += "`content`='\(out)'," }
                    if let out = note?.creatDate { updateSQL += "`creatDate`='\(out)' " }
                    
                    updateSQL += "WHERE `data_sn`='\(data_sn)' AND "
                    
                    if let out = note?.clientBuildDate { updateSQL += "`clientBuildDate`='\(out)' AND " }
                    if let out = note?.clientName { updateSQL += "`clientName`='\(out)' AND " }
                    if let out = note?.clientPhoneNumber { updateSQL += "`clientPhoneNumber`='\(out)'" }
                    
                    print(updateSQL)
                    
                    DBconnect.executeQuery(query_string: updateSQL)
                    
                    note?.updateStatus = 3
                    appDel?.saveContext()
                } else if (note?.updateStatus)! == 2 {
                    var updateSQL = "DELETE FROM `note` "
                    
                    updateSQL += "WHERE `data_sn`='\(data_sn)' AND"
                    
                    if let out = note?.clientBuildDate { updateSQL += "`clientBuildDate`='\(out)' AND " }
                    if let out = note?.clientName { updateSQL += "`clientName`='\(out)' AND " }
                    if let out = note?.clientPhoneNumber { updateSQL += "`clientPhoneNumber`='\(out)'" }
                    
                    print(updateSQL)
                    
                    DBconnect.executeQuery(query_string: updateSQL)
                    
                    context.delete(note!)
                    appDel?.saveContext()
                }
                    
                }
            }
                
        } catch {}
        
        
    }
}
