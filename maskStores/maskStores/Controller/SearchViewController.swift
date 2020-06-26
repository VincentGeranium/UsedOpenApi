//
//  FirstViewController.swift
//  maskStores
//
//  Created by 김광준 on 2020/06/25.
//  Copyright © 2020 VincentGeranium. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    let tag = 0
    // 현재까지 읽어온 테이터의 페이지 정보
    var page = 1
    
    //    private var searchData =
    lazy var storesData: [StoresDataVO] = []
    lazy var filteredNameOrAddress: [StoresDataVO] = []
    
    private let searchController: UISearchController = {
        var searchController: UISearchController = UISearchController(searchResultsController: nil)
        // 기본적으로 UISearchController는 표시된 뷰를 흐리게(obscure)만든다, true와 default는 흐리게, false는 흐리지 않게.
        searchController.obscuresBackgroundDuringPresentation = false
        //        searchController.searchBar.backgroundColor = .systemPink
        searchController.searchBar.placeholder = "이름 혹은 주소를 입력하세요."
        
        return searchController
    }()
    
    private let countView: UIView = {
        var countView: UIView = UIView()
        countView.backgroundColor = .black
        return countView
    }()
    
    private let countLabel: UILabel = {
        var countLabel: UILabel = UILabel()
        countLabel.textColor = .white
        return countLabel
    }()
    
    private let searchResultTableView: UITableView = {
        var tableView: UITableView = UITableView()
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.reuseIdentifier)
        /// 테이블 뷰의 하단 빈 목록(빈 테이블 뷰 셀)이 표시되는 것을 채워주는 코드.
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.searchController.searchResultsUpdater = self
        self.searchResultTableView.delegate = self
        self.searchResultTableView.dataSource = self
        
        navigationItem.searchController = searchController
        
        self.definesPresentationContext = true
        
        self.title = "검색"
        
        callCorona19MasksAPI()
        setUpAndConstraintsCountView()
        setUpAndConstraintsCountLabel()
        setUpAndConstraintsSearchResultTableView()
        
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
                self.storesData.append(svo)
            }
        } catch {
            NSLog("Parse Error")
        }
    }
    
    private func setUpAndConstraintsCountView() {
        let guide = self.view.safeAreaLayoutGuide
        
        countView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(countView)
        
        NSLayoutConstraint.activate([
            countView.topAnchor.constraint(equalTo: guide.topAnchor),
            countView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            countView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            countView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setUpAndConstraintsCountLabel() {
        let guide = self.countView.safeAreaLayoutGuide
        
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.countView.addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            countLabel.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            countLabel.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setUpAndConstraintsSearchResultTableView() {
        let guide = self.view.safeAreaLayoutGuide
        
        searchResultTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(searchResultTableView)
        
        NSLayoutConstraint.activate([
            searchResultTableView.topAnchor.constraint(equalTo: countView.bottomAnchor),
            searchResultTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            searchResultTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            searchResultTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }
    
    
    
    private func searchBarIsEmpty() -> Bool {
        // Return true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterContentForSearchText(_ searchText: String, _ scope: String = "All") {
        self.filteredNameOrAddress = self.storesData.filter { (storesData: StoresDataVO) -> Bool in
            guard let name = storesData.name, let addr = storesData.addr else {
                return false
            }
            return name.contains(searchText) || addr.contains(searchText)
        }
        self.searchResultTableView.reloadData()
    }
    
    
}

extension SearchViewController: UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchController.isActive {
            countLabel.text = "\(filteredNameOrAddress.count)"
            return filteredNameOrAddress.count
        }
        countLabel.text = "\(storesData.count)"
        return storesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.reuseIdentifier, for: indexPath) as? ResultTableViewCell else {
            return UITableViewCell()
        }
        if self.searchController.isActive {
            cell.nameLabel.text = filteredNameOrAddress[indexPath.row].name
            cell.addressLabel.text = filteredNameOrAddress[indexPath.row].addr
            cell.typeLabel.text = filteredNameOrAddress[indexPath.row].convertType
        } else {
            cell.nameLabel.text = storesData[indexPath.row].name
            cell.addressLabel.text = storesData[indexPath.row].addr
            cell.typeLabel.text = storesData[indexPath.row].convertType
        }
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    
    
    
}
