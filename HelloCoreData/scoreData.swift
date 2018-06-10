//
//  scoreData.swift
//  HelloCoreData
//
//  Created by User on 2017/2/22.
//  Copyright © 2017年 楊昇融. All rights reserved.
//

//讓textfield連接起來，實現按return鍵就跳下一個textfield
extension UITextField {
    class func connectFields(fields:[UITextField]) -> Void {
        guard let last = fields.last else {
            return
        }
        for i in 0 ..< fields.count - 1 {
            fields[i].returnKeyType = .next
            fields[i].addTarget(fields[i+1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        last.returnKeyType = .done
        last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }
}



import UIKit

class scoreData: UIViewController,UITextFieldDelegate {
    let rightButton = UIButton(type: .system)
    
    private func setupNavigationitem(){
        rightButton.setImage(#imageLiteral(resourceName: "home50").withRenderingMode(.alwaysOriginal),for: .normal)
        rightButton.frame = CGRect(x: 0,y: 0,width: 20 , height: 20)
        rightButton.contentMode = .scaleAspectFit
        
        rightButton.addTarget(self, action: #selector(gohome), for: .touchUpInside)
        
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        
        
    }
    
    
    
    
    
    func gohome() {
        
        let myStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let whiteViewController = myStoryBoard.instantiateViewController(withIdentifier: "Main")
        present(whiteViewController, animated:true, completion:nil)
        
        
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "" || textField.text == "0"{
            textField.text = ""
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == ""
        {
            textField.text = "0"
        }
    }
    
    
    
    
    
    
    var scoreDate : [String] = ["","","","","","",""]
    var scoreIntroduction : [String] = ["","","","","","",""]
    var scoreDateSelf : [String] = ["","","","","","",""]
    var scoreGetDate : [String] = ["","","","","","",""]
    var scoreFirstFace : [String] = ["","","","","","",""]
    var scoreDigDemand : [String] = ["","","","","","",""]
    var scoreExplain : [String] = ["","","","","","",""]
    var scoreDeal : [String] = ["","","","","","",""]
    var scoreTotal : [String] = ["","","","","","",""]
    
    var thePercent : [Double] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0]
    var theDate : [String] = ["0","0","0","0","0","0","0"]
    
    var strWeakTotal : String = ""
    
    var date = Date()
    let formatter = DateFormatter()
    
    @IBOutlet weak var introduction0: UITextField!
    @IBOutlet weak var introduction1: UITextField!
    @IBOutlet weak var introduction2: UITextField!
    @IBOutlet weak var introduction3: UITextField!
    @IBOutlet weak var introduction4: UITextField!
    @IBOutlet weak var introduction5: UITextField!
    @IBOutlet weak var introduction6: UITextField!
    
    @IBOutlet weak var dateSelf0: UITextField!
    @IBOutlet weak var dateSelf1: UITextField!
    @IBOutlet weak var dateSelf2: UITextField!
    @IBOutlet weak var dateSelf3: UITextField!
    @IBOutlet weak var dateSelf4: UITextField!
    @IBOutlet weak var dateSelf5: UITextField!
    @IBOutlet weak var dateSelf6: UITextField!
    
    @IBOutlet weak var getDate0: UITextField!
    @IBOutlet weak var getDate1: UITextField!
    @IBOutlet weak var getDate2: UITextField!
    @IBOutlet weak var getDate3: UITextField!
    @IBOutlet weak var getDate4: UITextField!
    @IBOutlet weak var getDate5: UITextField!
    @IBOutlet weak var getDate6: UITextField!
    
    @IBOutlet weak var firstFace0: UITextField!
    @IBOutlet weak var firstFace1: UITextField!
    @IBOutlet weak var firstFace2: UITextField!
    @IBOutlet weak var firstFace3: UITextField!
    @IBOutlet weak var firstFace4: UITextField!
    @IBOutlet weak var firstFace5: UITextField!
    @IBOutlet weak var firstFace6: UITextField!
    
    @IBOutlet weak var digDemand0: UITextField!
    @IBOutlet weak var digDemand1: UITextField!
    @IBOutlet weak var digDemand2: UITextField!
    @IBOutlet weak var digDemand3: UITextField!
    @IBOutlet weak var digDemand4: UITextField!
    @IBOutlet weak var digDemand5: UITextField!
    @IBOutlet weak var digDemand6: UITextField!
    
    @IBOutlet weak var explain0: UITextField!
    @IBOutlet weak var explain1: UITextField!
    @IBOutlet weak var explain2: UITextField!
    @IBOutlet weak var explain3: UITextField!
    @IBOutlet weak var explain4: UITextField!
    @IBOutlet weak var explain5: UITextField!
    @IBOutlet weak var explain6: UITextField!
    
    @IBOutlet weak var deal0: UITextField!
    @IBOutlet weak var deal1: UITextField!
    @IBOutlet weak var deal2: UITextField!
    @IBOutlet weak var deal3: UITextField!
    @IBOutlet weak var deal4: UITextField!
    @IBOutlet weak var deal5: UITextField!
    @IBOutlet weak var deal6: UITextField!
    
    @IBOutlet weak var total0: UILabel!
    @IBOutlet weak var total1: UILabel!
    @IBOutlet weak var total2: UILabel!
    @IBOutlet weak var total3: UILabel!
    @IBOutlet weak var total4: UILabel!
    @IBOutlet weak var total5: UILabel!
    @IBOutlet weak var total6: UILabel!
    
    @IBOutlet weak var percent0: UILabel!
    @IBOutlet weak var percent1: UILabel!
    @IBOutlet weak var percent2: UILabel!
    @IBOutlet weak var percent3: UILabel!
    @IBOutlet weak var percent4: UILabel!
    @IBOutlet weak var percent5: UILabel!
    @IBOutlet weak var percent6: UILabel!
    
    
    @IBOutlet weak var date0: UILabel!
    @IBOutlet weak var date1: UILabel!
    @IBOutlet weak var date2: UILabel!
    @IBOutlet weak var date3: UILabel!
    @IBOutlet weak var date4: UILabel!
    @IBOutlet weak var date5: UILabel!
    @IBOutlet weak var date6: UILabel!
    
    @IBOutlet weak var weakTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationitem()
        
        //讓textfield連接起來，實現按return鍵就跳下一個textfield
        UITextField.connectFields(fields: [
            
            introduction0,dateSelf0, getDate0,firstFace0,digDemand0,explain0,deal0,
            
            introduction1,dateSelf1, getDate1,firstFace1,digDemand1,explain1,deal1,
            
            introduction2,dateSelf2, getDate2,firstFace2,digDemand2,explain2,deal2,
            
            introduction3,dateSelf3, getDate3,firstFace3,digDemand3,explain3,deal3,
            
            introduction4,dateSelf4, getDate4,firstFace4,digDemand4,explain4,deal4,
            
            introduction5,dateSelf5, getDate5,firstFace5,digDemand5,explain5,deal5,
            
            introduction6,dateSelf6, getDate6,firstFace6,digDemand6,explain6,deal6,
            
            
            ])
        
        
        
        
        
        appecdToString(getChooseDay: date, calToHowManyDay: CalToday(date: date))
        
        
        
        introduction0.text = scoreIntroduction[0]
        introduction1.text = scoreIntroduction[1]
        introduction2.text = scoreIntroduction[2]
        introduction3.text = scoreIntroduction[3]
        introduction4.text = scoreIntroduction[4]
        introduction5.text = scoreIntroduction[5]
        introduction6.text = scoreIntroduction[6]
        
        dateSelf0.text = scoreDateSelf[0]
        dateSelf1.text = scoreDateSelf[1]
        dateSelf2.text = scoreDateSelf[2]
        dateSelf3.text = scoreDateSelf[3]
        dateSelf4.text = scoreDateSelf[4]
        dateSelf5.text = scoreDateSelf[5]
        dateSelf6.text = scoreDateSelf[6]
        
        getDate0.text = scoreGetDate[0]
        getDate1.text = scoreGetDate[1]
        getDate2.text = scoreGetDate[2]
        getDate3.text = scoreGetDate[3]
        getDate4.text = scoreGetDate[4]
        getDate5.text = scoreGetDate[5]
        getDate6.text = scoreGetDate[6]
        
        firstFace0.text = scoreFirstFace[0]
        firstFace1.text = scoreFirstFace[1]
        firstFace2.text = scoreFirstFace[2]
        firstFace3.text = scoreFirstFace[3]
        firstFace4.text = scoreFirstFace[4]
        firstFace5.text = scoreFirstFace[5]
        firstFace6.text = scoreFirstFace[6]
        
        digDemand0.text = scoreDigDemand[0]
        digDemand1.text = scoreDigDemand[1]
        digDemand2.text = scoreDigDemand[2]
        digDemand3.text = scoreDigDemand[3]
        digDemand4.text = scoreDigDemand[4]
        digDemand5.text = scoreDigDemand[5]
        digDemand6.text = scoreDigDemand[6]
        
        explain0.text = scoreExplain[0]
        explain1.text = scoreExplain[1]
        explain2.text = scoreExplain[2]
        explain3.text = scoreExplain[3]
        explain4.text = scoreExplain[4]
        explain5.text = scoreExplain[5]
        explain6.text = scoreExplain[6]
        
        deal0.text = scoreDeal[0]
        deal1.text = scoreDeal[1]
        deal2.text = scoreDeal[2]
        deal3.text = scoreDeal[3]
        deal4.text = scoreDeal[4]
        deal5.text = scoreDeal[5]
        deal6.text = scoreDeal[6]
        
        total0.text = scoreTotal[0]
        total1.text = scoreTotal[1]
        total2.text = scoreTotal[2]
        total3.text = scoreTotal[3]
        total4.text = scoreTotal[4]
        total5.text = scoreTotal[5]
        total6.text = scoreTotal[6]
        
        percent0.text = String(describing: thePercent[0])
        percent1.text = String(describing: thePercent[1])
        percent2.text = String(describing: thePercent[2])
        percent3.text = String(describing: thePercent[3])
        percent4.text = String(describing: thePercent[4])
        percent5.text = String(describing: thePercent[5])
        percent6.text = String(describing: thePercent[6])
        
        date0.text = theDate[0]
        date1.text = theDate[1]
        date2.text = theDate[2]
        date3.text = theDate[3]
        date4.text = theDate[4]
        date5.text = theDate[5]
        date6.text = theDate[6]
        
        introduction0.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        introduction1.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        introduction2.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        introduction3.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        introduction4.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        introduction5.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        introduction6.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        introduction0.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        introduction1.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        introduction2.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        introduction3.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        introduction4.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        introduction5.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        introduction6.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        // introduction0.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        
        dateSelf0.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        dateSelf1.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        dateSelf2.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        dateSelf3.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        dateSelf4.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        dateSelf5.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        dateSelf6.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        dateSelf0.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        dateSelf1.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        dateSelf2.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        dateSelf3.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        dateSelf4.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        dateSelf5.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        dateSelf6.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        
        getDate0.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        getDate1.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        getDate2.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        getDate3.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        getDate4.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        getDate5.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        getDate6.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        getDate0.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        getDate1.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        getDate2.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        getDate3.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        getDate4.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        getDate5.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        getDate6.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        
        firstFace0.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        firstFace1.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        firstFace2.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        firstFace3.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        firstFace4.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        firstFace5.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        firstFace6.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        firstFace0.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        firstFace1.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        firstFace2.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        firstFace3.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        firstFace4.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        firstFace5.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        firstFace6.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        
        
        digDemand0.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        digDemand1.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        digDemand2.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        digDemand3.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        digDemand4.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        digDemand5.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        digDemand6.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        digDemand0.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        digDemand1.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        digDemand2.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        digDemand3.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        digDemand4.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        digDemand5.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        digDemand6.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        
        
        explain0.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        explain1.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        explain2.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        explain3.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        explain4.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        explain5.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        explain6.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        explain0.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        explain1.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        explain2.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        explain3.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        explain4.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        explain5.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        explain6.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        
        deal0.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        deal1.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        deal2.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        deal3.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        deal4.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        deal5.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        deal6.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        deal0.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        deal1.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        deal2.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        deal3.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        deal4.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        deal5.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        deal6.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        
        calScoreToTotal()
        
    }
    
    @IBAction func buildUP(_ sender: UIButton) {
        
        if introduction0.text == "" || introduction1.text == "" || introduction2.text == "" || introduction3.text == "" || introduction4.text == "" || introduction5.text == "" || introduction6.text == "" || dateSelf0.text == "" || dateSelf1.text == "" || dateSelf2.text == "" || dateSelf3.text == "" || dateSelf4.text == "" || dateSelf5.text == "" || dateSelf6.text == "" || getDate0.text == "" || getDate1.text == "" || getDate2.text == "" || getDate3.text == "" || getDate4.text == "" || getDate5.text == "" || getDate6.text == "" || firstFace0.text == "" || firstFace1.text == "" || firstFace2.text == "" || firstFace3.text == "" || firstFace4.text == "" || firstFace5.text == "" || digDemand0.text == "" || digDemand1.text == "" || digDemand2.text == "" || digDemand3.text == "" || digDemand4.text == "" || digDemand5.text == "" || digDemand6.text == "" || explain0.text == "" || explain1.text == "" || explain2.text == "" || explain3.text == "" || explain4.text == "" || explain5.text == "" || explain6.text == ""  || deal0.text == "" || deal1.text == "" || deal2.text == "" || deal3.text == "" || deal4.text == "" || deal5.text == "" || deal6.text == "" {
            
            let alertController = UIAlertController(
                title: "錯誤",
                message: "可能有空值",
                preferredStyle: .alert)
            
            // 建立[確認]按鈕
            let okAction = UIAlertAction(
                title: "確認",
                style: .default,
                handler: {
                    (action: UIAlertAction!) -> Void in
                    print("按下確認後，閉包裡的動作")
            })
            alertController.addAction(okAction)
            
            // 顯示提示框
            self.present(
                alertController,
                animated: true,
                completion: nil)
            
        }else{
            
            
            calScoreToTotal()
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}



extension scoreData{  //建立func給建立用
    func calScoreToTotal(){
        scoreIntroduction[0] = introduction0.text!
        scoreIntroduction[1] = introduction1.text!
        scoreIntroduction[2] = introduction2.text!
        scoreIntroduction[3] = introduction3.text!
        scoreIntroduction[4] = introduction4.text!
        scoreIntroduction[5] = introduction5.text!
        scoreIntroduction[6] = introduction6.text!
        
        scoreDateSelf[0] = dateSelf0.text!
        scoreDateSelf[1] = dateSelf1.text!
        scoreDateSelf[2] = dateSelf2.text!
        scoreDateSelf[3] = dateSelf3.text!
        scoreDateSelf[4] = dateSelf4.text!
        scoreDateSelf[5] = dateSelf5.text!
        scoreDateSelf[6] = dateSelf6.text!
        
        scoreGetDate[0] = getDate0.text!
        scoreGetDate[1] = getDate1.text!
        scoreGetDate[2] = getDate2.text!
        scoreGetDate[3] = getDate3.text!
        scoreGetDate[4] = getDate4.text!
        scoreGetDate[5] = getDate5.text!
        scoreGetDate[6] = getDate6.text!
        
        scoreFirstFace[0] = firstFace0.text!
        scoreFirstFace[1] = firstFace1.text!
        scoreFirstFace[2] = firstFace2.text!
        scoreFirstFace[3] = firstFace3.text!
        scoreFirstFace[4] = firstFace4.text!
        scoreFirstFace[5] = firstFace5.text!
        scoreFirstFace[6] = firstFace6.text!
        
        scoreDigDemand[0] = digDemand0.text!
        scoreDigDemand[1] = digDemand1.text!
        scoreDigDemand[2] = digDemand2.text!
        scoreDigDemand[3] = digDemand3.text!
        scoreDigDemand[4] = digDemand4.text!
        scoreDigDemand[5] = digDemand5.text!
        scoreDigDemand[6] = digDemand6.text!
        
        scoreExplain[0] = explain0.text!
        scoreExplain[1] = explain1.text!
        scoreExplain[2] = explain2.text!
        scoreExplain[3] = explain3.text!
        scoreExplain[4] = explain4.text!
        scoreExplain[5] = explain5.text!
        scoreExplain[6] = explain6.text!
        
        scoreDeal[0] = deal0.text!
        scoreDeal[1] = deal1.text!
        scoreDeal[2] = deal2.text!
        scoreDeal[3] = deal3.text!
        scoreDeal[4] = deal4.text!
        scoreDeal[5] = deal5.text!
        scoreDeal[6] = deal6.text!
        
        scoreTotal[0] = String(describing: Int(scoreIntroduction[0])!*1 + Int(scoreDateSelf[0])!*1 + Int(scoreGetDate[0])!*2 + Int(scoreFirstFace[0])!*3 + Int(scoreDigDemand[0])!*4 + Int(scoreExplain[0])!*5 + Int(scoreDeal[0])!*6 )
        scoreTotal[1] = String(describing: Int(scoreIntroduction[1])!*1 + Int(scoreDateSelf[1])!*1 + Int(scoreGetDate[1])!*2 + Int(scoreFirstFace[1])!*3 + Int(scoreDigDemand[1])!*4 + Int(scoreExplain[1])!*5 + Int(scoreDeal[1])!*6 )
        scoreTotal[2] = String(describing: Int(scoreIntroduction[2])!*1 + Int(scoreDateSelf[2])!*1 + Int(scoreGetDate[2])!*2 + Int(scoreFirstFace[2])!*3 + Int(scoreDigDemand[2])!*4 + Int(scoreExplain[2])!*5 + Int(scoreDeal[2])!*6 )
        scoreTotal[3] = String(describing: Int(scoreIntroduction[3])!*1 + Int(scoreDateSelf[3])!*1 + Int(scoreGetDate[3])!*2 + Int(scoreFirstFace[3])!*3 + Int(scoreDigDemand[3])!*4 + Int(scoreExplain[3])!*5 + Int(scoreDeal[3])!*6 )
        scoreTotal[4] = String(describing: Int(scoreIntroduction[4])!*1 + Int(scoreDateSelf[4])!*1 + Int(scoreGetDate[4])!*2 + Int(scoreFirstFace[4])!*3 + Int(scoreDigDemand[4])!*4 + Int(scoreExplain[4])!*5 + Int(scoreDeal[4])!*6 )
        scoreTotal[5] = String(describing: Int(scoreIntroduction[5])!*1 + Int(scoreDateSelf[5])!*1 + Int(scoreGetDate[5])!*2 + Int(scoreFirstFace[5])!*3 + Int(scoreDigDemand[5])!*4 + Int(scoreExplain[5])!*5 + Int(scoreDeal[5])!*6 )
        scoreTotal[6] = String(describing: Int(scoreIntroduction[6])!*1 + Int(scoreDateSelf[6])!*1 + Int(scoreGetDate[6])!*2 + Int(scoreFirstFace[6])!*3 + Int(scoreDigDemand[6])!*4 + Int(scoreExplain[6])!*5 + Int(scoreDeal[6])!*6 )
        
        thePercent[0] = Double((Int(scoreIntroduction[0])!+Int(scoreIntroduction[1])!+Int(scoreIntroduction[2])!+Int(scoreIntroduction[3])!+Int(scoreIntroduction[4])!+Int(scoreIntroduction[5])!+Int(scoreIntroduction[6])!)) / Double(20.0)
        thePercent[1] = Double((Int(scoreDateSelf[0])!+Int(scoreDateSelf[1])!+Int(scoreDateSelf[2])!+Int(scoreDateSelf[3])!+Int(scoreDateSelf[4])!+Int(scoreDateSelf[5])!+Int(scoreDateSelf[6])!)) / Double(50.0)
        thePercent[2] = Double((Int(scoreGetDate[0])!+Int(scoreGetDate[1])!+Int(scoreGetDate[2])!+Int(scoreGetDate[3])!+Int(scoreGetDate[4])!+Int(scoreGetDate[5])!+Int(scoreGetDate[6])!)) / Double(20.0)
        thePercent[3] = Double((Int(scoreFirstFace[0])!+Int(scoreFirstFace[1])!+Int(scoreFirstFace[2])!+Int(scoreFirstFace[3])!+Int(scoreFirstFace[4])!+Int(scoreFirstFace[5])!+Int(scoreFirstFace[6])!)) / Double(15.0)
        thePercent[4] = Double((Int(scoreDigDemand[0])!+Int(scoreDigDemand[1])!+Int(scoreDigDemand[2])!+Int(scoreDigDemand[3])!+Int(scoreDigDemand[4])!+Int(scoreDigDemand[5])!+Int(scoreDigDemand[6])!)) / Double(10.0)
        thePercent[5] = Double((Int(scoreExplain[0])!+Int(scoreExplain[1])!+Int(scoreExplain[2])!+Int(scoreExplain[3])!+Int(scoreExplain[4])!+Int(scoreExplain[5])!+Int(scoreExplain[6])!)) / Double(5.0)
        thePercent[6] = Double((Int(scoreDeal[0])!+Int(scoreDeal[1])!+Int(scoreDeal[2])!+Int(scoreDeal[3])!+Int(scoreDeal[4])!+Int(scoreDeal[5])!+Int(scoreDeal[6])!)) / Double(1.0)
        
        strWeakTotal = String(describing:(Int( scoreTotal[0] )! + Int( scoreTotal[1] )! + Int( scoreTotal[2] )! + Int( scoreTotal[3] )! + Int( scoreTotal[4] )! + Int( scoreTotal[5] )! + Int( scoreTotal[6] )!))
        
        percent0.text = String(thePercent[0]*100) + "%"
        percent1.text = String(thePercent[1]*100) + "%"
        percent2.text = String(thePercent[2]*100) + "%"
        percent3.text = String(thePercent[3]*100) + "%"
        percent4.text = String(thePercent[4]*100) + "%"
        percent5.text = String(thePercent[5]*100) + "%"
        percent6.text = String(thePercent[6]*100) + "%"
        
        total0.text = scoreTotal[0]
        total1.text = scoreTotal[1]
        total2.text = scoreTotal[2]
        total3.text = scoreTotal[3]
        total4.text = scoreTotal[4]
        total5.text = scoreTotal[5]
        total6.text = scoreTotal[6]
        
        weakTotal.text = strWeakTotal
        
        let appDel = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDel?.persistentContainer.viewContext  else { return }
        do{
            let result = try context.fetch(Score.fetchRequest())
            for index in result{
                let saveScore = index as? Score
                if saveScore?.todayDate == theDate[0]{
                    saveScore?.introduction = introduction0.text
                    saveScore?.dateSelf = dateSelf0.text
                    saveScore?.getDate = getDate0.text
                    saveScore?.firstFace = firstFace0.text
                    saveScore?.digDemand = digDemand0.text
                    saveScore?.explain = explain0.text
                    saveScore?.deal = deal0.text
                    
                    saveScore?.total = total0.text
                    saveScore?.percent = percent0.text
                    
                    appDel?.saveContext()
                }else if saveScore?.todayDate == theDate[1]{
                    saveScore?.introduction = introduction1.text
                    saveScore?.dateSelf = dateSelf1.text
                    saveScore?.getDate = getDate1.text
                    saveScore?.firstFace = firstFace1.text
                    saveScore?.digDemand = digDemand1.text
                    saveScore?.explain = explain1.text
                    saveScore?.deal = deal1.text
                    
                    saveScore?.total = total1.text
                    saveScore?.percent = percent1.text
                    
                    appDel?.saveContext()
                }else if saveScore?.todayDate == theDate[2]{
                    saveScore?.introduction = introduction2.text
                    saveScore?.dateSelf = dateSelf2.text
                    saveScore?.getDate = getDate2.text
                    saveScore?.firstFace = firstFace2.text
                    saveScore?.digDemand = digDemand2.text
                    saveScore?.explain = explain2.text
                    saveScore?.deal = deal2.text
                    
                    saveScore?.total = total2.text
                    saveScore?.percent = percent2.text
                    
                    appDel?.saveContext()
                }else if saveScore?.todayDate == theDate[3]{
                    saveScore?.introduction = introduction3.text
                    saveScore?.dateSelf = dateSelf3.text
                    saveScore?.getDate = getDate3.text
                    saveScore?.firstFace = firstFace3.text
                    saveScore?.digDemand = digDemand3.text
                    saveScore?.explain = explain3.text
                    saveScore?.deal = deal3.text
                    
                    saveScore?.total = total3.text
                    saveScore?.percent = percent3.text
                    
                    appDel?.saveContext()
                }else if saveScore?.todayDate == theDate[4]{
                    saveScore?.introduction = introduction4.text
                    saveScore?.dateSelf = dateSelf4.text
                    saveScore?.getDate = getDate4.text
                    saveScore?.firstFace = firstFace4.text
                    saveScore?.digDemand = digDemand4.text
                    saveScore?.explain = explain4.text
                    saveScore?.deal = deal4.text
                    
                    saveScore?.total = total4.text
                    saveScore?.percent = percent4.text
                    
                    appDel?.saveContext()
                }else if saveScore?.todayDate == theDate[5]{
                    saveScore?.introduction = introduction5.text
                    saveScore?.dateSelf = dateSelf5.text
                    saveScore?.getDate = getDate5.text
                    saveScore?.firstFace = firstFace5.text
                    saveScore?.digDemand = digDemand5.text
                    saveScore?.explain = explain5.text
                    saveScore?.deal = deal5.text
                    
                    saveScore?.total = total5.text
                    saveScore?.percent = percent5.text
                    
                    appDel?.saveContext()
                }else if saveScore?.todayDate == theDate[6]{
                    saveScore?.introduction = introduction6.text
                    saveScore?.dateSelf = dateSelf6.text
                    saveScore?.getDate = getDate6.text
                    saveScore?.firstFace = firstFace6.text
                    saveScore?.digDemand = digDemand6.text
                    saveScore?.explain = explain6.text
                    saveScore?.deal = deal6.text
                    
                    saveScore?.total = total6.text
                    saveScore?.percent = percent6.text
                    
                    appDel?.saveContext()
                }
            }
        }catch{}
    }
}

extension scoreData{  //append coredata's date to array
    func CalToday(date : Date)->Int{
        formatter.dateFormat = "c"
        let day = formatter.string(from: date)
        switch day {
        case "1" :
            return 6
        case "2" :
            return 0
        case "3" :
            return 1
        case "4" :
            return 2
        case "5" :
            return 3
        case "6" :
            return 4
        default:
            return 5
        }
    }
    
    func appecdToString(getChooseDay : Date , calToHowManyDay : Int){
        let appDel = UIApplication.shared.delegate as? AppDelegate
        guard let context =  appDel?.persistentContainer.viewContext else{ return }
        
        formatter.dateFormat = "MM月dd日"
        
        var calDate = getChooseDay
        
        var countToFuture = 1
        
        if calToHowManyDay == 6{
            for index in 0  ... calToHowManyDay-1 {
                calDate = getChooseDay.addingTimeInterval(-TimeInterval(calToHowManyDay-index+1)*24*3600)
                do{
                    let result = try context.fetch(Score.fetchRequest())
                    for item in result{
                        let catchScore = item as? Score
                        if catchScore?.todayDate == formatter.string(from: calDate){
                            scoreIntroduction[index] = (catchScore?.introduction)!
                            scoreDateSelf[index] = (catchScore?.dateSelf)!
                            scoreGetDate[index] = (catchScore?.getDate)!
                            scoreFirstFace[index] = (catchScore?.firstFace)!
                            scoreDigDemand[index] = (catchScore?.digDemand)!
                            scoreExplain[index] = (catchScore?.explain)!
                            scoreDeal[index] = (catchScore?.deal)!
                            scoreTotal[index] = (catchScore?.total)!
                            
                            theDate[index] = formatter.string(from: calDate)
                        }
                    }
                }catch{
                }
                if scoreIntroduction[index] == ""{
                    scoreIntroduction[index] = "0"
                    scoreDateSelf[index] = "0"
                    scoreGetDate[index] = "0"
                    scoreFirstFace[index] = "0"
                    scoreDigDemand[index] = "0"
                    scoreExplain[index] = "0"
                    scoreDeal[index] = "0"
                    scoreTotal[index] = "0"
                    
                    theDate[index] = formatter.string(from: calDate)
                    
                    let buildScore = Score(context : context)
                    buildScore.introduction = "0"
                    buildScore.dateSelf = "0"
                    buildScore.getDate = "0"
                    buildScore.firstFace = "0"
                    buildScore.digDemand = "0"
                    buildScore.explain = "0"
                    buildScore.deal = "0"
                    buildScore.total = "0"
                    
                    buildScore.todayDate = formatter.string(from: calDate)
                    
                    appDel?.saveContext()
                }
            }
            //append當天的數據(週日)
            calDate = getChooseDay
            do{
                let result = try context.fetch(Score.fetchRequest())
                for item in result{
                    let catchScore = item as? Score
                    if catchScore?.todayDate == formatter.string(from: calDate){
                        scoreIntroduction[calToHowManyDay] = (catchScore?.introduction)!
                        scoreDateSelf[calToHowManyDay] = (catchScore?.dateSelf)!
                        scoreGetDate[calToHowManyDay] = (catchScore?.getDate)!
                        scoreFirstFace[calToHowManyDay] = (catchScore?.firstFace)!
                        scoreDigDemand[calToHowManyDay] = (catchScore?.digDemand)!
                        scoreExplain[calToHowManyDay] = (catchScore?.explain)!
                        scoreDeal[calToHowManyDay] = (catchScore?.deal)!
                        scoreTotal[calToHowManyDay] = (catchScore?.total)!
                        
                        theDate[calToHowManyDay] = formatter.string(from: calDate)
                    }
                }
            }catch{
            }
            
            if scoreIntroduction[calToHowManyDay] == ""{
                scoreIntroduction[calToHowManyDay] = "0"
                scoreDateSelf[calToHowManyDay] = "0"
                scoreGetDate[calToHowManyDay] = "0"
                scoreFirstFace[calToHowManyDay] = "0"
                scoreDigDemand[calToHowManyDay] = "0"
                scoreExplain[calToHowManyDay] = "0"
                scoreDeal[calToHowManyDay] = "0"
                scoreTotal[calToHowManyDay] = "0"
                
                theDate[calToHowManyDay] = formatter.string(from: calDate)
                
                let buildScore = Score(context : context)
                buildScore.introduction = "0"
                buildScore.dateSelf = "0"
                buildScore.getDate = "0"
                buildScore.firstFace = "0"
                buildScore.digDemand = "0"
                buildScore.explain = "0"
                buildScore.deal = "0"
                buildScore.total = "0"
                
                buildScore.todayDate = formatter.string(from: calDate)
                
                appDel?.saveContext()
            }
        }else{
            //append當天之前的數據
            if calToHowManyDay == 0 {
                
                let index = 0
                
                calDate = getChooseDay.addingTimeInterval(-TimeInterval(calToHowManyDay-index)*24*3600)
                do{
                    let result = try context.fetch(Score.fetchRequest())
                    for item in result{
                        let catchScore = item as? Score
                        if catchScore?.todayDate == formatter.string(from: calDate){
                            scoreIntroduction[index] = (catchScore?.introduction)!
                            scoreDateSelf[index] = (catchScore?.dateSelf)!
                            scoreGetDate[index] = (catchScore?.getDate)!
                            scoreFirstFace[index] = (catchScore?.firstFace)!
                            scoreDigDemand[index] = (catchScore?.digDemand)!
                            scoreExplain[index] = (catchScore?.explain)!
                            scoreDeal[index] = (catchScore?.deal)!
                            scoreTotal[index] = (catchScore?.total)!
                            
                            theDate[index] = formatter.string(from: calDate)
                        }
                    }
                }catch{
                }
                if scoreIntroduction[index] == ""{
                    scoreIntroduction[index] = "0"
                    scoreDateSelf[index] = "0"
                    scoreGetDate[index] = "0"
                    scoreFirstFace[index] = "0"
                    scoreDigDemand[index] = "0"
                    scoreExplain[index] = "0"
                    scoreDeal[index] = "0"
                    scoreTotal[index] = "0"
                    
                    theDate[index] = formatter.string(from: calDate)
                    
                    let buildScore = Score(context : context)
                    buildScore.introduction = "0"
                    buildScore.dateSelf = "0"
                    buildScore.getDate = "0"
                    buildScore.firstFace = "0"
                    buildScore.digDemand = "0"
                    buildScore.explain = "0"
                    buildScore.deal = "0"
                    buildScore.total = "0"
                    
                    buildScore.todayDate = formatter.string(from: calDate)
                    
                    appDel?.saveContext()
                }
                
                
            }else{
                for index in 0...calToHowManyDay-1  {
                    
                    
                    calDate = getChooseDay.addingTimeInterval(-TimeInterval(calToHowManyDay-index)*24*3600)
                    do{
                        let result = try context.fetch(Score.fetchRequest())
                        for item in result{
                            let catchScore = item as? Score
                            if catchScore?.todayDate == formatter.string(from: calDate){
                                scoreIntroduction[index] = (catchScore?.introduction)!
                                scoreDateSelf[index] = (catchScore?.dateSelf)!
                                scoreGetDate[index] = (catchScore?.getDate)!
                                scoreFirstFace[index] = (catchScore?.firstFace)!
                                scoreDigDemand[index] = (catchScore?.digDemand)!
                                scoreExplain[index] = (catchScore?.explain)!
                                scoreDeal[index] = (catchScore?.deal)!
                                scoreTotal[index] = (catchScore?.total)!
                                
                                theDate[index] = formatter.string(from: calDate)
                            }
                        }
                    }catch{
                    }
                    if scoreIntroduction[index] == ""{
                        scoreIntroduction[index] = "0"
                        scoreDateSelf[index] = "0"
                        scoreGetDate[index] = "0"
                        scoreFirstFace[index] = "0"
                        scoreDigDemand[index] = "0"
                        scoreExplain[index] = "0"
                        scoreDeal[index] = "0"
                        scoreTotal[index] = "0"
                        
                        theDate[index] = formatter.string(from: calDate)
                        
                        let buildScore = Score(context : context)
                        buildScore.introduction = "0"
                        buildScore.dateSelf = "0"
                        buildScore.getDate = "0"
                        buildScore.firstFace = "0"
                        buildScore.digDemand = "0"
                        buildScore.explain = "0"
                        buildScore.deal = "0"
                        buildScore.total = "0"
                        
                        buildScore.todayDate = formatter.string(from: calDate)
                        
                        appDel?.saveContext()
                    }}
            }
            //append當天的數據
            calDate = getChooseDay
            do{
                let result = try context.fetch(Score.fetchRequest())
                for item in result{
                    let catchScore = item as? Score
                    if catchScore?.todayDate == formatter.string(from: calDate){
                        scoreIntroduction[calToHowManyDay] = (catchScore?.introduction)!
                        scoreDateSelf[calToHowManyDay] = (catchScore?.dateSelf)!
                        scoreGetDate[calToHowManyDay] = (catchScore?.getDate)!
                        scoreFirstFace[calToHowManyDay] = (catchScore?.firstFace)!
                        scoreDigDemand[calToHowManyDay] = (catchScore?.digDemand)!
                        scoreExplain[calToHowManyDay] = (catchScore?.explain)!
                        scoreDeal[calToHowManyDay] = (catchScore?.deal)!
                        scoreTotal[calToHowManyDay] = (catchScore?.total)!
                        
                        theDate[calToHowManyDay] = formatter.string(from: calDate)
                    }
                }
            }catch{
            }
            
            if scoreIntroduction[calToHowManyDay] == ""{
                scoreIntroduction[calToHowManyDay] = "0"
                scoreDateSelf[calToHowManyDay] = "0"
                scoreGetDate[calToHowManyDay] = "0"
                scoreFirstFace[calToHowManyDay] = "0"
                scoreDigDemand[calToHowManyDay] = "0"
                scoreExplain[calToHowManyDay] = "0"
                scoreDeal[calToHowManyDay] = "0"
                scoreTotal[calToHowManyDay] = "0"
                
                theDate[calToHowManyDay] = formatter.string(from: calDate)
                
                let buildScore = Score(context : context)
                buildScore.introduction = "0"
                buildScore.dateSelf = "0"
                buildScore.getDate = "0"
                buildScore.firstFace = "0"
                buildScore.digDemand = "0"
                buildScore.explain = "0"
                buildScore.deal = "0"
                buildScore.total = "0"
                
                buildScore.todayDate = formatter.string(from: calDate)
                
                appDel?.saveContext()
            }
            //append當天之後的數據
            for index in calToHowManyDay+1 ... 6 {
                calDate = getChooseDay.addingTimeInterval(TimeInterval(countToFuture)*24*3600)
                countToFuture += 1
                do{
                    let result = try context.fetch(Score.fetchRequest())
                    for item in result{
                        let catchScore = item as? Score
                        if catchScore?.todayDate == formatter.string(from: calDate){
                            scoreIntroduction[index] = (catchScore?.introduction)!
                            scoreDateSelf[index] = (catchScore?.dateSelf)!
                            scoreGetDate[index] = (catchScore?.getDate)!
                            scoreFirstFace[index] = (catchScore?.firstFace)!
                            scoreDigDemand[index] = (catchScore?.digDemand)!
                            scoreExplain[index] = (catchScore?.explain)!
                            scoreDeal[index] = (catchScore?.deal)!
                            scoreTotal[index] = (catchScore?.total)!
                            
                            theDate[index] = formatter.string(from: calDate)
                        }
                    }
                }catch{
                }
                if scoreIntroduction[index] == ""{
                    scoreIntroduction[index] = "0"
                    scoreDateSelf[index] = "0"
                    scoreGetDate[index] = "0"
                    scoreFirstFace[index] = "0"
                    scoreDigDemand[index] = "0"
                    scoreExplain[index] = "0"
                    scoreDeal[index] = "0"
                    scoreTotal[index] = "0"
                    
                    theDate[index] = formatter.string(from: calDate)
                    
                    let buildScore = Score(context : context)
                    buildScore.introduction = "0"
                    buildScore.dateSelf = "0"
                    buildScore.getDate = "0"
                    buildScore.firstFace = "0"
                    buildScore.digDemand = "0"
                    buildScore.explain = "0"
                    buildScore.deal = "0"
                    buildScore.total = "0"
                    
                    buildScore.todayDate = formatter.string(from: calDate)
                    
                    appDel?.saveContext()
                }
            }
        }
    }
}

