//
//  clientSeperate.swift
//  HelloCoreData
//
//  Created by 楊昇融 on 2017/2/13.
//  Copyright © 2017年 楊昇融. All rights reserved.
//

import UIKit
import EventKit

class clientSeperate: UIViewController{
    
    @IBOutlet weak var btn_seperateA: UIButton!
    @IBOutlet weak var btn_seperateB: UIButton!
    @IBOutlet weak var btn_seperateC: UIButton!
    @IBOutlet weak var btn_seperateD: UIButton!
    @IBOutlet weak var btn_seperateNo: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    var prepreName: String = ""
    let date = Date()
    let calendar = Calendar.current
    let formatter = DateFormatter()
    
    var savedEventId : String = ""  //event用變數

    var preName : String = ""    //前頁回傳暫存值
    var prebuildDate : String = ""
    var preYear : String = ""
    var prePhone : String = ""
    var clientClass : String = ""
    var seperate : String = ""  //分級用變數
                                //A1，B3，C6，D10
    
    var strForClientSP : String = ""

    @IBAction func cancel(_ sender: Any) {
       
        
        
        if prepreName == "" {
            
            if strForClientSP == "客戶"{
                //要刪掉coredata資料
                let appDel = UIApplication.shared.delegate as? AppDelegate
                guard let context =  appDel?.persistentContainer.viewContext else{ return }
                do{
                    let results = try context.fetch(Client.fetchRequest())
                    for item in results{
                        
                        guard let thisClient = item as? Client else { return }
                        if thisClient.name == preName {
                            context.delete(thisClient)
                            appDel?.saveContext()
                        }
                    }
                }catch let error as NSError{
                    print(error)
                }
            }else if strForClientSP == "增員" {
                //要刪掉coredata資料
                let appDel = UIApplication.shared.delegate as? AppDelegate
                guard let context =  appDel?.persistentContainer.viewContext else{ return }
                do{
                    let results = try context.fetch(OrangeClient.fetchRequest())
                    for item in results{
                        
                        guard let thisClient = item as? OrangeClient else { return }
                        if thisClient.name == preName {
                            context.delete(thisClient)
                            appDel?.saveContext()
                        }
                    }
                }catch let error as NSError{
                    print(error)
                }
            }
            
            
            
        }
 self.dismiss(animated: true, completion: nil)
      
    }
    
