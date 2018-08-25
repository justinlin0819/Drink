//
//  Result_ViewController.swift
//  訂飲料
//
//  Created by Justin Lin on 2018/8/25.
//  Copyright © 2018年 ChienWen. All rights reserved.
//

import UIKit

class Result_ViewController: UIViewController, UITableViewDataSource {
    
    var order: [Results] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.order.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "result_cell", for: indexPath) as! Result_TableViewCell
        
        // Configure the cell...
        
        let order = self.order[indexPath.row]
        cell.label_name.text = order.name
        
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
