//
//  CustomerNoteViewController.swift
//  HelloCoreData
//
//  Created by User on 2017/3/3.
//  Copyright © 2017年 楊昇融. All rights reserved.
//

import UIKit

extension Date {
    
    var tomorrow: Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
}

class CustomerNoteViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,reloadfirstcreat {
    
    var judge = 0
    var judge2 = 1
    
    var create_button_clicked:Bool = false
    
    
    @IBOutlet weak var bgimage: UIImageView!
    
    func reloadfirstcreat(boo: Bool) {
        firstCreat = boo
    }
    
    
    @IBAction func gohome(_ sender: Any) {
        let myStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let whiteViewController = myStoryBoard.instantiateViewController(withIdentifier: "Main")
        present(whiteViewController, animated:true, completion:nil)
    }
    
    var firstCreat: Bool = false
    
    var indexForRow : Int = 0
    
    var preName : String = ""
    var prePhoneNumber : String = ""
    var preBuildDate : String = ""
    
    var creatDate : [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
        judge = 0
        judge2 = 1
        
        
        if create_button_clicked{
        judge_if_firstcreate2()
            if judge2 == 0 {
                
                
                firstCreat = true
                print("true")
            }else{
                
                print("@@@")
            }
        }else{
            
            print("1")
        }
        print("the firstcreate = \(firstCreat)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        tableview.backgroundView =  bgimage
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dƒd日"
        preBuildDate = formatter.string(from: date)
        
        appendDataToString()
        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "刪除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            
            let alertController = UIAlertController(
                title: "刪除",
                message: "確認要刪除嗎？",
                preferredStyle: .alert)
            
            // 建立[取消]按鈕
            let cancelAction = UIAlertAction(
                title: "取消",
                style: .cancel,
                handler:{
                    (action: UIAlertAction!) -> Void in
                    
            })
            alertController.addAction(cancelAction)
            
            // 建立[確認]按鈕
            let okAction = UIAlertAction(
                title: "確認",
                style: .default,
                handler:{
                    (action: UIAlertAction!) -> Void in
            
            let appDel = UIApplication.shared.delegate as? AppDelegate
            guard let context =  appDel?.persistentContainer.viewContext else{ return }
            
            do{
                let results = try context.fetch(Note.fetchRequest())
                for item in results{
                    
                    guard let thisNote = item as? Note else { return }
                    
                    if thisNote.creatDate == self.creatDate[indexPath.row] && thisNote.clientName == self.preName && thisNote.clientPhoneNumber == self.prePhoneNumber {
                        
                        thisNote.updateStatus = 2
                        appDel?.saveContext()
                        
                    }
                }
            }catch{
            }
            
            self.creatDate.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            self.tableview.reloadData()
        
    })
    alertController.addAction(okAction)
    
    // 顯示提示框
    self.present(
    alertController,
    animated: true,
    completion: nil)
    
    
    
    
    
} else if editingStyle == .insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
}

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creatDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as? noteTableViewCell
        cell?.lab_date.text = creatDate[indexPath.row]
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print("indexPath.row = \(indexPath.row)")
        
        if firstCreat == true {
            if indexPath.row != creatDate.count-1{
                firstCreat = false
                
            }else{
                
                firstCreat = true
            }
        }else{
            
            print("@@")
        }
        indexForRow = indexPath.row
        
        
        performSegue(withIdentifier: "showNoteDetail", sender: nil)
        
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func appendDataToString(){
        
        let appDel = UIApplication.shared.delegate as? AppDelegate
        do{
            guard let context = appDel?.persistentContainer.viewContext  else { return }
            let result = try context.fetch(Note.fetchRequest())
            for item in result{
                let oldNote = item as? Note
                if let name = oldNote?.clientName{
                    if let phone = oldNote?.clientPhoneNumber{
                        print("prephonenumber = \(prePhoneNumber) phone = \(phone)")

                        if let Date = oldNote?.clientBuildDate{
                            if name == preName && phone == prePhoneNumber && oldNote?.updateStatus != 2 {
                                
                                print("name = \(name) prename = \(preName) phone = \(phone) prePhoneNumber = \(prePhoneNumber) ")
                                
                                creatDate.append((oldNote?.creatDate)!)
                            }
                        }
                    }
                }
            }
        }catch{
        }
    }
    @IBOutlet weak var tableview: UITableView!
    
    
    let date = Date()
    let formatter = DateFormatter()
    
    
    func judge_if_firstcreate2(){
        formatter.dateFormat = "yyyy年MM月dd日"

        
        if creatDate.count > 0 {
            for i in 0...creatDate.count-1 {
                
                if creatDate[i] == formatter.string(from: date) {
                    judge2 = 0
                    
                }
                
            }
        }
    }
    
    func judge_if_firstcreate(){
        
        formatter.dateFormat = "yyyy年MM月dd日"
        let today = Date()
        let fformatter = DateFormatter()
        fformatter.dateFormat = "yyyy年MM月dd日"
        var todaydate = formatter.string(from: today)
        
        if creatDate.count > 0 {
            for i in 0...creatDate.count-1 {
                
                if creatDate[i] == formatter.string(from: date) {
                    judge2 = 1
                    print("short")
                    
                }else{
                    judge2 = 0
                }
                
            }
        }else{
            judge2 = 0
            
        }
        
        
        
        
        
        let appDel = UIApplication.shared.delegate as? AppDelegate
        do{
            guard let context = appDel?.persistentContainer.viewContext  else { return }
            let result = try context.fetch(Note.fetchRequest())
            for item in result{
                let oldNote = item as? Note
                
                if let name = oldNote?.clientName{
                    
                    if let phone = oldNote?.clientPhoneNumber{
                        
                        if let Date = oldNote?.clientBuildDate{
                            
                            
                            if name == preName && phone == prePhoneNumber && Date == todaydate{
                                print("cool")
                                judge = 1
                                print("long")
                                break
                                
                            }else{
                                
                                judge = 0
                                
                            }
                            
                            
                            
                            
                        }
                        
                    }
                    
                }
                
                
                /*  if oldNote?.clientName! == preName && oldNote?.clientPhoneNumber! == prePhoneNumber && oldNote?.clientBuildDate! == preBuildDate{
                 print("cool")
                 creatDate.append((oldNote?.creatDate)!)
                 }else{
                 
                 print("oh no prename = \(preName)")} */
            }
        }catch{
        }
        print("judge \(judge) and 2 = \(judge2)")
        
    }
    
    
    
    @IBAction func create(_ sender: Any) {
       
        create_button_clicked = true
        judge_if_firstcreate()
        if judge == 0 && judge2 == 0 {
            
            creatDate.append(formatter.string(from: date))
            firstCreat = true
        }
        // creatDate.append(formatter.string(from: date))
        
        tableview.reloadData()
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNoteDetail"{
            let vc = segue.destination as? noteDetail
            vc?.delegate = self
            vc?.preName = preName
            vc?.prePhoneNumber = prePhoneNumber
            vc?.preCreatDate = creatDate[indexForRow]
            vc?.creat = "1"
            vc?.firstCreat = firstCreat
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
