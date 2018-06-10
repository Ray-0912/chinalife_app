
    
    
    import UIKit
    
    class birth2ViewController: UIViewController {
        @IBOutlet weak var datepicker: UIDatePicker!
        
        
        
        @IBAction func confirm(_ sender: Any) {
            
            formatter.dateFormat = "yyyy年MM月dd日"
            formatter2.dateFormat = "yyyy"
            formatter3.dateFormat = "MM"
            
            
            var yearCal : Int = 0
            yearCal = Int(formatter2.string(from: date))! - Int(formatter2.string(from: datepicker.date))!
            
            let month = Int(formatter3.string(from: date))! - Int(formatter3.string(from: datepicker.date))!
            
            if month < -6 || month > 6{
                yearCal -= 1
            }
            
            let str = String(yearCal) + "," + formatter.string(from: datepicker.date)
            
            delegate?.passParameter(Str: str)
            print(formatter.string(from: datepicker.date))
            dismiss(animated: true, completion: nil)
        }
        
        let date = Date()
        let formatter = DateFormatter()
        let formatter2 = DateFormatter()
        let formatter3 = DateFormatter()
        
        
        
        var delegate: passParameter?
        
        
        
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
