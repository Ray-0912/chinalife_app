//
//  pickerviewViewController.swift
//  pickerview
//
//  Created by User on 2017/2/11.
//  Copyright © 2017年 AppCoda. All rights reserved.
//

protocol passParameter{

    func passParameter(Str: String)
    
}

import UIKit

class pickerviewViewController: UIViewController {

    @IBOutlet weak var datepicker: UIDatePicker!
    
    @IBAction func press(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
        
        formatter.dateFormat = "yyyy年MM月dd日"
        
       
        
        delegate?.passParameter(Str: String(formatter.string(from: datepicker.date)))
        print(formatter.string(from: datepicker.date))
        dismiss(animated: true, completion: nil)
    
    
}
    
    var delegate: passParameter?
 let formatter = DateFormatter()
    var Str: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
