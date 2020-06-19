//
//  ViewController.swift
//  maskStores
//
//  Created by 김광준 on 2020/06/18.
//  Copyright © 2020 VincentGeranium. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var storesDataList: [StoresDataVO] = {
        var datalist = [StoresDataVO]()
        return datalist
    }()
    
    private let mainListTableView: UITableView = {
        var tableView: UITableView = UITableView()
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.title = "공적 마스크 판매정보"
        
        mainListTableView.delegate = self
        mainListTableView.dataSource = self
        
        setUpMainListTableViewAndConstraints()
        
        // 셀 높이 동적으로 조절
//        self.mainListTableView.rowHeight = UITableView.automaticDimension
        
        // MARK: -  1) API 호출을 위한 URI 생성
        let url = "https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/stores/json?page=1&perPage=500"
        
        guard let apiURI: URL = URL(string: url) else {
            return
        }
        
        // MARK: - 2) REST API를 호출
        let apiData = try! Data(contentsOf: apiURI)
        
        // MARK: - 3) 데이터 전송 결과를 로그로 출력(not necessary code)
        let log = NSString(data: apiData, encoding: String.Encoding.utf8.rawValue) ?? ""
        NSLog("API Result = \(log)")
        
        // MARK: - 4) JSON 객체를 파싱하여 NSDictionary 객체로 받음
        do {
            guard let apiDictionary = try? JSONSerialization.jsonObject(with: apiData, options: []) as? NSDictionary else {
                return
            }
            
            // MARK: - 5) 데이터 구조에 따라 차례대로 캐스팅하며 읽어오기.
            let storeInfos = apiDictionary["storeInfos"] as? NSArray
            
            // MARK: - 6) Iterator 처리를 하면서 API 데이터를 StoresData 객체에 저장한다.
            
            guard let unWrappStoreInfos = storeInfos else {
                return
            }
            
            for row in unWrappStoreInfos {
                // 순회 상수를 NSArray 타입으로 캐스팅
                guard let r = row as? NSDictionary else {
                    return
                }
                
                // 테이블 뷰 리스트를 구성할 데이터 형식
                var storeDataVO: StoresDataVO = StoresDataVO()
                
                // storeInfos 배열의 각 데이터를 storeDataVO 상수의 속성에 대입
                storeDataVO.addr = r["addr"] as? String
                storeDataVO.name = r["name"] as? String
                storeDataVO.type = r["type"] as? String
                
                // storesDataList 배열에 추가
                self.storesDataList.append(storeDataVO)
            }
            
            
        }
    }
    
    private func setUpMainListTableViewAndConstraints() {
        let guide = self.view.safeAreaLayoutGuide
        
        mainListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(mainListTableView)
        
        NSLayoutConstraint.activate([
            mainListTableView.topAnchor.constraint(equalTo: guide.topAnchor),
            mainListTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            mainListTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            mainListTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }

    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storesDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MainTableViewCell.reuseIdentifier,
            for: indexPath) as? MainTableViewCell
            else {
                print("Error : Can't get Cell")
                fatalError()
                return UITableViewCell()
        }
        
        let stores: StoresDataVO = self.storesDataList[indexPath.row]
        
        cell.nameLabel.text = stores.name
        cell.addressLabel.text = stores.addr
        cell.typeLabel.text = stores.convertType
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}