    @IBAction func btn_seperate(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            sender.setImage(UIImage(named:"check"), for: .normal)
            btn_seperateB.setImage(UIImage(named:"checkbox"), for: .normal)
            btn_seperateC.setImage(UIImage(named:"checkbox"), for: .normal)
            btn_seperateD.setImage(UIImage(named:"checkbox"), for: .normal)
            btn_seperateNo.setImage(UIImage(named:"checkbox"), for: .normal)
            seperate = "A"
        case 1:
            sender.setImage(UIImage(named:"check"), for: .normal)
            btn_seperateA.setImage(UIImage(named:"checkbox"), for: .normal)
            btn_seperateC.setImage(UIImage(named:"checkbox"), for: .normal)
            btn_seperateD.setImage(UIImage(named:"checkbox"), for: .normal)
            btn_seperateNo.setImage(UIImage(named:"checkbox"), for: .normal)
            seperate = "B"
        case 2:
            sender.setImage(UIImage(named:"check"), for: .normal)
            btn_seperateA.setImage(UIImage(named:"checkbox"), for: .normal)
            btn_seperateB.setImage(UIImage(named:"checkbox"), for: .normal)
            btn_seperateD.setImage(UIImage(named:"checkbox"), for: .normal)
            btn_seperateNo.setImage(UIImage(named:"checkbox"), for: .normal)
            seperate = "C"
        case 4 :
            sender.setImage(UIImage(named:"check"), for: .normal)
            btn_seperateA.setImage(UIImage(named:"checkbox"), for: .normal)
            btn_seperateB.setImage(UIImage(named:"checkbox"), for: .normal)
            btn_seperateC.setImage(UIImage(named:"checkbox"), for: .normal)
            btn_seperateD.setImage(UIImage(named:"checkbox"), for: .normal)
            seperate = "No"
        default:
            sender.setImage(UIImage(named:"check"), for: .normal)
            btn_seperateA.setImage(UIImage(named:"checkbox"), for: .normal)
            btn_seperateB.setImage(UIImage(named:"checkbox"), for: .normal)
            btn_seperateC.setImage(UIImage(named:"checkbox"), for: .normal)
            btn_seperateNo.setImage(UIImage(named:"checkbox"), for: .normal)
            seperate = "D"
        }
    }

    @IBAction func check(_ sender: UIButton) {
        let appDel = UIApplication.shared.delegate as? AppDelegate
        guard let context =  appDel?.persistentContainer.viewContext else{ return }
        
        let eventStore = EKEventStore()
        var startDate = datePicker.date
        var endDate = startDate.addingTimeInterval(60 * 60) // One hour
        
        formatter.dateFormat = "yyyy年MM月dd日"
        
        var forRun : Int = 1
        
        do{
            let result = try context.fetch(Event.fetchRequest())
            for item in result{
                let old = item as? Event
                if old?.eventClientName! == preName && old?.clientYear! == preYear{
                    
                    if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized) {
                        eventStore.requestAccess(to: .event, completion: { (granted, error) -> Void in
                            self.deleteEvent(eventStore, eventIdentifier: (old?.identifier)!)
                        })
                    } else {
                        deleteEvent(eventStore, eventIdentifier: (old?.identifier)!)
                        
                        context.delete(old!)
                        appDel?.saveContext()
                    }
                    
                }else{
                }
            }
        }catch{
        }
        
        if seperate == "" {
          
            let alertController = UIAlertController(title: "錯誤" , message: "客戶分級還沒填喔！" , preferredStyle: .alert)
            
            // 建立[確認]按鈕
            let okAction = UIAlertAction(title: "確認" , style: .default)
                {
                    (action:UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
                }

            alertController.addAction(okAction)
            
            // 顯示提示框
            present(alertController , animated: true , completion: nil)
            
         
            
        }else if seperate != ""{
            do{
                let result = try context.fetch(Client.fetchRequest())
                for item in result{
                    let thisClient = item as? Client
                    if thisClient?.name == preName && thisClient?.date == prebuildDate && thisClient?.year == preYear{
                        thisClient?.seperate = seperate
                        appDel?.saveContext()
                    }
                }
            }catch{
            }
            
            if seperate == "A"{
                for  _ in 1...10{
                    if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized) {
                        eventStore.requestAccess(to: .event, completion: {
                        granted, error in
                        self.createEvent(eventStore, title: self.strForClientSP + " " + self.preName, startDate: startDate, endDate: endDate)})
                    } else {
                        createEvent(eventStore, title: self.strForClientSP + " " + self.preName, startDate: startDate, endDate: endDate)
                        let event = Event(context : context)
                        
                        event.eventClientName = preName
                        event.eventClientPhone = prePhone
                        event.eventClientSeperate = seperate
                        event.eventDate = formatter.string(from: endDate)
                        event.eventDone = false
                        event.clientYear = preYear
                        event.identifier = savedEventId
                       
                        event.clientClass = clientClass
                        appDel?.saveContext()
                        
                        startDate = startDate.addingTimeInterval(TimeInterval(forRun)*7*24*60*60)
                        endDate = endDate.addingTimeInterval(TimeInterval(forRun)*7*24*60*60)
                    }
                }
            }else if seperate == "B"{
                forRun = 3
                for  _ in 1...6{
                    if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized) {
                        eventStore.requestAccess(to: .event, completion: {
                            granted, error in
                            self.createEvent(eventStore, title: self.strForClientSP + " " + self.preName, startDate: startDate, endDate: endDate)})
                    } else {
                        createEvent(eventStore, title: self.strForClientSP + " " + self.preName, startDate: startDate, endDate: endDate)
                        let event = Event(context : context)
                        
                        event.eventClientName = preName
                        event.eventClientPhone = prePhone
                        event.eventClientSeperate = seperate
                        event.eventDate = formatter.string(from: endDate)
                        event.eventDone = false
                        event.clientYear = preYear
                        event.identifier = savedEventId
                          event.clientClass = clientClass
                        appDel?.saveContext()
                        
                        startDate = startDate.addingTimeInterval(TimeInterval(forRun)*7*24*60*60)
                        endDate = endDate.addingTimeInterval(TimeInterval(forRun)*7*24*60*60)
                    }
                }
            }else if seperate == "C"{
                forRun = 6
                for  _ in 1...6{
                    if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized) {
                        eventStore.requestAccess(to: .event, completion: {
                            granted, error in
                            self.createEvent(eventStore, title: self.strForClientSP + " " + self.preName, startDate: startDate, endDate: endDate)})
                    } else {
                        createEvent(eventStore, title: self.strForClientSP + " " + self.preName, startDate: startDate, endDate: endDate)
                        let event = Event(context : context)
                        
                        event.eventClientName = preName
                        event.eventClientPhone = prePhone
                        event.eventClientSeperate = seperate
                        event.eventDate = formatter.string(from: endDate)
                        event.eventDone = false
                        event.clientYear = preYear
                        event.identifier = savedEventId
                          event.clientClass = clientClass
                        appDel?.saveContext()
                        
                        startDate = startDate.addingTimeInterval(TimeInterval(forRun)*7*24*60*60)
                        endDate = endDate.addingTimeInterval(TimeInterval(forRun)*7*24*60*60)
                    }
                }
            }else if seperate == "D"{
                forRun = 10
                for  _ in 1...6{
                    if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized) {
                        eventStore.requestAccess(to: .event, completion: {
                            granted, error in
                            self.createEvent(eventStore, title: self.strForClientSP + " " + self.preName, startDate: startDate, endDate: endDate)})
                    } else {
                        createEvent(eventStore, title: self.strForClientSP + " " + self.preName, startDate: startDate, endDate: endDate)
                        let event = Event(context : context)
                        
                        event.eventClientName = preName
                        event.eventClientPhone = prePhone
                        event.eventClientSeperate = seperate
                        event.eventDate = formatter.string(from: endDate)
                        event.eventDone = false
                        event.clientYear = preYear
                        event.identifier = savedEventId
                          event.clientClass = clientClass
                        appDel?.saveContext()
                        
                        startDate = startDate.addingTimeInterval(TimeInterval(forRun)*7*24*60*60)
                        endDate = endDate.addingTimeInterval(TimeInterval(forRun)*7*24*60*60)
                    }
                }
            }
        
        }
        print("hello?")
        
        
        self.dismiss(animated: true, completion: nil)
      
    }

    
    // 建立事件的function
    func createEvent(_ eventStore: EKEventStore, title: String, startDate: Date, endDate: Date) {
        let event = EKEvent(eventStore: eventStore)
        
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = eventStore.defaultCalendarForNewEvents
      
        do {
         
            try eventStore.save(event, span: .thisEvent)
            self.savedEventId = event.eventIdentifier
        } catch {
            print("Bad things happened \(error.localizedDescription)")
        }
    }
    // 移除事件的function
    func deleteEvent(_ eventStore: EKEventStore, eventIdentifier: String) {
        let eventToRemove = eventStore.event(withIdentifier: eventIdentifier)
        if (eventToRemove != nil) {
            do {
                try eventStore.remove(eventToRemove!, span: .thisEvent)
            } catch {
                print("Bad things happened")
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        
        print("clientclass = \(clientClass)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
