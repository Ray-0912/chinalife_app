//
//  OCVC.swift
//  HelloCoreData
//
//  Created by 楊昇融 on 2017/2/25.
//  Copyright © 2017年 楊昇融. All rights reserved.
//

import UIKit
import EventKit

class OCVC: UIViewController,UIPopoverPresentationControllerDelegate,passParameter,ChildrenPickpassParameter5,ChildrenPickpassParameter6 {
    
    func passParameter(Str: String){
        print(Str)
        let split = Str.components(separatedBy: ",")
        first_year.text = split[0]
        TheBirth = split[1] }
    
    func  ChildrenPickpassParameter5(Str: String){
        first_children.text = Str }
    
    func  ChildrenPickpassParameter6(Str: String){
        first_married.text = Str }
    
    var data_sn : String = ""
    var savedEventId : String = ""
    
    var preName : String = ""
    var preSex : String = ""
    var preBuildDate : String = ""
    var preYear : String = ""
    var prephone: String = ""
    
    var TheBirth : String = ""  // 從年齡的txtfield傳回來的值 yyyy/mm/dd
    var clientClass : String = "增員"
    var index :Int = 0
    var isSearchState : Bool?
    var passName: String = ""
    var passSex: String = ""
    var passBuildDate : String = ""
    var nameArr : [module] = [module]()
    
    var update : Int16 = 0
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
    
    @IBOutlet weak var txt_buildDate: UITextField!
    @IBOutlet weak var txt_name: UITextField!
    @IBOutlet weak var btn_reasonA: UIButton!
    @IBOutlet weak var btn_reasonB: UIButton!
    @IBOutlet weak var btn_reasonC: UIButton!
    @IBOutlet weak var sex_boy: UIButton!
    @IBOutlet weak var sex_girl: UIButton!
    
    var reason : String = ""
    var sex : String = ""
    
    //１．幾本資料
    @IBOutlet weak var first_phoneNumber: UITextField!
    @IBOutlet weak var first_education: UITextField!
    @IBOutlet weak var first_year: UITextField!
    @IBOutlet weak var first_children: UITextField!
    @IBOutlet weak var first_married: UITextField!
    @IBOutlet weak var first_seniority: UITextField!
    @IBOutlet weak var first_work: UITextField!
    @IBOutlet weak var first_mateWork: UITextField!
    @IBOutlet weak var first_salary: UITextField!
    @IBOutlet weak var first_traffic: UITextField!
    @IBOutlet weak var first_live: UITextField!
    @IBOutlet weak var first_others: UITextField!
    
    //２．人格特質
    @IBOutlet weak var sec_D: UIButton!
    @IBOutlet weak var sec_I: UIButton!
    @IBOutlet weak var sec_S: UIButton!
    @IBOutlet weak var sec_C: UIButton!
    @IBOutlet weak var sec_haveTarget: UIButton!
    @IBOutlet weak var sec_niwUnstable: UIButton!
    @IBOutlet weak var sec_likeMoney: UIButton!
    @IBOutlet weak var sec_likeFreedomLife: UIButton!
    @IBOutlet weak var sec_wantBeLeader: UIButton!
    @IBOutlet weak var sec_others: UITextField!
    
    var perD : Bool = false
    var perI : Bool = false
    var perS : Bool = false
    var perC : Bool = false
    var perTarget : Bool = false
    var perNow : Bool = false
    var perMakeMoney : Bool = false
    var perLikeFreedom : Bool = false
    var perWantBeLeader : Bool = false
    
    //３．人生問題
    @IBOutlet weak var third_home: UITextField!
    @IBOutlet weak var third_work: UITextField!
    @IBOutlet weak var third_others: UITextField!
    
    //４．五大需求
    @IBOutlet weak var fourth_reasonablePay: UIButton!
    @IBOutlet weak var fourth_chancePromotion: UIButton!
    @IBOutlet weak var fourth_growUp: UIButton!
    @IBOutlet weak var fourth_workWorth: UIButton!
    @IBOutlet weak var fourth_prospect: UIButton!
    @IBOutlet weak var fourth_others: UITextField!
    
    var fourthReasonablePay : Bool = false
    var fourthChancePromotion : Bool = false
    var fourthGrowUp : Bool = false
    var fourthWorkWorth : Bool = false
    var fourthProspect : Bool = false
    
    //５．事業觀念
    @IBOutlet weak var fifth_ESBI: UIButton!
    @IBOutlet weak var fifth_duelCareer: UIButton!
    @IBOutlet weak var fifth_lifeThreeLine: UIButton!
    @IBOutlet weak var fifth_teamIntroduce: UIButton!
    @IBOutlet weak var fifth_others: UITextField!
    
    var fifthESBI : Bool = false
    var fifthDuelCareer : Bool = false
    var fifthLifeThreeLine : Bool = false
    var fifthTeamIntroduce : Bool = false
    
    //６．策略
    @IBOutlet weak var sixth_eventCompany: UITextField!
    @IBOutlet weak var sixth_eventDepartment: UITextField!
    @IBOutlet weak var sixth_eventPersonal: UITextField!
    @IBOutlet weak var sixth_professionBasic: UITextField!
    @IBOutlet weak var sixth_professionTrain: UITextField!
    @IBOutlet weak var sixth_professionLicense: UITextField!
    @IBOutlet weak var sixth_others: UITextField!
    
    //７．主力商品
    @IBOutlet weak var seventh_lifeGuarantee: UITextField!
    @IBOutlet weak var seventh_medicalCare: UITextField!
    @IBOutlet weak var seventh_savingMoney: UITextField!
    @IBOutlet weak var seventh_others: UITextField!
    
    //８．異議問題
    @IBOutlet weak var eighth_incomeUnstable: UIButton!
    @IBOutlet weak var eighth_marketSaturation: UIButton!
    @IBOutlet weak var eighth_noBusiness: UIButton!
    @IBOutlet weak var eighth_noClient: UIButton!
    @IBOutlet weak var eighth_familyOpposite: UIButton!
    @IBOutlet weak var eighth_others: UITextField!
    
    var eighthIncomeUnstable : Bool = false
    var eighthMarketSaturation : Bool = false
    var eighthNoBusiness : Bool = false
    var eighthNoClient : Bool = false
    var eighthFamilyOpposite : Bool = false
    
