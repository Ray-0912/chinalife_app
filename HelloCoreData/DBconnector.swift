//
//  DBconnect.swift
//
//  Created by uuu on 2017/1/21.
//  Copyright © 2017年 helpjob. All rights reserved.
//

import UIKit

public class DBconnect{
    
    public static func executeQuery(query_string: String) -> String
    {
        
        let postString = "query_string=\(query_string)"
        
//         let url = URL(string: "http://ligandpath.mis.ncyu.edu.tw:8888/DBB.php")!
        let url = URL(string: "http://146.148.59.164/DBB.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        var checkstr=""
        var result :String = ""
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for
                print("error=\(String(describing: error))")
                return
            }
            
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            
            result = String(data: data, encoding: .utf8)!
            
            checkstr="true"
            
        }
        task.resume()
        
        while(checkstr==""){
        }
        
        return result
    }
}

