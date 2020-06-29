//
//  getAllData.swift
//  maskStores
//
//  Created by 김광준 on 2020/06/27.
//  Copyright © 2020 VincentGeranium. All rights reserved.
//

import Foundation
import UIKit

let totalPage = 55


//var allStoresData: [StoresDataVO] = []


func getAllData(_ indicator: UIActivityIndicatorView) -> [StoresDataVO] {
    
    var allStoresData: [StoresDataVO] = []
    
    // 1. 공적 마스크 API 호출을 위한 URI 생성
    var getAllDataURL: String = ""
    
    for i in 1...totalPage {
        getAllDataURL = "https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/stores/json?page=\(i)&perPage=500"
        
        if let apiURL: URL = URL(string: getAllDataURL) {
            
            //                return
            // 2. REST API 호출
            let apiData = try! Data(contentsOf: apiURL)
            
            // 3. 데이터 전송 결과를 로그로 출력(not necessary code)
            let log = NSString(data: apiData, encoding: String.Encoding.utf8.rawValue) ?? ""
            NSLog("API Result = \(log)")
            // 4. JSON 객체를 파싱하여 NSDictionary 객체로 변환
            do {
                if let apiDictionary = try? JSONSerialization.jsonObject(with: apiData, options: []) as? NSDictionary {
                    //                    return
                    // 5. 데이터 구조에 따라 차례대로 캐스팅하며 읽어오기.
                    if let storeInfos = apiDictionary["storeInfos"] as? NSArray {
                        
                        //                    return
                        // 6. Iterator 처리를 하면서 API 데이터를 StoresDataVO 객체에 저장
                        for row in storeInfos {
                            // 순회 상수를 NSDictionary 타입으로 캐스팅
                            if let r = row as? NSDictionary {
                                // 테이블 뷰 리스트를 구성할 데이터 형식
                                var svo = StoresDataVO()
                                
                                // storeInfos 배열의 각 데이터를 storeDataVO 상수의 속성에 대입
                                svo.addr = r["addr"] as? String
                                svo.name = r["name"] as? String
                                svo.type = r["type"] as? String
                                
                                // allStoresData 배열에 추가
                                allStoresData.append(svo)
                            }
                        }
                    }
                }
            } catch {
                NSLog("Parse Error")
            }
        } else {
            print("Error: Can't get api and url")
        }
    }
    
    DispatchQueue.main.async {
        indicator.stopAnimating()
    }
    return allStoresData
}