    //９．行銷計畫
    @IBOutlet weak var ninth_salePlan: UITextField!
    
    
    @IBAction func btn_reason(_ sender: UIButton) {
        switch sender.tag {
        case 0 :
            sender.setImage(UIImage(named: "check"), for: .normal)
            btn_reasonB.setImage(UIImage(named : "checkbox"), for: .normal)
            btn_reasonC.setImage(UIImage(named : "checkbox"), for: .normal)
            reason = "緣故"
        case 2 :
            sender.setImage(UIImage(named : "check"), for: .normal)
            btn_reasonA.setImage(UIImage(named : "checkbox"), for: .normal)
            btn_reasonB.setImage(UIImage(named : "checkbox"), for: .normal)
            reason = "轉介紹"
        default:
            sender.setImage(UIImage(named: "check"), for: .normal)
            btn_reasonA.setImage(UIImage(named : "checkbox"), for: .normal)
            btn_reasonC.setImage(UIImage(named : "checkbox"), for: .normal)
            reason = "陌生"
        }
    }
    
    
    @IBAction func btn_sex(_ sender: UIButton) {
        switch sender.tag {
        case 0 :
            sender.setImage(UIImage(named : "check"), for: .normal)
            sex_girl.setImage(UIImage(named : "checkbox"), for: .normal)
            sex = "男"
        default:
            sender.setImage(UIImage(named : "check"), for: .normal)
            sex_boy.setImage(UIImage(named : "checkbox"), for: .normal)
            sex = "女"
        }
    }
    
    @IBAction func age(_ sender: Any) {
        performSegue(withIdentifier: "godate2", sender: self)
    }
    
    @IBAction func marry(_ sender: Any) {
        performSegue(withIdentifier: "gomarry2", sender: self)
    }
    
    @IBAction func child(_ sender: Any) {
        performSegue(withIdentifier: "gochild2", sender: self)
    }
    
