//
//  LoginViewController.swift
//  HelloCoreData
//
//  Created by user on 2017/8/12.
//  Copyright © 2017年 楊昇融. All rights reserved.
//

import UIKit
import Foundation


public class peformSQL{
    
    public static func checkSqlIsNull(SQL: String) -> Bool{
        
        
        var JsonArray: NSArray = []
        var JsonARR : NSArray = []
        let sql = SQL
        let result = DBconnect.executeQuery(query_string: sql)
        //宣告newData將result型態從String轉為data
        let newData = result.data(using: String.Encoding.utf8)
        do{
            //將newData轉成NSArray型態，並且宣告JsonArray去接它
            JsonARR = try JSONSerialization.jsonObject(with: newData!, options: []) as! NSArray
            
        } catch let error as NSError {
            
            print(error)
            
            
        }
        return result == "null" ? true : false
        
    }
    
    
    
    public static func performeSql(SQL: String) -> NSArray{
        
        var JsonARR : NSArray = []
        let sql = SQL
        let result = DBconnect.executeQuery(query_string: sql)
        //宣告newData將result型態從String轉為data
        let newData = result.data(using: String.Encoding.utf8)
        do{
            //將newData轉成NSArray型態，並且宣告JsonArray去接它
            JsonARR = try JSONSerialization.jsonObject(with: newData!, options: []) as! NSArray
            
        } catch let error as NSError {
            
            print(error)
            
            
        }
        
        return JsonARR
        
    }
    
    
    
}



class LoginViewController: UIViewController {

    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet weak var newUserName: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    var passkey:String = "123"
    var presentWindow : UIWindow?
    var data_sn : String = ""
    
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
    
