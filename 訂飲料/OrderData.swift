//
//  OrderData.swift
//  訂飲料
//
//  Created by ChienWen on 2018/5/17.
//  Copyright © 2018年 ChienWen. All rights reserved.
//

import Foundation

struct drinkInfo {
    var name: String
    var price: Int
}

enum SugerInfo: String{
    case regular = "正常"
    case half = "半糖"
    case less = "微糖"
    case free = "無糖"
}

enum IceInfo: String{
    case regular = "正常"
    case less = "少冰"
    case free = "去冰"
    case got = "熱"
}

struct Results: Codable {
    var name: String
    var drink: String
    var price: String
    var sugar: String
    var ice: String
}


