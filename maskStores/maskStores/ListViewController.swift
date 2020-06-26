//
//  ViewController.swift
//  maskStores
//
//  Created by 김광준 on 2020/06/18.
//  Copyright © 2020 VincentGeranium. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    let tag = 1
    
    // 현재까지 읽어온 테이터의 페이지 정보
    var page = 1
    
    // 모든 데이터의 개수
    let totalCount = 27019
    
    // 모든 페이지의 개수
    let totalPage = 55
    
    lazy var storesDataList: [StoresDataVO] = {
        var datalist = [StoresDataVO]()
        return datalist
    }()
    
    private let listTableView: UITableView = {
        var tableView: UITableView = UITableView()
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        return tableView
    }()
    
    private let viewForMoreButton: UIView = {
        var viewForBtn: UIView = UIView()
        viewForBtn.backgroundColor = .systemOrange
        return viewForBtn
    }()
    
    private let activityIndicators: UIActivityIndicatorView = {
        var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
        indicatorView.style = UIActivityIndicatorView.Style.medium
        indicatorView.hidesWhenStopped = false
        return indicatorView
    }()
    
//    lazy var moreButton: UIButton = {
//        var moreButton: UIButton = UIButton()
//        moreButton.setTitle("더보기", for: .normal)
//        moreButton.addTarget(self,
//                             action: #selector(touchUpMoreButton(_:)),
//                             for: .touchUpInside)
//        return moreButton
//    }()
//
//    @objc private func touchUpMoreButton(_ sender: UIButton) {
//        // 현재 패이지 값에 1을 추가
//        self.page += 1
//
//        // 공적 마스크 API를 호출하는 메소드.
//        callCorona19MasksAPI()
//
//        // 데이터를 다시 읽어오도록 테이블 뷰를 갱신.
//        self.mainListTableView.reloadData()
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.title = "공적 마스크 판매정보 목록"
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        setUpViewForMoreButtonAndConstraints()
        setUpMainListTableViewAndConstraints()
        setUpIndicatorAndConstraints()
//        setUpMoreButtonAndConstraints()
        
        // 셀 높이 동적으로 조절
//        self.mainListTableView.rowHeight = UITableView.automaticDimension
        
        // 공적 마스크 API를 호출해주는 메소드
        callCorona19MasksAPI()
    }
    
    // 공적 마스크 API를 호출해주는 메소드
    private func callCorona19MasksAPI() {
        // 1. 공적 마스크 API 호출을 위한 URI 생성
        let url = "https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/stores/json?page=\(self.page)&perPage=500"
        
        guard let apiURL: URL = URL(string: url) else {
            print("Error: Can't get api and url")
            return
        }
        
        // 2. REST API 호출
        let apiData = try! Data(contentsOf: apiURL)
        
        // 3. 데이터 전송 결과를 로그로 출력(not necessary code)
        let log = NSString(data: apiData, encoding: String.Encoding.utf8.rawValue) ?? ""
        NSLog("API Result = \(log)")
        
        // 4. JSON 객체를 파싱하여 NSDictionary 객체로 변환
        do {
            guard let apiDictionary = try? JSONSerialization.jsonObject(with: apiData, options: []) as? NSDictionary else {
                return
            }
            // 5. 데이터 구조에 따라 차례대로 캐스팅하며 읽어오기.
            guard let storeInfos = apiDictionary["storeInfos"] as? NSArray else {
                return
            }
            
            // 6. Iterator 처리를 하면서 API 데이터를 StoresDataVO 객체에 저장
            for row in storeInfos {
                // 순회 상수를 NSDictionary 타입으로 캐스팅
                guard let r = row as? NSDictionary else {
                    return
                }
                
                // 테이블 뷰 리스트를 구성할 데이터 형식
                var svo = StoresDataVO()
                
                // storeInfos 배열의 각 데이터를 storeDataVO 상수의 속성에 대입
                svo.addr = r["addr"] as? String
                svo.name = r["name"] as? String
                svo.type = r["type"] as? String
                
                // storesDataList 배열에 추가
                self.storesDataList.append(svo)
            }
        } catch {
            NSLog("Parse Error")
        }
    }
    
    private func setUpViewForMoreButtonAndConstraints() {
        let guide = self.view.safeAreaLayoutGuide
        
        viewForMoreButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(viewForMoreButton)
        
        NSLayoutConstraint.activate([
            viewForMoreButton.heightAnchor.constraint(equalToConstant: 50),
            viewForMoreButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            viewForMoreButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            viewForMoreButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
      }
    
    private func setUpIndicatorAndConstraints() {
        let guide = self.viewForMoreButton.safeAreaLayoutGuide
        
        activityIndicators.translatesAutoresizingMaskIntoConstraints = false
        
        self.viewForMoreButton.addSubview(activityIndicators)
        
        NSLayoutConstraint.activate([
            activityIndicators.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            activityIndicators.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
        ])
    }
    
    private func setUpMainListTableViewAndConstraints() {
        let guide = self.view.safeAreaLayoutGuide
        
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(listTableView)
        
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: guide.topAnchor),
            listTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            listTableView.bottomAnchor.constraint(equalTo: viewForMoreButton.topAnchor),
        ])
    }
    
//    private func setUpMoreButtonAndConstraints() {
//        let guide = self.viewForMoreButton.safeAreaLayoutGuide
//
//        moreButton.translatesAutoresizingMaskIntoConstraints = false
//
//        self.viewForMoreButton.addSubview(moreButton)
//
//        NSLayoutConstraint.activate([
//            moreButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
//            moreButton.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
//        ])
//    }

    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storesDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListTableViewCell.reuseIdentifier,
            for: indexPath) as? ListTableViewCell
            else {
                print("Error : Can't get Cell")
                fatalError()
                return UITableViewCell()
        }
        
        // 주어진 행에 맞는 데이터 소스를 읽어오는 코드.
        let row = self.storesDataList[indexPath.row]
        
        // 데이터 소스에 저장된 값을 각 셀에 할당.
        cell.nameLabel.text = row.name
        cell.addressLabel.text = row.addr
        cell.typeLabel.text = row.convertType
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == storesDataList.count - 1 {
            if self.page < totalPage {
                self.page += 1
                
                callCorona19MasksAPI()
                print("callCorona19MasksAPI")
                
                print(self.page)
                
                self.perform(#selector(loadData), with: nil, afterDelay: 1.0)
            }
        }
    }
    @objc func loadData() {
        listTableView.reloadData()
    }
    
}

