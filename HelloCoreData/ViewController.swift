//
//  ViewController.swift
//  HelloCoreData
//
//  Created by 楊昇融 on 2017/2/7.
//  Copyright © 2017年 楊昇融. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func checkToCustomCV(_ sender: UIButton) {
        performSegue(withIdentifier: "showCustomVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCustomVC"{
       //    let controller = segue.destination as! customVC
            let controller = segue.destination as! scoreData
            controller.date = datePicker.date
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
