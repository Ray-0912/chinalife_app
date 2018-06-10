//
//  noteDetail.swift
//  HelloCoreData
//
//  Created by 楊昇融 on 2017/2/27.
//  Copyright © 2017年 楊昇融. All rights reserved.
//

protocol reloadfirstcreat {
    
    func reloadfirstcreat( boo : Bool)
    
}

import UIKit


class noteDetail: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var txtview: UITextView!
    
    @IBOutlet weak var slider: UISlider!
    var delegate : reloadfirstcreat?
    var preName : String = ""
    var prePhoneNumber : String = ""
    var preCreatDate : String = ""
    var creat : String = ""
    var firstCreat: Bool?
    var isStore: Bool = false
    var update : Int16 = 0
    
    @IBAction func store(_ sender: Any) {
         var isrepeat = true
        do{
            let appDel = UIApplication.shared.delegate as? AppDelegate
            guard let context = appDel?.persistentContainer.viewContext else {  return  }
            let result = try context.fetch(Note.fetchRequest())
            for item in result{
                let oldNote = item as? Note
                print("see that \(oldNote?.updateStatus)")
                if oldNote?.clientName == preName && (oldNote?.clientPhoneNumber)! == prePhoneNumber && (oldNote?.creatDate)! == preCreatDate {
                    
                    oldNote?.content = txtview.text
                    if self.update != 0 {
                        oldNote?.updateStatus = 1
                    }else{
                    oldNote?.updateStatus = 0
                    }
                    appDel?.saveContext()
                    
                    isrepeat = false
                    break

                }
                else{
                    
                    isrepeat = true
                }
                
            }
        }catch{}
        
        if isrepeat == true {
            buildUpNewNote(creatDate : preCreatDate)
            delegate?.reloadfirstcreat(boo: false)

            isStore = true
            
        }
        
        let defaults = UserDefaults.standard
        defaults.set(slider.value, forKey: "fontsize")
        defaults.synchronize()
        
        
        if let navigationController = self.navigationController
        {
            navigationController.popViewController(animated: true)
        }
        
    }
    
    
    //想說要當頁面沒有儲存時  會提醒，但好像沒用....
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if isStore == false {
            let alertController = UIAlertController(
                title: "尚未儲存",
                message: "要儲存嗎？",
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
                    
                    var isrepeat = true
                    do{
                        let appDel = UIApplication.shared.delegate as? AppDelegate
                        guard let context = appDel?.persistentContainer.viewContext else {  return  }
                        let result = try context.fetch(Note.fetchRequest())
                        for item in result{
                            let oldNote = item as? Note
                            if oldNote?.clientName == self.preName && (oldNote?.clientPhoneNumber)! == self.prePhoneNumber && (oldNote?.creatDate)! == self.preCreatDate {
                                
                                oldNote?.content = self.txtview.text
                                if self.update != 0 {
                                    oldNote?.updateStatus = 1
                                }
                                oldNote?.updateStatus = 0
                                appDel?.saveContext()
                                
                                isrepeat = false
                                break
                                
                            }
                            else{
                                
                                isrepeat = true
                                
                            }
                            
                        }
                    }catch{}
                    
                    if isrepeat == true {
                        self.buildUpNewNote(creatDate : self.preCreatDate)
                        self.delegate?.reloadfirstcreat(boo: false)
                        
                        self.isStore = true
                        
                    }
                    
                    let defaults = UserDefaults.standard
                    defaults.set(self.slider.value, forKey: "fontsize")
                    defaults.synchronize()
                    
                    
                    if let navigationController = self.navigationController
                    {
                        navigationController.popViewController(animated: true)
                    }
            })
            alertController.addAction(okAction)
            
            // 顯示提示框
            self.present(
                alertController,
                animated: true,
                completion: nil)
            
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func onSliderChange() {
        // 設置圖片的透明度
        let slideNum = Int(slider.value)
        txtview.font = .systemFont(ofSize: CGFloat(slideNum))
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UISlider 的最小值
        slider.minimumValue = 0
        
        // UISlider 的最大值
        slider.maximumValue = 70
        
        let defaults = UserDefaults.standard
        if(defaults.string(forKey: "fontsize") != nil){
            slider.value = Float(defaults.string(forKey: "fontsize")!)!
            
            print("defaults = \(defaults.string(forKey: "fontsize")!)")
        }else{
            
            slider.value = 35
            
        }
        
        txtview.font = .systemFont(ofSize: CGFloat(Int(slider.value)))
        
        
        slider.addTarget(self,action:#selector(noteDetail.onSliderChange), for: .valueChanged)
        
        print("viewdidload")
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(noteDetail.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        
        let theDate = Date()
        let formatter = DateFormatter()
        name.text = preName
        if firstCreat! == true {
            formatter.dateFormat = "yyyy年MM月dd日"
            self.name.text = self.preName
            self.date.text = formatter.string(from: theDate)
            self.txtview.text = ""
        }else if firstCreat! == false{
            viewLoadOldNote(name: preName, phoneNumber: prePhoneNumber, creatDate: preCreatDate)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension noteDetail{
    func viewLoadOldNote(name : String , phoneNumber : String , creatDate : String){
        do{
            let appDel = UIApplication.shared.delegate as? AppDelegate
            guard let context = appDel?.persistentContainer.viewContext else {  return  }
            let result = try context.fetch(Note.fetchRequest())
            for item in result{
                let oldNote = item as? Note
                if oldNote?.clientName == name && oldNote?.clientPhoneNumber == phoneNumber && oldNote?.creatDate == creatDate{
                    self.name.text = oldNote?.clientName
                    self.date.text = oldNote?.creatDate
                    self.txtview.text = oldNote?.content
                    print("see~ \((oldNote?.updateStatus)!)")
                    self.update = (oldNote?.updateStatus)!
                }
            }
        }catch{}
    }
    
    func buildUpNewNote(creatDate : String){
        let appDel = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDel?.persistentContainer.viewContext else {  return  }
        let newNote = Note(context : context)
        newNote.clientName = preName
        newNote.clientPhoneNumber = prePhoneNumber
        newNote.clientBuildDate = preCreatDate
        newNote.content = txtview.text
        newNote.creatDate = creatDate
        
        newNote.updateStatus = 0
        if self.update != 0 {
            newNote.updateStatus = 1
        }
        appDel?.saveContext()  //資料庫儲存
    }
}
