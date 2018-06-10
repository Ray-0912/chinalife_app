//
//  ContainerTableViewController.swift
//  terry
//
//  Created by User on 2017/2/13.
//  Copyright © 2017年 AppCoda. All rights reserved.
//

import UIKit

public class Cell{
    var name : String!
    var phone: String!
    var SeperateClass: String!
    var CellStatus : Bool = false
    var clientClass : String = ""
    init(){}
}

class ContainerTableViewController:
UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIPopoverPresentationControllerDelegate,passParameter {
    
    @IBOutlet weak var textfield: UITextField!
    func passParameter(Str: String){
        
        
        textfield.text = Str
        print("textfield = \(String(describing: textfield.text))")
        ToDoList = []
        
        guard let context = appDel?.persistentContainer.viewContext else {
            return
        }
        formatter.dateFormat = "yyyy年MM月dd日"
        dateInString = textfield.text!
        do{
            let result = try context.fetch(Event.fetchRequest())
            for item in result{
                let x = Cell()
                let newEvent = item as? Event
                
                let eventClientName = (newEvent?.eventClientName)! as String
                
                
               
                
                let eventClientPhone = (newEvent?.eventClientPhone)! as String
             
                let eventClientSeperate = (newEvent?.eventClientSeperate)! as String
                let eventDone = (newEvent?.eventDone)! as Bool
                let eventDate = (newEvent?.eventDate)! as String
                let eventClas = (newEvent?.clientClass)! as String
                
                 print("dateINSTring = \(dateInString) eventDate = \(eventDate)  eventDon = \(eventDone)")
                
                if dateInString == eventDate && eventDone == false{
                    
                    
                    x.name = eventClientName
                    x.phone = eventClientPhone
                    x.SeperateClass = eventClientSeperate
                    x.CellStatus = false
                    x.clientClass = eventClas
                  
                    ToDoList.append(x)
                    print("cool")
                  
                }else{
                    
              
                    
                }
            }
        }catch{
        }
        tableView.reloadData()
        
      

        
    
        
    }
    @IBOutlet weak var bgimage: UIImageView!
    @IBAction func pop(_ sender: Any) {
        
         performSegue(withIdentifier: "popover", sender: nil)
    
    
    }
    
    var ToDoList : [Cell] = []
    var x = [Int]()
    
    let appDel = UIApplication.shared.delegate as? AppDelegate
    let todayDate = Date()
    let formatter = DateFormatter()
    
    var dateInString : String = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBAction func endEditing(_ sender: Any) {
        
        ToDoList = []
        
        guard let context = appDel?.persistentContainer.viewContext else {
            return
        }
        formatter.dateFormat = "yyyy年MM月dd日"
        dateInString = textfield.text!
        do{
            let result = try context.fetch(Event.fetchRequest())
            for item in result{
                let x = Cell()
                let newEvent = item as? Event
                
                let eventClientName = (newEvent?.eventClientName)! as String
                
                
                print("\(String(describing: newEvent?.eventClientPhone))! as String)")
                
                let eventClientPhone = (newEvent?.eventClientPhone)! as String
                print("hey phone = \(eventClientPhone)")
                let eventClientSeperate = (newEvent?.eventClientSeperate)! as String
                let eventDone = (newEvent?.eventDone)! as Bool
                let eventDate = (newEvent?.eventDate)! as String
                let eventClas = (newEvent?.clientClass)! as String
                print("fuck ! class = \(eventClas) name = \(eventClientName)")
                print(eventClientName)
                print("dateinstring = \(dateInString) , eventDate = \(eventDate)")
                
                
                if dateInString == eventDate && eventDone == false{
                    
                    
                    x.name = eventClientName
                    x.phone = eventClientPhone
                    x.SeperateClass = eventClientSeperate
                    x.CellStatus = false
                    x.clientClass = eventClas
                   print("x.name = \(x.name) x.clientClass = \(x.clientClass)")
                    ToDoList.append(x)
                    print("hhhhhh")
                    
                    
                }else{
                    
                    print("failed")
                    
                }
            }
        }catch{
        }
        
        tableView.reloadData()
        
    }
    
    
    
    
    
    @IBAction func click(_ sender: Any) {
        
    
        performSegue(withIdentifier: "passdata", sender: self)
       
    }
    
    
    let rightButton = UIButton(type: .system)
    private func setupNavigationitem(){
        rightButton.setImage(#imageLiteral(resourceName: "home50").withRenderingMode(.alwaysOriginal),for: .normal)
        rightButton.frame = CGRect(x: 0,y: 0,width: 20 , height: 20)
        rightButton.contentMode = .scaleAspectFit
        
        rightButton.addTarget(self, action: #selector(gohome), for: .touchUpInside)
        
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationitem()
        tableView.backgroundView = bgimage
        
        
        print("重宰了")
        
        ToDoList = []
        
        guard let context = appDel?.persistentContainer.viewContext else {
            return
        }
        formatter.dateFormat = "yyyy年MM月dd日"
        dateInString = formatter.string(from: todayDate)
        
        do{
            let result = try context.fetch(Event.fetchRequest())
            for item in result{
                let x = Cell()
                let newEvent = item as? Event
                
                let eventClientName = (newEvent?.eventClientName)! as String
                
                
               
                
                let eventClientPhone = (newEvent?.eventClientPhone)! as String
           
                print("看我 ！phone = \((newEvent?.eventClientPhone)!) ")
                let eventClientSeperate = (newEvent?.eventClientSeperate)! as String
                let eventDone = (newEvent?.eventDone)! as Bool
                let eventDate = (newEvent?.eventDate)! as String
                let eventClas = (newEvent?.clientClass)! as String
              
                
                
                if dateInString == eventDate && eventDone == false{
                    
                    
                    x.name = eventClientName
                    x.phone = eventClientPhone
                    x.SeperateClass = eventClientSeperate
                    x.CellStatus = false
                    x.clientClass = eventClas
                 
                    ToDoList.append(x)
                 
                }else{
                
                   
                    
                }
            }
        }catch{
        }
        
       
        
        textfield.text = dateInString
        tableView.reloadData()
                // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
  func gohome() {
        
        let myStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let whiteViewController = myStoryBoard.instantiateViewController(withIdentifier: "Main")
        present(whiteViewController, animated:true, completion:nil)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! VividCreatCell
        cell.name.text = ToDoList[indexPath.row].name
        cell.phone.text = ToDoList[indexPath.row].phone == "" ? "無" : ToDoList[indexPath.row].phone
        cell.seperate.text = ToDoList[indexPath.row].SeperateClass
        
        if ToDoList[indexPath.row].clientClass == "增員" {
            print("顯示紅色的有 \(ToDoList[indexPath.row].name) \(ToDoList[indexPath.row].clientClass)")
            cell.name.textColor = .red
            cell.phone.textColor = .red
            cell.seperate.textColor = .red
        
        }else{
            cell.name.textColor = .black
            cell.phone.textColor = .black
            cell.seperate.textColor = .black
            
        
        print("clientclass = \(ToDoList[indexPath.row].clientClass)")
        }
        
        
        
        if ToDoList[indexPath.row].CellStatus == true{
            
            cell.accessoryType = .checkmark
            print("check")
        }else{
            
            cell.accessoryType = .none
            print("none")
            
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        _ = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        ToDoList[indexPath.row].CellStatus = !ToDoList[indexPath.row].CellStatus
        guard let context = appDel?.persistentContainer.viewContext else { return }
        do{
            let result = try context.fetch(Event.fetchRequest())
            for item in result{
                let aEvent = item as? Event
                if aEvent?.eventClientName == ToDoList[indexPath.row].name && aEvent?.eventDate == textfield.text {
                    aEvent?.eventDone = true
                    
                    appDel?.saveContext()
                }
            }
        }catch{
        }
        
        ToDoList.remove(at: indexPath.row)
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .fade)
        tableView.endUpdates()
        
        
          tableView.reloadData()
        
      
    }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "passdata" {
            
                let vc = (segue.destination as! UINavigationController).topViewController as! CompleteItemsViewController
                vc.thebefore = textfield.text!
            
            
            }
            
            
            if segue.identifier == "popover"{
                let vc = segue.destination
                
                
                //調整pop出來視窗的大小
                vc.preferredContentSize = CGSize(width: 250, height: 200)
                
                let v = segue.destination as! pickerviewViewController
                v.delegate = self
                
                
                
                let controller = vc.popoverPresentationController
                
                if controller != nil{
                    
                    controller?.delegate = self
                    
                }
            }
         
            
            
        }

        
        
     
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    
    
    
    
}