    @IBAction func btn_sec_personalityTraits(_ sender: UIButton) {
        switch sender.tag {
        case 0 :
            sender.setImage(UIImage(named : (perD ? "checkbox" : "check")), for: .normal)
            perD = perD ? false : true
        case 1 :
            sender.setImage(UIImage(named : (perI ? "checkbox" : "check")), for: .normal)
            perI = perI ? false : true
        case 2 :
            sender.setImage(UIImage(named : (perS ? "checkbox" : "check")), for: .normal)
            perS = perS ? false : true
        case 3 :
            sender.setImage(UIImage(named : (perC ? "checkbox" : "check")), for: .normal)
            perC = perC ? false : true
        case 4 :
            sender.setImage(UIImage(named : (perTarget ? "checkbox" : "check")), for: .normal)
            perTarget = perTarget ? false : true
        case 5 :
            sender.setImage(UIImage(named : (perNow ? "checkbox" : "check")), for: .normal)
            perNow = perNow ? false : true
        case 6 :
            sender.setImage(UIImage(named : (perMakeMoney ? "checkbox" : "check")), for: .normal)
            perMakeMoney = perMakeMoney ? false : true
        case 7 :
            sender.setImage(UIImage(named : (perLikeFreedom ? "checkbox" : "check")), for: .normal)
            perLikeFreedom = perLikeFreedom ? false : true
        default:
            sender.setImage(UIImage(named : (perWantBeLeader ? "checkbox" : "check")), for: .normal)
            perWantBeLeader = perWantBeLeader ? false : true
        }
    }
    
    
    @IBAction func btn_fourth_fivePointDemand(_ sender: UIButton){
        switch sender.tag {
        case 0 :
            sender.setImage(UIImage(named : (fourthReasonablePay ? "checkbox" : "check")), for: .normal)
            fourthReasonablePay = fourthReasonablePay ? false : true
        case 1 :
            sender.setImage(UIImage(named : (fourthChancePromotion ? "checkbox" : "check")), for: .normal)
            fourthChancePromotion = fourthChancePromotion ? false : true
        case 2 :
            sender.setImage(UIImage(named : (fourthGrowUp ? "checkbox" : "check")), for: .normal)
            fourthGrowUp = fourthGrowUp ? false : true
        case 3 :
            sender.setImage(UIImage(named : (fourthWorkWorth ? "checkbox" : "check")), for: .normal)
            fourthWorkWorth = fourthWorkWorth ? false : true
        default:
            sender.setImage(UIImage(named : (fourthProspect ? "checkbox" : "check")), for: .normal)
            fourthProspect = fourthProspect ? false : true
        }
    }
    
    
    @IBAction func btn_fifth_careerConcept(_ sender: UIButton) {
        switch sender.tag {
        case 0 :
            sender.setImage(UIImage(named : (fifthESBI ? "checkbox" : "check")), for: .normal)
            fifthESBI = fifthESBI ? false : true
        case 1 :
            sender.setImage(UIImage(named : (fifthDuelCareer ? "checkbox" : "check")), for: .normal)
            fifthDuelCareer = fifthDuelCareer ? false : true
        case 2 :
            sender.setImage(UIImage(named : (fifthLifeThreeLine ? "checkbox" : "check")), for: .normal)
            fifthLifeThreeLine = fifthLifeThreeLine ? false : true
        default:
            sender.setImage(UIImage(named : (fifthTeamIntroduce ? "checkbox" : "check")), for: .normal)
            fifthTeamIntroduce = fifthTeamIntroduce ? false : true
        }
    }
    
    
    @IBAction func btn_eighth_oppositeProblem(_ sender: UIButton) {
        switch sender.tag {
        case 0 :
            sender.setImage(UIImage(named : (eighthIncomeUnstable ? "checkbox" : "check")), for: .normal)
            eighthIncomeUnstable = eighthIncomeUnstable ? false : true
        case 1 :
            sender.setImage(UIImage(named : (eighthMarketSaturation ? "checkbox" : "check")), for: .normal)
            eighthMarketSaturation = eighthMarketSaturation ? false : true
        case 2 :
            sender.setImage(UIImage(named : (eighthNoBusiness ? "checkbox" : "check")), for: .normal)
            eighthNoBusiness = eighthNoBusiness ? false : true
        case 3 :
            sender.setImage(UIImage(named : (eighthNoClient ? "checkbox" : "check")), for: .normal)
            eighthNoClient = eighthNoClient ? false : true
        default:
            sender.setImage(UIImage(named : (eighthFamilyOpposite ? "checkbox" : "check")), for: .normal)
            eighthFamilyOpposite = eighthFamilyOpposite ? false : true
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
//    @IBOutlet weak var note: UIBarButtonItem!
    
    
    func backButtonTapped() {
        
        let alertController = UIAlertController(
            title: "尚未儲存",
            message: "資料未儲存，要儲存嗎",
            preferredStyle: .alert)
        
        // 建立[取消]按鈕
        let cancelAction = UIAlertAction(
            title: "取消",
            style: .cancel,
            handler: nil)
        alertController.addAction(cancelAction)
        
        // 建立[送出]按鈕
        let okAction = UIAlertAction(
            title: "儲存",
            style: .default,
            handler: {
                (action: UIAlertAction!) -> Void in
                if self.preName == ""{
                    self.buildUpNewOne()
                }else if self.preName != ""{
                    self.changeEventData()
                    self.updateOldClient(clientName: self.preName, clientSex: self.preSex, clientBuildDate: self.preBuildDate, clientYear: self.preYear)
                }
                self.navigationController?.popViewController(animated: true)
        })
        alertController.addAction(okAction)
        
        // 顯示提示框
        self.present(
            alertController,
            animated: true,
            completion: nil)
        

    }
    
    func updateNameOrSex() {
        let alertController = UIAlertController(
            title: "提示",
            message: "由於你更改了名字或性別會嚴重影響到資料庫，必須連接網路更改資料，是否更改",
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
        
        let noAction = UIAlertAction(
            title: "取消",
            style: .default,
            handler: {
                (action: UIAlertAction!) -> Void in
                self.checkInterNetAndUpdate()
        })
        alertController.addAction(noAction)
        
        // 顯示提示框
        self.present(
            alertController,
            animated: true,
            completion: nil)
    }
    
    func checkInterNetAndUpdate() {
        let checkInternet : Bool = checkInternetFunction()
        if checkInternet == true {
            self.updateSQLorangeCLient()
            self.updateOldClient(clientName: self.preName, clientSex: self.preSex, clientBuildDate: self.preBuildDate, clientYear: self.preYear)
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
    

    func edit() {
        if preName == ""{
            buildUpNewOne()
        }else if preName != ""{
            
            updateOldClient(clientName: preName, clientSex: preSex, clientBuildDate: preBuildDate, clientYear: preYear)
         
        }
        rightButton3.isEnabled = true

        performSegue(withIdentifier: "goCreatEvent", sender: nil)

    }
   
    func store() {
        
        print("index = \(index)")
        
        let appDel = UIApplication.shared.delegate as? AppDelegate
        
        rightButton3.isEnabled = true
        
        
        //確認是否有重複
        //當複合鍵沒有被修改過
        var checkwhetherduplicate : Bool = false
        do{
            guard let context2 =  appDel?.persistentContainer.viewContext else{ return }
            let result2 = try context2.fetch(OrangeClient.fetchRequest())
            for item in result2{
                let aClient = item as? OrangeClient
                
                if aClient?.name! == preName && aClient?.sex == preSex && aClient?.buildDate! == preBuildDate && aClient?.year == preYear{
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
            let result2 = try context2.fetch(OrangeClient.fetchRequest())
            for item in result2{
                let aClient = item as? OrangeClient
                
                //若是文字框與資料庫值一樣且不與傳入值一樣的話代表重複
                if (aClient?.name! == txt_name.text! && aClient?.sex == sex && aClient?.buildDate! == txt_buildDate.text! && aClient?.year == TheBirth) && (txt_name.text! != preName || sex != preSex || txt_buildDate.text! != preBuildDate || TheBirth != preYear){
                    checkwhetherduplicate_MODIFY = true
                   
                    break
                    
                }else{
                    
                
                    
                    checkwhetherduplicate_MODIFY = false
                    
                }
            }
        }catch let error as NSError{    print(error)    }

        
        
        if txt_name.text != "" {
            //其複合鍵不與資料庫相同才能建立
            //點新增頁面進來的，沒有傳直，index == 10000
            if index >= 1000 && checkwhetherduplicate_MODIFY == false {
                buildUpNewOne()
                SaveSuccessAlert()
            }else if index < 1000 && checkwhetherduplicate == true{
                if checkwhetherduplicate_MODIFY == false{
                
                    updateOldClient(clientName: preName, clientSex: preSex, clientBuildDate: preBuildDate, clientYear: preYear)
                    SaveSuccessAlert()
                }
            }
            if checkwhetherduplicate_MODIFY == true{
                SaveFailedAlert()
            }
        
        }else{
            let alert = UIAlertController(title: "錯誤", message: "姓名還沒填喔！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) {
                (action:UIAlertAction) in
                //self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            present(alert , animated: true,completion:  nil)
        
        
        }
    
        
    }
    
 
        func note() {
          performSegue(withIdentifier: "showNoteOrangeClient", sender: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    let rightButton = UIButton(type: .system)
    let rightButton2 = UIButton(type: .system)
    let rightButton3 = UIButton(type: .system)
    private func setupNavigationBarItems(){
        
        self.title = "增援客戶資料"
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
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        txt_buildDate.isEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(OCVC.dismissKeyboard))
       
        view.addGestureRecognizer(tap)
        rightButton3.isEnabled = true
        print("index = \(index)")
        if index < 1000{
            preName = passName
            preSex = passSex
            preBuildDate = passBuildDate
            print("preName = \(preName), preSex = \(preSex), prebuild = \(preBuildDate) preyear = \(preYear)")
        }else{
            rightButton3.isEnabled = false
        }
        
        
        if preName == ""{
            print("oh no prename=empaty")
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy年MM月dd日"
            
            txt_buildDate.text = formatter.string(from: date)  //自動建立當天日期
        } else if preName != ""{
            print("prename == \(preName)")
            viewLoadOldClient(preName: preName, preSex: preSex, preBuildUp: preBuildDate)
        }
        
        
    }
    

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNoteOrangeClient"{
            let vc = (segue.destination as! UINavigationController).topViewController as? CustomerNoteViewController
            vc?.preName = txt_name.text!
            vc?.prePhoneNumber = first_phoneNumber.text!
            vc?.preBuildDate = txt_buildDate.text!
        }
        
        if segue.identifier == "godate2"{
            let vc = segue.destination
            
            //調整pop出來視窗的大小
            vc.preferredContentSize = CGSize(width: 250, height: 200)
            let v = segue.destination as! birth2ViewController
            v.delegate = self
            let controller = vc.popoverPresentationController
            if controller != nil{
                controller?.delegate = self
            }
        }
        if segue.identifier == "gochild2"{
            let vc = segue.destination
            
            //調整pop出來視窗的大小
            vc.preferredContentSize = CGSize(width: 250, height: 200)
            let v = segue.destination as! children2ViewController
            v.delegate = self
            let controller = vc.popoverPresentationController
            if controller != nil{
                controller?.delegate = self
            }
        }
        
        if segue.identifier == "gomarry2"{
            let vc = segue.destination
            
            //調整pop出來視窗的大小
            vc.preferredContentSize = CGSize(width: 250, height: 200)
            let v = segue.destination as! marry2ViewController
            v.delegate = self
            let controller = vc.popoverPresentationController
            if controller != nil{
                controller?.delegate = self
            }
        }
        if segue.identifier == "goCreatEvent" {
            print("hello")
            let controller = (segue.destination as! UINavigationController).topViewController  as! clientSeperate
            controller.prepreName = preName
            controller.preName = txt_name.text!
            controller.prebuildDate = txt_buildDate.text!
            if first_year.text != ""{
                controller.preYear = TheBirth
            }
            else{
                controller.preYear = TheBirth
            }
            controller.prePhone = first_phoneNumber.text!
            controller.clientClass = clientClass
            controller.strForClientSP = "增員"
        }
    }
    
}

extension OCVC{
    func buildUpNewOne(){
        let appDel = UIApplication.shared.delegate as? AppDelegate
        var checkwhetherduplicate: Bool = false
        do{
            guard let context2 = appDel?.persistentContainer.viewContext else{ return }
            let result2 = try context2.fetch(OrangeClient.fetchRequest())
            for item in result2{
                let newClient = item as? OrangeClient
                
                if (newClient?.name!)! == txt_name.text! && (newClient?.sex)! == sex && (newClient?.buildDate!)! == txt_buildDate.text && (newClient?.year!)! == TheBirth {
                    checkwhetherduplicate = true
                }else{
                    checkwhetherduplicate = false
                }
            }
        }catch{}
        
        if txt_name.text == "" {
            let alert = UIAlertController(title: "錯誤", message: "姓名還沒填喔！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) {
                (action:UIAlertAction) in
             //   self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            present(alert , animated: true,completion:  nil)
            
        }else if txt_name.text != "" && checkwhetherduplicate == false {
            
            guard let context = appDel?.persistentContainer.viewContext else{ return }
            let newClient = OrangeClient(context : context)
            //basic
            newClient.buildDate = txt_buildDate.text
            newClient.name = txt_name.text
            
            newClient.reason2 = reason
            
            newClient.sex = sex
            //first
            newClient.phoneNumber = first_phoneNumber.text
            newClient.education = first_education.text
            newClient.year = first_year.text
            newClient.children = first_children.text
            newClient.married = first_married.text
            newClient.seniority = first_seniority.text
            newClient.work = first_work.text
            newClient.mateWork = first_mateWork.text
            newClient.salary = first_salary.text
            newClient.traffic = first_traffic.text
            newClient.live = first_live.text
            newClient.basic_other = first_others.text
            //sec
            newClient.sec_personalityTraits_D = perD
            newClient.sec_personalityTraits_I = perI
            newClient.sec_personalityTraits_S = perS
            newClient.sec_personalityTraits_C = perC
            newClient.sec_personalityTraits_haveTarget = perTarget
            newClient.sec_personalityTraits_nowUnstable = perNow
            newClient.sec_personalityTraits_makeMoney = perMakeMoney
            newClient.sec_personalityTraits_likeFreedomLife = perLikeFreedom
            newClient.sec_personalityTraits_wantBeLeader = perWantBeLeader
            newClient.sec_personalityTraits_others = sec_others.text
            //third
            newClient.third_lifeProblem_home = third_home.text
            newClient.third_lifeProblem_work = third_work.text
            newClient.third_lifeProblem_others = third_others.text
            //fourth
            newClient.fourth_fivePointDemand_resonablePay = fourthReasonablePay
            newClient.fourth_fivePointDemand_chancePromotion = fourthChancePromotion
            newClient.fourth_fivePointDemand_growUp = fourthGrowUp
            newClient.fourth_fovePointDemand_worthOnWork = fourthWorkWorth
            newClient.fourth_fivePointDeamnd_prospect = fourthProspect
            newClient.fourht_fivePointDemand_others = fourth_others.text
            //fifth
            newClient.fifth_careerConcept_ESBI = fifthESBI
            newClient.fifth_careerConcept_duelCareer = fifthDuelCareer
            newClient.fifth_careerConcept_threeLineInLife = fifthLifeThreeLine
            newClient.fifth_careerConcept_introduceTeam = fifthTeamIntroduce
            newClient.fifth_careerConcept_others = fifth_others.text
            //sixth
            newClient.sixth_stragegy_eventWork = sixth_eventCompany.text
            newClient.sixth_stragegy_eventDepartment = sixth_eventDepartment.text
            newClient.sixth_stragegy_eventPersonal = sixth_eventPersonal.text
            newClient.sixth_stragegy_professionBasic = sixth_professionBasic.text
            newClient.sixth_stragegy_prefessionTrain = sixth_professionTrain.text
            newClient.sixth_stragegy_professionLicenses = sixth_professionLicense.text
            newClient.sixth_stragegy_others = sixth_others.text
            //seventh
            newClient.seventh_mainProduct_lifeGuarantee = seventh_lifeGuarantee.text
            newClient.seventh_mainProduct_medicalCare = seventh_medicalCare.text
            newClient.seventh_mainProduct_moneySaving = seventh_savingMoney.text
            newClient.seventh_mainProduct_others = seventh_others.text
            //eighth
            newClient.eighth_objectionProblem_incomeUnstable = eighthIncomeUnstable
            newClient.eighth_objectionProblem_marketSaturation = eighthMarketSaturation
            newClient.eighth_objectionProblem_noBusiness = eighthNoBusiness
            newClient.eighth_objectionProblem_noClient = eighthNoClient
            newClient.eighth_objectionProblem_familyOpposite = eighthFamilyOpposite
            newClient.eighth_objectionProblem_others = eighth_others.text
            //ninth
            newClient.ninth_salePlan = ninth_salePlan.text
            
            newClient.updateStatus = 0
            appDel?.saveContext()
            
        }
       
    }
    
    
   
    func updateOldClient(clientName : String , clientSex : String , clientBuildDate : String , clientYear : String){
        let appDel = UIApplication.shared.delegate as? AppDelegate
        let eventStore = EKEventStore()
        
        do{
            guard let context = appDel?.persistentContainer.viewContext else{ return }
            let result = try context.fetch(OrangeClient.fetchRequest())
            for item in result{
                let newClient = item as? OrangeClient
               
                if newClient?.name! == clientName && newClient?.sex == clientSex && newClient?.buildDate! == clientBuildDate && newClient?.year! == clientYear{
                    //basic
                    newClient?.name = txt_name.text
                    newClient?.buildDate = txt_buildDate.text
                    newClient?.name = txt_name.text
                    
                    print("look here reason = \(reason)")
                    
                    newClient?.reason2 = reason
                    newClient?.sex = sex
                    //first
                    newClient?.phoneNumber = first_phoneNumber.text
                    newClient?.education = first_education.text
                    newClient?.year = TheBirth
                    newClient?.children = first_children.text
                    newClient?.married = first_married.text
                    newClient?.seniority = first_seniority.text
                    newClient?.work = first_work.text
                    newClient?.mateWork = first_mateWork.text
                    newClient?.salary = first_salary.text
                    newClient?.traffic = first_traffic.text
                    newClient?.live = first_live.text
                    newClient?.basic_other = first_others.text
                    //sec
                    newClient?.sec_personalityTraits_D = perD
                    newClient?.sec_personalityTraits_I = perI
                    newClient?.sec_personalityTraits_S = perS
                    newClient?.sec_personalityTraits_C = perC
                    newClient?.sec_personalityTraits_haveTarget = perTarget
                    newClient?.sec_personalityTraits_nowUnstable = perNow
                    newClient?.sec_personalityTraits_makeMoney = perMakeMoney
                    newClient?.sec_personalityTraits_likeFreedomLife = perLikeFreedom
                    newClient?.sec_personalityTraits_wantBeLeader = perWantBeLeader
                    newClient?.sec_personalityTraits_others = sec_others.text
                    //third
                    newClient?.third_lifeProblem_home = third_home.text
                    newClient?.third_lifeProblem_work = third_work.text
                    newClient?.third_lifeProblem_others = third_others.text
                    //fourth
                    newClient?.fourth_fivePointDemand_resonablePay = fourthReasonablePay
                    newClient?.fourth_fivePointDemand_chancePromotion = fourthChancePromotion
                    newClient?.fourth_fivePointDemand_growUp = fourthGrowUp
                    newClient?.fourth_fovePointDemand_worthOnWork = fourthWorkWorth
                    newClient?.fourth_fivePointDeamnd_prospect = fourthProspect
                    newClient?.fourht_fivePointDemand_others = fourth_others.text
                    //fifth
                    newClient?.fifth_careerConcept_ESBI = fifthESBI
                    newClient?.fifth_careerConcept_duelCareer = fifthDuelCareer
                    newClient?.fifth_careerConcept_threeLineInLife = fifthLifeThreeLine
                    newClient?.fifth_careerConcept_introduceTeam = fifthTeamIntroduce
                    newClient?.fifth_careerConcept_others = fifth_others.text
                    //sixth
                    newClient?.sixth_stragegy_eventWork = sixth_eventCompany.text
                    newClient?.sixth_stragegy_eventDepartment = sixth_eventDepartment.text
                    newClient?.sixth_stragegy_eventPersonal = sixth_eventPersonal.text
                    newClient?.sixth_stragegy_professionBasic = sixth_professionBasic.text
                    newClient?.sixth_stragegy_prefessionTrain = sixth_professionTrain.text
                    newClient?.sixth_stragegy_professionLicenses = sixth_professionLicense.text
                    newClient?.sixth_stragegy_others = sixth_others.text
                    //seventh
                    newClient?.seventh_mainProduct_lifeGuarantee = seventh_lifeGuarantee.text
                    newClient?.seventh_mainProduct_medicalCare = seventh_medicalCare.text
                    newClient?.seventh_mainProduct_moneySaving = seventh_savingMoney.text
                    newClient?.seventh_mainProduct_others = seventh_others.text
                    //eighth
                    newClient?.eighth_objectionProblem_incomeUnstable = eighthIncomeUnstable
                    newClient?.eighth_objectionProblem_marketSaturation = eighthMarketSaturation
                    newClient?.eighth_objectionProblem_noBusiness = eighthNoBusiness
                    newClient?.eighth_objectionProblem_noClient = eighthNoClient
                    newClient?.eighth_objectionProblem_familyOpposite = eighthFamilyOpposite
                    newClient?.eighth_objectionProblem_others = eighth_others.text
                    //ninth
                    newClient?.ninth_salePlan = ninth_salePlan.text
                    if self.update != 0{
                        newClient?.updateStatus = 1
                    }
                    
                    if preName != txt_name.text {
                        
                        newClient?.updateStatus = 0
                        
                    }
                    appDel?.saveContext()
                    //performSegue(withIdentifier: "goCreatEvent", sender: nil)
                }
            }
        }catch{}
        
        
       
        
        do{
            guard let context = appDel?.persistentContainer.viewContext else{ return }
            let result = try context.fetch(Note.fetchRequest())
            for item in result{
                let newClient = item as? Note
                if newClient?.clientName == clientName && newClient?.clientPhoneNumber == prephone && newClient?.clientPhoneNumber != first_phoneNumber.text {
                    
                    newClient?.clientPhoneNumber = first_phoneNumber.text

                }else if newClient?.clientPhoneNumber == prephone && newClient?.clientPhoneNumber == first_phoneNumber.text && newClient?.clientName != clientName{
                
                    newClient?.clientName = clientName

            }

                
            }
            appDel?.saveContext()  //資料庫儲存
            prephone = first_phoneNumber.text!

        }catch{}
        
        
        
        
        
        if preName != txt_name.text {
            do{
                print("改的條件成立囉")
                guard let context = appDel?.persistentContainer.viewContext else{ return }
                let result = try context.fetch(Event.fetchRequest())
                for item in result{
                    let oldEvent = item as? Event
                    
                    if oldEvent?.eventClientName == preName && oldEvent?.clientYear == preYear {
                        print("FFF")
                        if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized) {
                            eventStore.requestAccess(to: .event, completion: { (granted, error) -> Void in
                                self.UpdateEvent(eventStore, eventIdentifier: (oldEvent?.identifier)!, title: "增員 " + self.txt_name.text!)
                            })
                        } else {
                            UpdateEvent(eventStore, eventIdentifier: (oldEvent?.identifier)!, title: "增員 " + txt_name.text!)
                        }

                        
                    }
                }
            }catch let error as NSError{
                print(error)
            }
                changeEventData()
        }
    }
    
    
    func viewLoadOldClient(preName : String , preSex : String , preBuildUp : String){
       
        do{
            let appDel = UIApplication.shared.delegate as? AppDelegate
            guard let context = appDel?.persistentContainer.viewContext else { return }
            let result = try context.fetch(OrangeClient.fetchRequest())
            for item in result{
                let oldClient = item as? OrangeClient
                if oldClient?.name! == preName && oldClient?.sex! == preSex && oldClient?.buildDate! == preBuildUp{
                    
                    reason = (oldClient?.reason2)!
                    sex = (oldClient?.sex)!
                   
                    perD = (oldClient?.sec_personalityTraits_D)!
                    perI = (oldClient?.sec_personalityTraits_I)!
                    perS = (oldClient?.sec_personalityTraits_S)!
                    perC = (oldClient?.sec_personalityTraits_C)!
                    perTarget = (oldClient?.sec_personalityTraits_haveTarget)!
                    perNow = (oldClient?.sec_personalityTraits_nowUnstable)!
                    perMakeMoney = (oldClient?.sec_personalityTraits_makeMoney)!
                    perLikeFreedom = (oldClient?.sec_personalityTraits_likeFreedomLife)!
                    perWantBeLeader = (oldClient?.sec_personalityTraits_wantBeLeader)!
                    
                    fourthReasonablePay = (oldClient?.fourth_fivePointDemand_resonablePay)!
                    fourthChancePromotion = (oldClient?.fourth_fivePointDemand_chancePromotion)!
                    fourthGrowUp = (oldClient?.fourth_fivePointDemand_growUp)!
                    fourthWorkWorth = (oldClient?.fourth_fovePointDemand_worthOnWork)!
                    fourthProspect = (oldClient?.fourth_fivePointDeamnd_prospect)!
                    
                    fifthESBI = (oldClient?.fifth_careerConcept_ESBI)!
                    fifthDuelCareer = (oldClient?.fifth_careerConcept_duelCareer)!
                    fifthLifeThreeLine = (oldClient?.fifth_careerConcept_threeLineInLife)!
                    fifthTeamIntroduce = (oldClient?.fifth_careerConcept_introduceTeam)!
                    
                    eighthIncomeUnstable = (oldClient?.eighth_objectionProblem_incomeUnstable)!
                    eighthMarketSaturation = (oldClient?.eighth_objectionProblem_marketSaturation)!
                    eighthNoBusiness = (oldClient?.eighth_objectionProblem_noBusiness)!
                    eighthNoClient = (oldClient?.eighth_objectionProblem_noClient)!
                    eighthFamilyOpposite = (oldClient?.eighth_objectionProblem_familyOpposite)!
                    
                    
                    //basic
                    txt_buildDate.text = oldClient?.buildDate
                    txt_name.text = oldClient?.name
                    
                        print("oldclient.reason == nil")
                       
                        if oldClient?.reason2 == "緣故"{
                            btn_reasonA.setImage(UIImage(named : "check"), for: .normal)
                             btn_reasonB.setImage(UIImage(named : "checkbox"), for: .normal)
                             btn_reasonC.setImage(UIImage(named : "checkbox"), for: .normal)
                        }else if oldClient?.reason2 == "陌生"{
                            btn_reasonB.setImage(UIImage(named : "check"), for: .normal)
                            btn_reasonA.setImage(UIImage(named : "checkbox"), for: .normal)
                            btn_reasonC.setImage(UIImage(named : "checkbox"), for: .normal)
                        }else if oldClient?.reason2 == "轉介紹"{
                            btn_reasonC.setImage(UIImage(named : "check"), for: .normal)
                            btn_reasonB.setImage(UIImage(named : "checkbox"), for: .normal)
                            btn_reasonA.setImage(UIImage(named : "checkbox"), for: .normal)}
                    
                    sex = (oldClient?.sex)!
                    if oldClient?.sex == "男"{
                        sex_boy.setImage(UIImage(named : "check"), for: .normal)
                    }else if oldClient?.sex == "女" {
                        sex_girl.setImage(UIImage(named : "check"), for: .normal)
                    }
                    //first
                    first_phoneNumber.text = oldClient?.phoneNumber
                    prephone = (oldClient?.phoneNumber)!
                    first_education.text = oldClient?.education
                    first_year.text = oldClient?.year
                    first_children.text = oldClient?.children
                    first_married.text = oldClient?.married
                    first_seniority.text = oldClient?.seniority
                    first_salary.text = oldClient?.salary
                    first_work.text = oldClient?.work
                    first_mateWork.text = oldClient?.mateWork
                    first_traffic.text = oldClient?.traffic
                    first_live.text = oldClient?.live
                    fifth_others.text = oldClient?.basic_other
                   
                    //sec
                    perD = (oldClient?.sec_personalityTraits_D)!
                    perI = (oldClient?.sec_personalityTraits_I)!
                    perS = (oldClient?.sec_personalityTraits_S)!
                    perC = (oldClient?.sec_personalityTraits_C)!
                    perTarget = (oldClient?.sec_personalityTraits_haveTarget)!
                    perNow = (oldClient?.sec_personalityTraits_nowUnstable)!
                    perMakeMoney = (oldClient?.sec_personalityTraits_makeMoney)!
                    perLikeFreedom = (oldClient?.sec_personalityTraits_likeFreedomLife)!
                    perWantBeLeader = (oldClient?.sec_personalityTraits_wantBeLeader)!
                    sec_D.setImage(UIImage(named : (perD ? "check" : "checkbox")), for: .normal)
                    sec_I.setImage(UIImage(named : (perI ? "check" : "checkbox")), for: .normal)
                    sec_S.setImage(UIImage(named : (perS ? "check" : "checkbox")), for: .normal)
                    sec_C.setImage(UIImage(named : (perC ? "check" : "checkbox")), for: .normal)
                    sec_haveTarget.setImage(UIImage(named : (perTarget ? "check" : "checkbox")), for: .normal)
                    sec_niwUnstable.setImage(UIImage(named : (perNow ? "check" : "checkbox")), for: .normal)
                    sec_likeMoney.setImage(UIImage(named : (perMakeMoney ? "check" : "checkbox")), for: .normal)
                    sec_wantBeLeader.setImage(UIImage(named : (perWantBeLeader ? "check" : "checkbox")), for: .normal)
                    
                    
                    
                    sec_others.text = oldClient?.sec_personalityTraits_others
                    //third
                    third_home.text = oldClient?.third_lifeProblem_home
                    third_work.text = oldClient?.third_lifeProblem_work
                    third_others.text = oldClient?.third_lifeProblem_others
                    //fourth
                    fourthReasonablePay = (oldClient?.fourth_fivePointDemand_resonablePay)!
                    fourthChancePromotion = (oldClient?.fourth_fivePointDemand_chancePromotion)!
                    fourthGrowUp = (oldClient?.fourth_fivePointDemand_growUp)!
                    fourthWorkWorth = (oldClient?.fourth_fovePointDemand_worthOnWork)!
                    fourthProspect = (oldClient?.fourth_fivePointDeamnd_prospect)!
                    fourth_others.text = oldClient?.fourht_fivePointDemand_others
                    
                    fourth_reasonablePay.setImage(UIImage(named : fourthReasonablePay ? "check" : "checkbox" ), for: .normal)
                    fourth_chancePromotion.setImage(UIImage(named : fourthChancePromotion ? "check" : "checkbox"), for: .normal)
                    fourth_growUp.setImage(UIImage(named : fourthGrowUp ? "check" : "checkbox"), for: .normal)
                    fourth_workWorth.setImage(UIImage(named : fourthWorkWorth ? "check" : "checkbox"), for: .normal)
                    fourth_prospect.setImage(UIImage(named : fourthProspect ? "check" : "checkbox"), for: .normal)
                    
                    
                    //fifth
                    fifthESBI = (oldClient?.fifth_careerConcept_ESBI)!
                    fifthDuelCareer = (oldClient?.fifth_careerConcept_duelCareer)!
                    fifthLifeThreeLine = (oldClient?.fifth_careerConcept_threeLineInLife)!
                    fifthTeamIntroduce = (oldClient?.fifth_careerConcept_introduceTeam)!
                    fifth_others.text = oldClient?.fifth_careerConcept_others
                    
                    fifth_ESBI.setImage(UIImage(named : (fifthESBI ? "check" : "checkbox")), for: .normal)
                    fifth_duelCareer.setImage(UIImage(named : (fifthDuelCareer ? "check" : "checkbox")), for: .normal)
                    fifth_lifeThreeLine.setImage(UIImage(named : (fifthLifeThreeLine ? "check" : "checkbox")), for: .normal)
                    fifth_teamIntroduce.setImage(UIImage(named : (fifthTeamIntroduce ? "check" : "checkbox")), for: .normal)
                    //sixth
                    sixth_eventCompany.text = oldClient?.sixth_stragegy_eventWork
                    sixth_eventDepartment.text = oldClient?.sixth_stragegy_eventDepartment
                    sixth_eventPersonal.text = oldClient?.sixth_stragegy_eventPersonal
                    sixth_professionBasic.text = oldClient?.sixth_stragegy_professionBasic
                    sixth_professionTrain.text = oldClient?.sixth_stragegy_prefessionTrain
                    sixth_professionLicense.text = oldClient?.sixth_stragegy_professionLicenses
                    sixth_others.text = oldClient?.sixth_stragegy_others
                    //seventh
                    seventh_lifeGuarantee.text = oldClient?.seventh_mainProduct_lifeGuarantee
                    seventh_medicalCare.text = oldClient?.seventh_mainProduct_medicalCare
                    seventh_savingMoney.text = oldClient?.seventh_mainProduct_moneySaving
                    seventh_others.text = oldClient?.seventh_mainProduct_others
                    //eighth
                    eighthIncomeUnstable = (oldClient?.eighth_objectionProblem_incomeUnstable)!
                    eighthMarketSaturation = (oldClient?.eighth_objectionProblem_marketSaturation)!
                    eighthNoBusiness = (oldClient?.eighth_objectionProblem_noBusiness)!
                    eighthNoClient = (oldClient?.eighth_objectionProblem_noClient)!
                    eighthFamilyOpposite = (oldClient?.eighth_objectionProblem_familyOpposite)!
                    
                    eighth_incomeUnstable.setImage(UIImage(named : (eighthIncomeUnstable ? "check" : "checkbox")), for: .normal)
                    eighth_marketSaturation.setImage(UIImage(named : (eighthMarketSaturation ? "check" : "checkbox")), for: .normal)
                    eighth_noBusiness.setImage(UIImage(named : (eighthNoBusiness ? "check" : "checkbox")), for: .normal)
                    eighth_noClient.setImage(UIImage(named : (eighthNoClient ? "check" : "checkbox")), for: .normal)
                    eighth_familyOpposite.setImage(UIImage(named : (eighthFamilyOpposite ? "check" : "checkbox")), for: .normal)
                    eighth_others.text = oldClient?.eighth_objectionProblem_others
                    //ninth
                    ninth_salePlan.text = oldClient?.ninth_salePlan
                    
                    self.update = (oldClient?.updateStatus)!
                }
            }
        }catch{}
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
                    changeEvent?.eventClientPhone = first_phoneNumber.text
                    
                }
                
                appDel2?.saveContext()
            }
        }
        catch let error as NSError {    print(error)    }
    }
    
    // 修改event的function
    func UpdateEvent(_ eventStore: EKEventStore , eventIdentifier: String , title : String) {
        let eventUpDate = eventStore.event(withIdentifier: eventIdentifier)
        
        eventUpDate?.title = title
        
        if (eventUpDate != nil) {
            do {
                try eventStore.save(eventUpDate!, span: .thisEvent)
            } catch {
                print("Bad things happened")
            }
        }
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 && (third_home.isEditing || third_work.isEditing || third_others.isEditing || ninth_salePlan.isEditing || sec_others.isEditing){
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
    
    func getBoolean(input:Bool)->String {
        if input == false {
            return "'0',"
        }else{
            return "'1',"
        }
        return ""
    }
    
    func updateSQLorangeCLient() {
        var updateSQL = "UPDATE `OrangeClient` SET "
                    
        updateSQL += "`name`='\(String(describing: txt_name.text))',"
        updateSQL += "`buildDate`='\(preBuildDate)',"
                    
        updateSQL += "`reason2`='\(reason)',"
        updateSQL += "`sex`='\(sex)',"
        updateSQL += "`phoneNumber`='\(String(describing: first_phoneNumber.text))',"
        updateSQL += "`education`='\(String(describing: first_education.text))',"
        updateSQL += "`year`='\(String(describing: first_year.text))',"
        updateSQL += "`children`='\(String(describing: first_children.text))',"
        updateSQL += "`married`='\(String(describing: first_married.text))',"
        updateSQL += "`seniority`='\(String(describing: first_seniority.text))',"
        updateSQL += "`salary`='\(String(describing: first_salary.text))',"
        updateSQL += "`work`='\(String(describing: first_work.text))',"
        updateSQL += "`mateWork`='\(String(describing: first_mateWork.text))',"
        updateSQL += "`traffic`='\(String(describing: first_traffic.text))',"
        updateSQL += "`live`='\(String(describing: first_live.text))',"
        updateSQL += "`basic_other`='\(String(describing: first_others.text))',"
                    
        updateSQL += "`sec_personalityTraits_D`=\(perD)"
        updateSQL += "`sec_personalityTraits_I`=\(perI)"
        updateSQL += "`sec_personalityTraits_S`=\(perS)"
        updateSQL += "`sec_personalityTraits_C`=\(perC)"
        updateSQL += "`sec_personalityTraits_haveTarget`=\(perTarget)"
        updateSQL += "`sec_personalityTraits_nowUnstable`=\(perNow)"
        updateSQL += "`sec_personalityTraits_makeMoney`=\(perMakeMoney)"
        updateSQL += "`sec_personalityTraits_likeFreedomLife`=\(perLikeFreedom)"
        updateSQL += "`sec_personalityTraits_wantBeLeader`=\(perWantBeLeader)"
        updateSQL += "`sec_personalityTraits_others`='\(String(describing: sec_others.text))',"
                    
        updateSQL += "`third_lifeProblem_home`='\(String(describing: third_home.text))',"
        updateSQL += "`third_lifeProblem_work`='\(String(describing: third_work.text))',"
        updateSQL += "`third_lifeProblem_others`='\(String(describing: third_others.text))',"
                    
        updateSQL += "`fourth_fivePointDemand_resonablePay`=\(fourthReasonablePay)"
        updateSQL += "`fourth_fivePointDemand_chancePromotion`=\(fourthChancePromotion)"
        updateSQL += "`fourth_fivePointDemand_growUp`=\(fourthGrowUp)"
        updateSQL += "`fourth_fovePointDemand_worthOnWork`=\(fourthWorkWorth)"
        updateSQL += "`fourth_fivePointDeamnd_prospect`=\(fourthProspect)"
        updateSQL += "`fourht_fivePointDemand_others`='\(String(describing: fourth_others.text))',"
                    
        updateSQL += "`fifth_careerConcept_ESBI`=\(fifthESBI)"
        updateSQL += "`fifth_careerConcept_duelCareer`=\(fifthDuelCareer)"
        updateSQL += "`fifth_careerConcept_threeLineInLife`=\(fifthLifeThreeLine)"
        updateSQL += "`fifth_careerConcept_introduceTeam`=\(fifthTeamIntroduce)"
        updateSQL += "`fifth_careerConcept_others`='\(String(describing: fifth_others.text))',"
                    
        updateSQL += "`sixth_stragegy_eventWork`='\(String(describing: sixth_eventCompany.text))',"
        updateSQL += "`sixth_stragegy_eventDepartment`='\(String(describing: sixth_eventDepartment.text))',"
        updateSQL += "`sixth_stragegy_eventPersonal`='\(String(describing: sixth_eventPersonal.text))',"
        updateSQL += "`sixth_stragegy_professionBasic`='\(String(describing: sixth_professionBasic.text))',"
        updateSQL += "`sixth_stragegy_prefessionTrain`='\(String(describing: sixth_professionTrain.text))',"
        updateSQL += "`sixth_stragegy_professionLicenses`='\(String(describing: sixth_professionLicense.text))',"
        updateSQL += "`sixth_stragegy_others`='\(String(describing: sixth_others.text))',"
                    
        updateSQL += "`seventh_mainProduct_lifeGuarantee`='\(String(describing: seventh_lifeGuarantee.text))',"
        updateSQL += "`seventh_mainProduct_medicalCare`='\(String(describing: seventh_medicalCare.text))',"
        updateSQL += "`seventh_mainProduct_moneySaving`='\(String(describing: seventh_savingMoney.text))',"
        updateSQL += "`seventh_mainProduct_others`='\(String(describing: seventh_others.text))',"
                    
        updateSQL += "`eighth_objectionProblem_incomeUnstable`=\(eighthIncomeUnstable)"
        updateSQL += "`eighth_objectionProblem_marketSaturation`=\(eighthMarketSaturation)"
        updateSQL += "`eighth_objectionProblem_noBusiness`=\(eighthNoBusiness)"
        updateSQL += "`eighth_objectionProblem_noClient`=\(eighthNoClient)"
        updateSQL += "`eighth_objectionProblem_familyOpposite`=\(eighthFamilyOpposite)"
        updateSQL += "`eighth_objectionProblem_others`='\(String(describing: eighth_others.text))',"
                    
        updateSQL += "`ninth_salePlan`='\(String(describing: ninth_salePlan.text))' "
                    
        updateSQL += " WHERE `data_sn`='\(data_sn)' AND `name`='\(preName)' AND `sex`='\(preSex)' AND `buildDate`='\(preBuildDate)'"
        
        print(updateSQL)
                    
        DBconnect.executeQuery(query_string: updateSQL)
        
    }
    
}
