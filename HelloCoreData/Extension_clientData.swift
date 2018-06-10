//
//  Extension_clientData.swift
//  HelloCoreData
//
//  Created by User on 2017/2/15.
//  Copyright © 2017年 楊昇融. All rights reserved.
//

import Foundation
import UIKit
import EventKit

extension clientData: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive) {
            return searchArr.count
        } else {
            return nameArr.count
        }
        
        
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for : indexPath) as! TableViewCell
        
        
        if (searchController.isActive) {
            
            cell.name.text = searchArr[indexPath.row].name
            cell.sex.text = searchArr[indexPath.row].sex
            cell.phone.text = searchArr[indexPath.row].phone
            cell.birth.text = searchArr[indexPath.row].birth
            cell.num.text = String(indexPath.row+1)
            return cell
        } else {
            
            cell.name.text = nameArr[indexPath.row].name
            cell.sex.text = nameArr[indexPath.row].sex
            cell.phone.text = nameArr[indexPath.row].phone
            cell.birth.text = nameArr[indexPath.row].birth
            cell.num.text = String(indexPath.row+1)
            return cell
        }
    }
}

extension clientData: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (searchController.isActive) {
            isSearchState = true
            index = indexPath.row
            
            performSegue(withIdentifier: "goDetail", sender: self)
             searchController.dismiss(animated: true, completion: nil)
            
        } else {
            isSearchState = false
            index = indexPath.row
            searchController.dismiss(animated: true, completion: nil)
            performSegue(withIdentifier: "goDetail", sender: self)
            
        }
    }
    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
     func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "刪除"
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            //要刪掉coredata資料
            
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
                    
                    let eventStore = EKEventStore()
                    
                    do{
                        let results = try context.fetch(Client.fetchRequest())
                        for item in results{
                            
                            guard let thisClient = item as? Client else { return }
                            
                            if thisClient.name == self.nameArr[indexPath.row].name && thisClient.sex == self.nameArr[indexPath.row].sex && thisClient.date == self.nameArr[indexPath.row].buildDate && thisClient.year == self.nameArr[indexPath.row].year{
                                
                                thisClient.updateStatus = 2
                                appDel?.saveContext()
                                
                            }
                            
                        }
                    }catch{
                    }
                    
                    do{
                        let result = try context.fetch(Event.fetchRequest())
                        for item in result{
                            let old = item as? Event
                            if old?.eventClientName == self.nameArr[indexPath.row].name && old?.clientYear == self.nameArr[indexPath.row].year{
                                
                                if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized) {
                                    eventStore.requestAccess(to: .event, completion: { (granted, error) -> Void in
                                        self.deleteEvent(eventStore, eventIdentifier: (old?.identifier)!)
                                    })
                                } else {
                                    self.deleteEvent(eventStore, eventIdentifier: (old?.identifier)!)
                                    
                                    context.delete(old!)
                                    appDel?.saveContext()
                                }
                                
                            }
                        }
                    }catch{
                    }
                    
                    
                    
                    self.nameArr.remove(at: indexPath.row)
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
    
}



extension clientData: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // 取得搜尋文字
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        searchArr = nameArr.filter { (city) -> Bool in
            return city.name.contains(searchText)
        }
    }
}
