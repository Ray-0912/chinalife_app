//
//  CompleteItemsViewController.swift
//  terry
//
//  Created by User on 2017/2/13.
//  Copyright © 2017年 AppCoda. All rights reserved.
//

import UIKit




class CompleteItemsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate,passParameter {
    
  
    
    func passParameter(Str: String) {
        
        textfield.text = Str
        
        complete = []
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
                
                print(eventClientName)
               
                
                
                if dateInString == eventDate && eventDone == true{
                    
                    
                    x.name = eventClientName
                    x.phone = eventClientPhone
                    x.SeperateClass = eventClientSeperate
                    x.CellStatus = false
                    x.clientClass = eventClas
                    print("x.name = \(x.name)  x.phone = \(x.phone)")
                    complete.append(x)
                }else{
                    
                    print("failed")
                    
                }
            }
        }catch{
        }

        
        tableview.reloadData()
    }
   
    @IBOutlet weak var bgimage: UIImageView!
    
    @IBAction func setDatePop(_ sender: Any) {
        performSegue(withIdentifier: "popover2", sender: self)
    }
    @IBOutlet weak var textfield: UITextField!
    var complete : [Cell] = []
    var x = [Int]()
    var dateInString : String = ""
    let appDel = UIApplication.shared.delegate as? AppDelegate
    let todayDate = Date()
    let formatter = DateFormatter()
    
   func gohome() {
        
        let myStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let whiteViewController = myStoryBoard.instantiateViewController(withIdentifier: "Main")
        present(whiteViewController, animated:true, completion:nil)
    }
    @IBOutlet weak var tableview: UITableView!
       var thebefore : String = ""
    @IBAction func setDate(_ sender: Any) {
     
        complete = []
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
                
                print(eventClientName)
         
                
                
                if dateInString == eventDate && eventDone == true{
                    
                    
                    x.name = eventClientName
                    x.phone = eventClientPhone
                    x.SeperateClass = eventClientSeperate
                    x.CellStatus = false
                    x.clientClass = eventClas
                    print("x.name = \(x.name)  x.phone = \(x.phone)")
                    complete.append(x)
                }else{
                    
                    print("failed")
                    
                }
            }
        }catch{
        }

        
        tableview.reloadData()
        
        
    }
   
   
    @IBAction func click(_ sender: Any) {
        
        
        
        
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

        tableview.backgroundView = bgimage
        
    
        
 textfield.text = thebefore
        complete = []
        
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
                print(eventClientName)
              
                
                
                if dateInString == eventDate && eventDone == true{
                    
                    
                    x.name = eventClientName
                    x.phone = eventClientPhone
                    x.SeperateClass = eventClientSeperate
                    x.CellStatus = false
                    x.clientClass = eventClas
                    print("x.name = \(x.name)  x.phone = \(x.phone)")
                    complete.append(x)
                }else{
                    
                    print("failed")
                    
                }
            }
        }catch{
        }
        //textfield.text = dateInString
        tableview.reloadData()
        textfield.text = thebefore
        // Do any additional setup after loading the view, typically from a nib.
    }

        
        
        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    /*    for i in 0...complete.count-1{
            if complete[i].CellStatus == true{
                complete[i].CellStatus = false
                x.append(i)
                
            }
        }
        
        if x.count > 0 {
            
            for i in 0...x.count-1{
                
                x[i] = x[i] - i
                complete.remove(at: x[i])
                tableView.beginUpdates()
                tableView.deleteRows(at: [IndexPath(row: x[i], section: 0)], with: .fade)
                tableView.endUpdates()
                
                
            }
            
            
        }
        x = []
print("ss")*/
           }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! VividCreatCell
        
        print(complete[indexPath.row].name)
        cell.name2.text = complete[indexPath.row].name
        cell.phone2.text = complete[indexPath.row].phone
        cell.seperate2.text = complete[indexPath.row].SeperateClass
        
        
        if complete[indexPath.row].clientClass == "增員" {
        
        cell.name2.textColor = .red
            cell.phone2.textColor = .red
            cell.seperate2.textColor = .red
        
        }
        
        if complete[indexPath.row].CellStatus == true{
        
            cell.accessoryType = .checkmark
        
        }else{
        
            cell.accessoryType = .none
        
        }
        
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return complete.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        complete[indexPath.row].CellStatus = !complete[indexPath.row].CellStatus
        guard let context = appDel?.persistentContainer.viewContext else { return }
        do{
            let result = try context.fetch(Event.fetchRequest())
            for item in result{
                let aEvent = item as? Event
                if aEvent?.eventClientName == complete[indexPath.row].name && aEvent?.eventDate == textfield.text{
                    aEvent?.eventDone = false
                    
                    appDel?.saveContext()
                }
            }
        }catch{
        }
        
        complete.remove(at: indexPath.row)
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .fade)
        tableView.endUpdates()
        
        tableView.reloadData()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popover2"{
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
