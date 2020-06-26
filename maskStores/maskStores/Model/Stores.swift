//
//  Stores.swift
//  maskStores
//
//  Created by 김광준 on 2020/06/19.
//  Copyright © 2020 VincentGeranium. All rights reserved.
//

import Foundation

struct StoresDataVO {
    var addr: String?
    var type: String?
    var name: String?
    
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
