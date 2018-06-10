//
//  ViewController.swift
//  HelloCoreData
//
//  Created by 楊昇融 on 2017/2/7.
//  Copyright © 2017年 楊昇融. All rights reserved.
//

import UIKit

class module{
    
    var name: String = ""
    var sex: String = ""
    var buildDate: String = ""
    var year: String = ""
    var birth: String = ""
    var phone: String = ""
    var updateStatus: integer_t = 0
    init(){}
    
}

class orangeClientDataView: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var bgimage: UIImageView!
    @IBOutlet weak var tableview: UITableView!
    var s : Int = 0
   var nameArr : [module] = []
    var searchController: UISearchController!
    var isSearchState : Bool = false
    var searchArr: [module] = [module](){
        didSet {
            // 重設 searchArr 後重整 tableView
            tableview.reloadData()
        }
    }

  
    
   
    var index : Int = 1000
    @IBAction func add(_ sender: Any) {
        
        index = 1000
        performSegue(withIdentifier: "goDetailOrangeClient", sender: self)
    }
    @IBAction func addNew(_ sender: Any) {
        
        index = 1000
        performSegue(withIdentifier: "goDetailOrangeClient", sender: self)
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       
        nameArr = []
        searchArr = []
        let appDel2 = UIApplication.shared.delegate as? AppDelegate
        guard let context2 =  appDel2?.persistentContainer.viewContext else{ return }
        
        do{
            let results = try context2.fetch(OrangeClient.fetchRequest())
            for item in results{
                let thisClient = item as? OrangeClient
                if ((thisClient?.updateStatus)! != 2) {
                
                    var x = module()
                    
                    let name = thisClient?.name
                    x.name = name!

                    let year = thisClient?.year
                    x.year = year!
                    
                    let sex = thisClient?.sex
                    x.sex = sex!
                    
                    let build = thisClient?.buildDate
                    x.buildDate = build!
                    
                    let phone = thisClient?.phoneNumber
                    x.phone = phone!
                    
                    let birth = thisClient?.year
                    x.birth = birth!
                    
                    nameArr.append(x)
                }
                
            }
        }catch{}
        
        tableview.reloadData()
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.backgroundView = bgimage
        
        let appDel = UIApplication.shared.delegate as? AppDelegate
        guard let context =  appDel?.persistentContainer.viewContext else{ return }
        
        do{
            let results = try context.fetch(OrangeClient.fetchRequest())
            for item in results{
                
                let thisClient = item as? OrangeClient
                
                
            }
        }catch{
        }
        
        
        // 建立 UISearchController 並設置搜尋控制器為 nil
        searchController = UISearchController(searchResultsController: nil)
        
        // 將更新搜尋結果的對象設為 self
        
        searchController.searchResultsUpdater = self
        
        // 搜尋時是否隱藏 NavigationBar
        // 這個範例沒有使用 NavigationBar 所以設置什麼沒有影響
        searchController.hidesNavigationBarDuringPresentation = false
        
        // 搜尋時是否使用燈箱效果 (會將畫面變暗以集中搜尋焦點)
        searchController.dimsBackgroundDuringPresentation = false
        
        // 搜尋框的樣式
        searchController.searchBar.searchBarStyle = .prominent
        
        // 設置搜尋框的尺寸為自適應
        // 因為會擺在 tableView 的 header
        // 所以尺寸會與 tableView 的 header 一樣
        searchController.searchBar.sizeToFit()
        
        // 將搜尋框擺在 tableView 的 header
        tableview.tableHeaderView = searchController.searchBar
        
        
        let appDel2 = UIApplication.shared.delegate as? AppDelegate
        guard let context2 =  appDel2?.persistentContainer.viewContext else{ return }
        
        do{
            let results = try context2.fetch(OrangeClient.fetchRequest())
            for item in results{
                let thisClient = item as? OrangeClient
                var x = module()
                
                if (thisClient?.updateStatus)! != 2 {
                    x.name = (thisClient?.name)!
                
                x.year = (thisClient?.year)!
            
                x.sex = (thisClient?.sex)!
              
                x.buildDate = (thisClient?.buildDate)!
              
                x.phone = (thisClient?.phoneNumber)!
                
                x.birth = (thisClient?.year)!
                }
                
           
                
                
                 nameArr.append(x)
                
            }
        }catch{
        }
    }
    
    
    
    //傳值
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetailOrangeClient" {
            
            //讓clientDetailed等於vc
            //此時使用"vc.參數" 可以叫出clientDetailed的參數，進一步assign值
            let vc = segue.destination as! OCVC
            // example : vc.prename = nameArray[index]
           
            vc.passSex = nameArr[index].sex
            vc.passBuildDate = nameArr[index].buildDate
            vc.isSearchState = isSearchState
            vc.nameArr = nameArr
            vc.index = index
            
            
            if isSearchState == true {
            
                vc.passName = searchArr[index].name
                vc.passSex = searchArr[index].sex
                vc.passBuildDate = searchArr[index].buildDate
                vc.preYear = searchArr[index].year
            
            }else{
                
                vc.passName = nameArr[index].name
                vc.passSex = nameArr[index].sex
                vc.passBuildDate = nameArr[index].buildDate
                vc.preYear = nameArr[index].year
            
            }
            
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        searchController.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}

