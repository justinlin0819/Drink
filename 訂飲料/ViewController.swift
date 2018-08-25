//
//  ViewController.swift
//  訂飲料
//
//  Created by ChienWen on 2018/5/17.
//  Copyright © 2018年 ChienWen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var drinkTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var suger: UISegmentedControl!
    @IBOutlet weak var ice: UISegmentedControl!
    @IBOutlet weak var senButton: UIButton!
    
    @IBAction func button_SeeResult(_ sender: Any) {
        
    }
    
    @IBAction func sentButtonPressed(_ sender: UIButton) {
        if nameTextField.text != "" && drinkTextField.text != "" {
            checkSugerAndIce()
            sendToServer()
            
            nameTextField.text = ""
            drinkTextField.text = ""
            priceTextField.text = ""
            okAlert()
        }else{
            popAlert()
        }
    }
    
    let pickerView = UIPickerView()
    
    var drinkData: [drinkInfo] = []
    var choseSuger:String?
    var choseIce:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //button圓角
        senButton.layer.cornerRadius = 6
        
        nameTextField.becomeFirstResponder()
        getDrinkTxt()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        drinkTextField.inputView = pickerView
        priceTextField.isUserInteractionEnabled = false
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return drinkData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return drinkData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        drinkTextField.text = drinkData[row].name
        priceTextField.text = "\(drinkData[row].price)"
    }
    
    //popAlert
    func popAlert(){
        let alert = UIAlertController(title: "訊息", message: "請填入完整訊息↑", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert,animated: true, completion: nil)
    }
    
    func okAlert(){
        let alert = UIAlertController(title: "訊息", message: "訂購成功↑", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert,animated: true, completion: nil)
    }
    
    
    //甜度冰塊判斷
    func checkSugerAndIce(){
        switch suger.selectedSegmentIndex {
        case 0:
            choseSuger = "正常"
        case 1:
            choseSuger = "半糖"
        case 2:
            choseSuger = "微糖"
        case 3:
            choseSuger = "無糖"
        default:
            break
        }
        
        switch ice.selectedSegmentIndex {
        case 0:
            choseIce = "正常"
        case 1:
            choseIce = "少冰"
        case 2:
            choseIce = "去冰"
        case 3:
            choseIce = "熱"
        default:
            break
        }
    }

    // 讀取txt檔
    func getDrinkTxt(){
        if let url = Bundle.main.url(forResource: "丸作食茶", withExtension: "txt"), let content = try? String(contentsOf: url){
            let listArray = content.components(separatedBy: "\n")
            for n in 0 ..< listArray.count{
                if n % 2 == 0{
                    let name = listArray[n]
                    if let price = Int(listArray[n + 1]){
                        drinkData.append(drinkInfo(name: name, price: price))
                    }
                    
                }
            }
        }
    }
    
    // 將資料傳到後台
    func sendToServer(){
        let url = URL(string: "https://sheetdb.io/api/v1/5b7a6df7ed06a")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let orderDictionary:[String: Any] = ["name": nameTextField.text!, "drink": drinkTextField.text!, "price": priceTextField.text!, "sugar": choseSuger!, "ice" : choseIce!]
        let orderData: [String: Any] = ["data": orderDictionary]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: orderData, options: []) 
            let task = URLSession.shared.uploadTask(with: urlRequest, from: data, completionHandler: { (retData, res,
                err) in
                if let returnData = retData, let dic = (try? JSONSerialization.jsonObject(with: returnData)) as? [String:String] {
                    print(dic)
                }
                
            })
            task.resume()
        }
        catch{
        }
    }
    
    @IBAction func button_Checkresult(_ sender: Any) {
        //var order_result: [Results] = []
        //var order_count = 0
        let urlStr = "https://sheetdb.io/api/v1/5b7a6df7ed06a"
        if let url = URL(string: urlStr) {
            let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
                let decoder = JSONDecoder()
                if let data = data, let order = try? decoder.decode([Results].self, from: data) {
                    /*order_result = order
                    order_count = order.count
                    print(order.count)*/
                    if let controller = self.storyboard?.instantiateViewController(withIdentifier: "result") as? Result_ViewController {
                     controller.order = order
                     self.present(controller, animated: true, completion: nil)
                     }
                    
                }
            }
            task.resume()
        }
        
        /*while order_result.count != 3 {
            
        }*/
        
        /*if let controller = self.storyboard?.instantiateViewController(withIdentifier: "result") as? Result_ViewController {
            controller.order = order_result
            self.present(controller, animated: true, completion: nil)
        }*/
    }
    
}

