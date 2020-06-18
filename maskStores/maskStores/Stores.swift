//
//  Stores.swift
//  maskStores
//
//  Created by 김광준 on 2020/06/19.
//  Copyright © 2020 VincentGeranium. All rights reserved.
//

import Foundation

struct APIResponse: Codable {
    let storeInfos: [StoresData]
}

struct StoresData: Codable {
    let addr: String
    let type: String
    let name: String
    
    var convertType: String {
        if self.type == "01" {
            return "약국"
        } else if self.type == "02" {
            return "우체국"
        } else if self.type == "03" {
            return "농협"
        } else {
            return "알 수 없음"
        }
    }
}
