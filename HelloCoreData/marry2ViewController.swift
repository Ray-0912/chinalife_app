

    
    import UIKit
    
    
    //
    //  pickerviewViewController.swift
    //  pickerview
    //
    //  Created by User on 2017/2/11.
    //  Copyright © 2017年 AppCoda. All rights reserved.
    //
    
    protocol ChildrenPickpassParameter6{
        
        func ChildrenPickpassParameter6(Str: String)
        
    }
    
    
    
    class marry2ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
        
        @IBOutlet weak var picker: UIPickerView!
        var delegate: ChildrenPickpassParameter6?
        var info = ["未婚","已婚"]
        var Str: String = ""
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
            
        }
        
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return info.count
        }
        
        
        
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return info[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            Str = info[row]
            delegate?.ChildrenPickpassParameter6(Str: Str)
            dismiss(animated: true, completion: nil)
            
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