    @IBAction func newAccount(_ sender: UIButton) {
        if (newUserName.text == "") {
            
            let alertController = UIAlertController(
                title: "提示",
                message: "請輸入帳號",
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
            
        } else if (newPassword.text == "") {
            
            let alertController = UIAlertController(
                title: "提示",
                message: "請輸入密碼",
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
            
        } else if (newUserName.text != "" && newPassword.text != "") {
            if checkInternetFunction() == true {
            
                //first 確認是否有相同的帳號
                //terry新加入的 2018.1.12 13:07
                var jsonarray: NSArray = []
                let sql = "SELECT `data_sn` FROM `member_data` WHERE `account`='\(newUserName.text!)' AND `password`='\(newPassword.text!)'"
                print ("\(sql)")
                var get_acc = ""
                

                //terry新加入的 2018.1.12 13:07
            
                if !peformSQL.checkSqlIsNull(SQL: sql) {
                    
                    jsonarray = peformSQL.performeSql(SQL: sql)
                    if jsonarray.count > 0{
                    
                        if let datasn = (jsonarray[0] as! NSDictionary)["data_sn"] as? String{
                            
                            get_acc = datasn
                        }else{
                        
                        get_acc = ""
                    
                        }
                    }else{
                        
                        get_acc = ""
                    }
                }
                

                if (get_acc != "") {
                    
                    let alertController = UIAlertController(
                        title: "提示",
                        message: "此帳號已存在，請換一個",
                        preferredStyle: .alert)
                    
                    // 建立[確認]按鈕
                    
                    let okAction = UIAlertAction(
                        title: "確認",
                        style: .default,
                        handler: {
                            (action: UIAlertAction!) -> Void in
                            print("按下確認後，閉包裡的動作000")
                    })
                    alertController.addAction(okAction)
                    
                    // 顯示提示框
                    self.present(
                        alertController,
                        animated: true,
                        completion: nil)
                    
                } else {
                    //second 若無相同帳號則新增
                    //先取得序號後下sql
                    let userNumber = get_data_sn()
                    
                    DBconnect.executeQuery(query_string: "INSERT INTO `member_data`(`data_sn`, `account`, `password`) VALUES ('\(userNumber)','\(String(describing: newUserName.text!))','\(String(describing: newPassword.text!))')")
                    
                    
                    let appDel = UIApplication.shared.delegate as? AppDelegate
                    guard let context = appDel?.persistentContainer.viewContext else{ return }
                    let newAcc = AccData(context : context)
                    
                    newAcc.userAccount  = newUserName.text
                    newAcc.userPassword = newPassword.text
                    newAcc.userNumber   = userNumber
                    
                    appDel?.saveContext()
                    
                    performSegue(withIdentifier: "entry", sender: self)
                }
            } else {
                let alertController = UIAlertController(
                    title: "提示",
                    message: "目前沒有網路，請先連上網路再試",
                    preferredStyle: .alert)
                
                // 建立[確認]按鈕
                
                let okAction = UIAlertAction(
                    title: "確認",
                    style: .default,
                    handler: {
                        (action: UIAlertAction!) -> Void in
                        print("按下確認後，閉包裡的動作000")
                })
                alertController.addAction(okAction)
                
                // 顯示提示框
                self.present(
                    alertController,
                    animated: true,
                    completion: nil)
            
            }
        }
        
        
        
        
    }
    
    @IBAction func login(_ sender: Any) {
        let sql_checkUser = DBconnect.executeQuery(query_string: "SELECT `data_sn` FROM `member_data` WHERE `account`='\(String(describing: username.text!))' AND `password`='\(String(describing: password.text!))'")
        let data = sql_checkUser.data(using: .utf8)!
        var get_accNumber = ""
        
        do {
            if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSArray {
                // Get data_sn 欄位 的第0筆資料
                let last_data_sn = (convertedJsonIntoDict[0] as! NSDictionary)["data_sn"] as? String
                
                
                var last_data_sn_var:Int=Int(last_data_sn!)!
                
                get_accNumber=String(last_data_sn_var)
            }
            else{ }
        } catch let error as NSError {
            print(error)
        }
        
        
        if (get_accNumber != "") {
            //data_sn取自這邊
            self.data_sn = get_accNumber
            let appDel = UIApplication.shared.delegate as? AppDelegate
            guard let context = appDel?.persistentContainer.viewContext else{ return }
            let newAcc = AccData(context : context)
            
            newAcc.userAccount  = username.text
            newAcc.userPassword = password.text
            newAcc.userNumber   = get_accNumber
            
            appDel?.saveContext()
            
            getBackData_note()
            getBackData_client()
            getBackData_orangeClient()
            
            performSegue(withIdentifier: "entry", sender: self)
        } else if (get_accNumber == "") {
            let alertController = UIAlertController(
                title: "提示",
                message: "帳號或密碼錯誤，請重試一次 ",
                preferredStyle: .alert)
            
            // 建立[取消]按鈕
            let cancelAction = UIAlertAction(
                title: "確定",
                style: .cancel,
                handler: {
                    (action: UIAlertAction!) -> Void in
            
                    self.dismiss(animated: true, completion: nil)
            
            })
            alertController.addAction(cancelAction)
            
            // 顯示提示框
            self.present(
                alertController,
                animated: true,
                completion: nil)
            
            get_accNumber = ""
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        do{
            let appDel = UIApplication.shared.delegate as? AppDelegate
            guard let context = appDel?.persistentContainer.viewContext else {  return  }
            let result = try context.fetch(AccData.fetchRequest())
            print(result.count)
            
            if (result.count>=1) {
                performSegue(withIdentifier: "entry", sender: self)
            }
        } catch {
            
        }
    }
    
    
    func get_data_sn()->String{
        var data_sn:String!
        
        let get_data_sn_result = DBconnect.executeQuery(query_string: "SELECT `data_sn` FROM `member_data` ORDER BY `member_data`.`data_sn` DESC")
        let data = get_data_sn_result.data(using: .utf8)!
        
        do {
            if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSArray {
                // Get data_sn 欄位 的第0筆資料
                let last_data_sn = (convertedJsonIntoDict[0] as! NSDictionary)["data_sn"] as? String
                
                
                var last_data_sn_var:Int=Int(last_data_sn!)!
                last_data_sn_var=last_data_sn_var+1
                data_sn=String(last_data_sn_var)
            }
            else{ }
        } catch let error as NSError {
            print(error)
        }
        if data_sn == "" || data_sn == nil{
            data_sn = "0"
        }
        
        return data_sn
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 && (newPassword.isEditing || newUserName.isEditing){
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
         presentWindow = UIApplication.shared.keyWindow
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension LoginViewController {
    func getBackData_note() {
        let appDel = UIApplication.shared.delegate as? AppDelegate
        //data_sn在login那邊有取
        let SQL : String = "SELECT * FROM `note` WHERE data_sn = \(data_sn)"
        print("hello note")
        if !peformSQL.checkSqlIsNull(SQL: SQL) {
            print("hello note2")

            let JsonArray = peformSQL.performeSql(SQL: SQL)
            print("hello note3")

            if JsonArray.count > 0 {
                print("hello note")

            for i in 0...JsonArray.count-1 {
                guard let context = appDel?.persistentContainer.viewContext else {  return  }
                let newNote = Note(context : context)
                if let tmpStr = (JsonArray[i] as! NSDictionary)["clientName"] as? String{
                    
                    newNote.clientName = tmpStr
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["clientPhoneNumber"] as? String{
                    
                    newNote.clientPhoneNumber = tmpStr
                }
                 if let tmpStr = (JsonArray[i] as! NSDictionary)["clientBuildDate"] as? String{
                    
                    newNote.clientBuildDate = tmpStr
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["content"] as? String{
                    
                    newNote.content = tmpStr
                }
                 if let tmpStr = (JsonArray[i] as! NSDictionary)["creatDate"] as? String{
                    
                    newNote.creatDate = tmpStr
                }
                
                newNote.updateStatus = 3
                
                appDel?.saveContext()  //資料庫儲存
                
            }
            
            }
        }
    }
    
    func getBackData_orangeClient() {
        
        let appDel = UIApplication.shared.delegate as? AppDelegate
        //data_sn在login那邊有取
        let SQL : String = "SELECT * FROM `OrangeClient` WHERE data_sn = \(data_sn)"
        
        print ("ggg \(SQL)")
        if !peformSQL.checkSqlIsNull(SQL: SQL) {
            let JsonArray = peformSQL.performeSql(SQL: SQL)
            if JsonArray.count > 0 {

            for i in 0...JsonArray.count-1{

                guard let context = appDel?.persistentContainer.viewContext else{ return }
                let newClient = OrangeClient(context : context)
//                //basic
                if let tmpStr = (JsonArray[i] as! NSDictionary)["buildDate"] as? String{
                    newClient.buildDate = tmpStr
                    print("look\(newClient.buildDate)")
                }else{
                    
                    newClient.buildDate = ""
                    
                }
        
                
                
                
                
                
                
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["name"] as? String{newClient.name = tmpStr}else{
                    
                   newClient.name = ""
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["reason2"] as? String{newClient.reason2 = tmpStr}else{
                    
                   newClient.reason2 = ""
                    
                }

                if let tmpStr = (JsonArray[i] as! NSDictionary)["sex"] as? String{newClient.sex = tmpStr}else{
                    
                   newClient.sex = ""
                    
                }
                //first
                if let tmpStr = (JsonArray[i] as! NSDictionary)["phoneNumber"] as? String{newClient.phoneNumber = tmpStr
                    print("\(tmpStr)")
                }else{
                    
                   newClient.phoneNumber = ""
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["education"] as? String{newClient.education = tmpStr}else{
                    
                   newClient.education = ""
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["year"] as? String{newClient.year = tmpStr}else{
                    
                   newClient.year = ""
                    
                }
                 if let tmpStr = (JsonArray[i] as! NSDictionary)["children"] as? String{newClient.children = tmpStr}else{
                    
                   newClient.children = ""
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["married"] as? String{newClient.married = tmpStr}else{
                    
                   newClient.married = ""
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["seniority"] as? String{newClient.seniority = tmpStr}else{
                    
                   newClient.seniority = ""
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["work"] as? String{newClient.work = tmpStr}else{
                    
                   newClient.work = ""
                    
                }
                
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["mateWork"] as? String{newClient.mateWork = tmpStr}else{
                    
                   newClient.mateWork = ""
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["salary"] as? String{newClient.salary = tmpStr}else{
                    
                   newClient.salary = ""
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["traffic"] as? String{newClient.traffic = tmpStr}else{
                    
                   newClient.traffic = ""
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["live"] as? String{newClient.live = tmpStr}else{
                    
                   newClient.live = ""
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["basic_other"] as? String{newClient.basic_other = tmpStr}else{
                    
                   newClient.basic_other = ""
                    
                }
                //sec
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sec_personalityTraits_D"] as? String{
                    
                    newClient.sec_personalityTraits_D = returnBool(SQLint:tmpStr)
                    
                }else{
                    
                   newClient.sec_personalityTraits_D = false
                    
                }
                
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sec_personalityTraits_I"] as? String {newClient.sec_personalityTraits_I = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.sec_personalityTraits_I = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sec_personalityTraits_S"] as? String {newClient.sec_personalityTraits_S  = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.sec_personalityTraits_S = false
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sec_personalityTraits_C"] as? String {newClient.sec_personalityTraits_C  = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.sec_personalityTraits_C = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sec_personalityTraits_haveTarget"] as? String { newClient.sec_personalityTraits_haveTarget  = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.sec_personalityTraits_haveTarget = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sec_personalityTraits_nowUnstable"] as? String { newClient.sec_personalityTraits_nowUnstable  = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.sec_personalityTraits_nowUnstable = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sec_personalityTraits_makeMoney"] as? String {  newClient.sec_personalityTraits_makeMoney = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.sec_personalityTraits_makeMoney = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sec_personalityTraits_likeFreedomLife"] as? String { newClient.sec_personalityTraits_likeFreedomLife  = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.sec_personalityTraits_likeFreedomLife = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sec_personalityTraits_wantBeLeader"] as? String { newClient.sec_personalityTraits_wantBeLeader  = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.sec_personalityTraits_wantBeLeader = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sec_personalityTraits_others"] as? String{newClient.sec_personalityTraits_others = tmpStr}else{
                    
                   newClient.sec_personalityTraits_others = ""
                    
                }
                //third
                if let tmpStr = (JsonArray[i] as! NSDictionary)["third_lifeProblem_home"] as? String{newClient.third_lifeProblem_home = tmpStr}else{
                    
                   newClient.third_lifeProblem_home  = ""
                    
                }
                
                
                //484
                if let tmpStr = (JsonArray[i] as! NSDictionary)["third_lifeProblem_work"] as? String{newClient.third_lifeProblem_work = tmpStr}else{
                    
                   newClient.third_lifeProblem_work = ""
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["third_lifeProblem_others"] as? String{newClient.third_lifeProblem_others = tmpStr}else{
                    
                   newClient.third_lifeProblem_others = ""
                    
                }
                //fourth
                if let tmpStr = (JsonArray[i] as! NSDictionary)["fourth_fivePointDemand_resonablePay"] as? String { newClient.fourth_fivePointDemand_resonablePay  = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.fourth_fivePointDemand_resonablePay = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["fourth_fivePointDemand_chancePromotion"] as? String { newClient.fourth_fivePointDemand_chancePromotion  = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.fourth_fivePointDemand_chancePromotion = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["fourth_fivePointDemand_growUp"] as? String { newClient.fourth_fivePointDemand_growUp  = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.fourth_fivePointDemand_growUp = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["fourth_fovePointDemand_worthOnWork"] as? String { newClient.fourth_fovePointDemand_worthOnWork  = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.fourth_fovePointDemand_worthOnWork = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["fourth_fivePointDeamnd_prospect"] as? String { newClient.fourth_fivePointDeamnd_prospect  = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.fourth_fivePointDeamnd_prospect = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["fourht_fivePointDemand_others"] as? String{newClient.fourht_fivePointDemand_others =  tmpStr}else{
                    
                   newClient.fourht_fivePointDemand_others = ""
                    
                }
                //fifth
                 if let tmpStr = (JsonArray[i] as! NSDictionary)["fifth_careerConcept_ESBI"] as? String {
//                    if tmpStr == "0"{
//                        print("aa2a")
//                        newClient.fifth_careerConcept_ESBI = false
//                    }else{
//                        tmpStr == "1"
//                        print("b2b")
//                        newClient.fifth_careerConcept_ESBI = true
//                    }
                    newClient.fifth_careerConcept_ESBI = returnBool(SQLint:tmpStr)
                    print("cool!! \(newClient.fifth_careerConcept_ESBI)")
                 }else{
                    print("no!! \(newClient.fifth_careerConcept_ESBI)")

                   newClient.fifth_careerConcept_ESBI = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["fifth_careerConcept_duelCareer"] as? String { newClient.fifth_careerConcept_duelCareer  = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.fifth_careerConcept_duelCareer = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["fifth_careerConcept_threeLineInLife"] as? String { newClient.fifth_careerConcept_threeLineInLife  = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.fifth_careerConcept_threeLineInLife = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["fifth_careerConcept_introduceTeam"] as? String { newClient.fifth_careerConcept_introduceTeam  = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.fifth_careerConcept_introduceTeam = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["fifth_careerConcept_others"] as? String{newClient.fifth_careerConcept_others = tmpStr}else{
                    
                   newClient.fifth_careerConcept_others = ""
                    
                }
                //sixth
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sixth_stragegy_eventWork"] as? String{newClient.sixth_stragegy_eventWork = tmpStr}else{
                    
                   newClient.sixth_stragegy_eventWork = ""
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sixth_stragegy_eventDepartment"] as? String{newClient.sixth_stragegy_eventDepartment  = tmpStr}else{
                    
                   newClient.sixth_stragegy_eventDepartment = ""
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sixth_stragegy_eventPersonal"] as? String{newClient.sixth_stragegy_eventPersonal = tmpStr}else{
                    
                   newClient.sixth_stragegy_eventPersonal = ""
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sixth_stragegy_professionBasic"] as? String{newClient.sixth_stragegy_professionBasic  = tmpStr}else{
                    
                   newClient.sixth_stragegy_professionBasic = ""
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sixth_stragegy_prefessionTrain"] as? String{newClient.sixth_stragegy_prefessionTrain  = tmpStr}else{
                    
                   newClient.sixth_stragegy_prefessionTrain = ""
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sixth_stragegy_professionLicenses"] as? String{newClient.sixth_stragegy_professionLicenses = tmpStr}else{
                    
                   newClient.sixth_stragegy_professionLicenses = ""
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sixth_stragegy_others"] as? String{newClient.sixth_stragegy_others = tmpStr}else{
                    
                   newClient.sixth_stragegy_others = ""
                    
                }
                //seventh
                if let tmpStr = (JsonArray[i] as! NSDictionary)["seventh_mainProduct_lifeGuarantee"] as? String{newClient.seventh_mainProduct_lifeGuarantee = tmpStr}else{
                    
                   newClient.seventh_mainProduct_lifeGuarantee = ""
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["seventh_mainProduct_medicalCare"] as? String{newClient.seventh_mainProduct_medicalCare = tmpStr}else{
                    
                   newClient.seventh_mainProduct_medicalCare = ""
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["seventh_mainProduct_moneySaving"] as? String{newClient.seventh_mainProduct_moneySaving = tmpStr}else{
                    
                   newClient.seventh_mainProduct_moneySaving = ""
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["seventh_mainProduct_others"] as? String{newClient.seventh_mainProduct_others = tmpStr}else{
                    
                   newClient.seventh_mainProduct_others = ""
                    
                }
                //eighth
                if let tmpStr = (JsonArray[i] as! NSDictionary)["eighth_objectionProblem_incomeUnstable"] as? String { newClient.eighth_objectionProblem_incomeUnstable  = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.eighth_objectionProblem_incomeUnstable = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["eighth_objectionProblem_marketSaturation"] as? String {  newClient.eighth_objectionProblem_marketSaturation = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.eighth_objectionProblem_marketSaturation = false
                    
                }
                 if let tmpStr = (JsonArray[i] as! NSDictionary)["eighth_objectionProblem_noBusiness"] as? String { newClient.eighth_objectionProblem_noBusiness = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.eighth_objectionProblem_noBusiness = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["eighth_objectionProblem_noClient"] as? String {  newClient.eighth_objectionProblem_noClient = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.eighth_objectionProblem_noClient = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["eighth_objectionProblem_familyOpposite"] as? String { newClient.eighth_objectionProblem_familyOpposite  = returnBool(SQLint:tmpStr)  }else{
                    
                   newClient.eighth_objectionProblem_familyOpposite = false
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["eighth_objectionProblem_others"] as? String{newClient.eighth_objectionProblem_others = tmpStr }else{
                    
                   newClient.eighth_objectionProblem_others = ""
                    
                }
                //ninth
                if let tmpStr = (JsonArray[i] as! NSDictionary)["ninth_salePlan"] as? String{newClient.ninth_salePlan = tmpStr}else{
                    
                   newClient.ninth_salePlan = ""
                    
                }

                newClient.updateStatus = 3
                appDel?.saveContext()
                
            }
            }
        }
    }
    
    //70
    func getBackData_client() {
        let appDel = UIApplication.shared.delegate as? AppDelegate
        //data_sn在login那邊有取
        let SQL : String = "SELECT * FROM `client` WHERE data_sn = \(data_sn)"
        if !peformSQL.checkSqlIsNull(SQL: SQL) {
            let JsonArray = peformSQL.performeSql(SQL: SQL)
            if JsonArray.count > 0{
            for i in 0...JsonArray.count-1{
                
                //設置好資料庫儲存資料單位aClient
                guard let context =  appDel?.persistentContainer.viewContext else{ return }
                let aClient = Client(context: context)
                if let tmpStr = (JsonArray[i] as! NSDictionary)["name"] as? String{
                    
                    aClient.name = tmpStr
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["reasonCome"] as? String{
                    print("reasonCome = \(tmpStr)")
                    aClient.reasonCome = Int16(tmpStr)!
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sex"] as? String{
                    
                    
                    aClient.sex = tmpStr
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["date"] as? String{
                    
                    aClient.date = tmpStr
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["phone"] as? String{
                    
                    aClient.phone = tmpStr
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["year"] as? String{
                    
                    aClient.year = tmpStr
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["married"] as? String{
                    
                    aClient.married = tmpStr
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["work"] as? String{
                    
                    aClient.work = tmpStr
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["salary2"] as? String{
                    
                    aClient.salary2 = tmpStr
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["interesting"] as? String{
                    
                    
                    aClient.interesting = tmpStr
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["history"] as? String{
                    
                    aClient.history = tmpStr
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["children"] as? String{
                    
                    aClient.children = tmpStr
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["mortage"] as? String{
                    
                    aClient.mortage = tmpStr
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["basic_others"] as? String{
                    
                    aClient.basic_others = tmpStr
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["personalityTraits_D"] as? String{
                    
                    aClient.personalityTraits_D = returnBool(SQLint: tmpStr)
                    print("qqqqqq \(aClient.personalityTraits_D)")
                    
                }
              
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["personalityTraits_I"] as? String{
                    
                    aClient.personalityTraits_I = returnBool(SQLint: tmpStr)
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["personalityTraits_S"] as? String{
                    
                    aClient.personalityTraits_S = returnBool(SQLint: tmpStr)
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["personalityTraits_C"] as? String{
                    
                    aClient.personalityTraits_C = returnBool(SQLint: tmpStr)
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["decideRight"] as? String{
                    
                    aClient.decideRight = returnBool(SQLint: tmpStr)
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["insuranceConcept"] as? String{
                    
                    aClient.insuranceConcept = returnBool(SQLint: tmpStr)
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["insuranceConcept2"] as? String{
                    
                    aClient.insuranceConcept2 = returnBool(SQLint: tmpStr)
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sense"] as? String{
                    
                    aClient.sense = returnBool(SQLint: tmpStr)
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["sense2"] as? String{
                    
                    aClient.sense2 = returnBool(SQLint: tmpStr)
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["personalityTraits_others"] as? String{
                    
                    aClient.personalityTraits_others = tmpStr
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["lifeProblemNoService"] as? String{
                    
                    aClient.lifeProblemNoService = returnBool(SQLint: tmpStr)
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["lifeProblemWorkUnstable"] as? String{
                    
                    aClient.lifeProblemWorkUnstable = returnBool(SQLint: tmpStr)
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["lifeProblemNoSense"] as? String{
                    
                    aClient.lifeProblemNoSense = returnBool(SQLint: tmpStr)
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["lifeProblem_others"] as? String{
                    
                    aClient.lifeProblem_others = tmpStr
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["fivePointDemandRetireRefund"] as? String{
                    
                    aClient.fivePointDemandRetireRefund = returnBool(SQLint: tmpStr)
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["fivePointDemandLifeGuarantee"] as? String{
                    
                    aClient.fivePointDemandLifeGuarantee = returnBool(SQLint: tmpStr)
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["fivePointDemandMedicalGuarantee"] as? String{
                    
                    aClient.fivePointDemandMedicalGuarantee = returnBool(SQLint: tmpStr)
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["fivePointDemandCareRefund"] as? String{
                    
                    aClient.fivePointDemandCareRefund = returnBool(SQLint: tmpStr)
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["fivePointDemandAssetTransport"] as? String{
                    
                    aClient.fivePointDemandAssetTransport = returnBool(SQLint: tmpStr)
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["fivePointDemand_others"] as? String{
                    
                    aClient.fivePointDemand_orhers = tmpStr
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["buildBasicConceptYoungMan"] as? String{
                    
                    aClient.buildBasicConceptYoungMan = returnBool(SQLint: tmpStr)
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["buildBasicConceptLifeTour"] as? String{
                    
                    aClient.buildBasicConceptLifeTour = returnBool(SQLint: tmpStr)
                    
                }
                
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["buildBasicConceptBasket"] as? String{
                    
                    aClient.buildBasicConceptBasket = returnBool(SQLint: tmpStr)
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["buildBasicConceptFourQ"] as? String{
                    
                    aClient.buildBasicConceptFourQ = returnBool(SQLint: tmpStr)
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["buildBasicConceptMeal"] as? String{
                    
                    aClient.buildBasicConceptMeal = returnBool(SQLint: tmpStr)
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["buildBasicConcept_others"] as? String{
                    
                    aClient.buildBasicConcept_others = tmpStr
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["strategyHealthPassword"] as? String{
                    
                    aClient.strategyHealthPassword = returnBool(SQLint: tmpStr)
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["strategyCardHeart"] as? String{
                    
                    aClient.strategyCardHeart = returnBool(SQLint: tmpStr)
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["strategy_others"] as? String{
                    
                    aClient.strategy_others = tmpStr
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["strategyMedicalHome"] as? String{
                    
                    aClient.strategyMedicalHome = returnBool(SQLint: tmpStr)
                    
                }
                if let tmpStr = (JsonArray[i] as! NSDictionary)["strategyTaxationLecture"] as? String{
                    
                    aClient.strategyTaxationLecture = returnBool(SQLint: tmpStr)
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["strategyEvent"] as? String{
                    
                    aClient.strategyEvent = returnBool(SQLint: tmpStr)
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["strategyPeriodical"] as? String{
                    
                    aClient.strategyPeriodical = returnBool(SQLint: tmpStr)
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["seventh_mainProduct_medicalCare"] as? String{
                    
                    aClient.seventh_mainProduct_medicalCare = tmpStr
                    
                }
                
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["seventh_mainProduct_lifeGuarantee"] as? String{
                    
                    aClient.seventh_mainProduct_lifeGuarantee = tmpStr
                    
                }
                
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["seventh_mainProduct_moneySaving"] as? String{
                    
                    aClient.seventh_mainProduct_moneySaving = tmpStr
                    
                }
                
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["seventh_mainProduct_others"] as? String{
                    
                    aClient.seventh_mainProduct_others = tmpStr
                    
                }
                
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["oppositeProblemNoMoney"] as? String{
                    
                    aClient.oppositeProblemNoMoney = returnBool(SQLint: tmpStr)
                    
                }
                
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["oppositeProblemBuyTooMore"] as? String{
                    
                    aClient.oppositeProblemBuyTooMore = returnBool(SQLint: tmpStr)
                    
                }
                
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["oppositeProblemConsidering"] as? String{
                    
                    aClient.oppositeProblemConsidering = returnBool(SQLint: tmpStr)
                    
                }
                
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["oppositeProblemDiscussing"] as? String{
                    
                    aClient.oppositeProblemDiscussing = returnBool(SQLint: tmpStr)
                    
                }
                
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["oppositeProblemFriend"] as? String{
                    
                    aClient.oppositeProblemFriend = returnBool(SQLint: tmpStr)
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["oppositeProblemHealthHistory"] as? String{
                    
                    aClient.oppositeProblemHealthHistory = returnBool(SQLint: tmpStr)
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["oppositeProblemInvestOthers"] as? String{
                    
                    aClient.oppositeProblemInvestOthers = returnBool(SQLint: tmpStr)
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["oppositeProblem_others"] as? String{
                    
                    aClient.oppositeProblem_others = tmpStr
                    
                }
                
                if let tmpStr = (JsonArray[i] as! NSDictionary)["salePlan"] as? String{
                    
                    aClient.salePlan = tmpStr
                    
                }
                
               
         

                aClient.seperate = "No"
                aClient.updateStatus = 3
                appDel?.saveContext()  //資料庫儲存

                
            }
            }
        }
    }
    
    
    func returnBool(SQLint:String)->Bool{
        if SQLint == "0" {
            return false
        }else if SQLint == "1" {
            return true
        }
        return true
    }
}
