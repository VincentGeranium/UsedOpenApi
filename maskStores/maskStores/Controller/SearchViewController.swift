//
//  FirstViewController.swift
//  maskStores
//
//  Created by 김광준 on 2020/06/25.
//  Copyright © 2020 VincentGeranium. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    let tag = 1
    // 현재까지 읽어온 테이터의 페이지 정보
    var page = 1
    // 총 페이지 정보
    let totalPage = 55
    
    //    private var searchData =
    var storesData: [StoresDataVO] = []
    lazy var filteredNameOrAddress: [StoresDataVO] = []
    
    private let searchController: UISearchController = {
        var searchController: UISearchController = UISearchController(searchResultsController: nil)
        // 기본적으로 UISearchController는 표시된 뷰를 흐리게(obscure)만든다, true와 default는 흐리게, false는 흐리지 않게.
        searchController.obscuresBackgroundDuringPresentation = false
        //        searchController.searchBar.backgroundColor = .systemPink
        searchController.searchBar.placeholder = "지역, 이름 혹은 주소를 입력하세요."
        
        return searchController
    }()
    
    private let viewForCount: UIView = {
        var countView: UIView = UIView()
        countView.backgroundColor = .systemPink
        return countView
    }()
    
    private let countLabel: UILabel = {
        var countLabel: UILabel = UILabel()
        countLabel.textAlignment = .center
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
    
    private let indicatorView: UIActivityIndicatorView = {
        var indicatorView = UIActivityIndicatorView()
        indicatorView.hidesWhenStopped = true
        indicatorView.style = .large
        indicatorView.backgroundColor = UIColor(red: 0.667, green: 0.667, blue: 0.667, alpha: 0.8)
        return indicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        indicatorView.startAnimating()
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.storesData = getAllData(self.indicatorView)
            print("Total Data Count : \(self.storesData.count)")
        }
        
        
        
        self.searchController.searchResultsUpdater = self
        self.searchResultTableView.delegate = self
        self.searchResultTableView.dataSource = self
        
        navigationItem.searchController = searchController
        
        self.definesPresentationContext = true
        
        self.title = "검색"
    
        setUpAndConstraintsCountView()
        setUpAndConstraintsCountLabel()
        setUpAndConstraintsSearchResultTableView()
        setUpAndConstraintsIndicatorView()
        
    }
    
    private func setUpAndConstraintsCountView() {
        let guide = self.view.safeAreaLayoutGuide
        
        viewForCount.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(viewForCount)
        
        NSLayoutConstraint.activate([
            viewForCount.topAnchor.constraint(equalTo: guide.topAnchor),
            viewForCount.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            viewForCount.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            viewForCount.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setUpAndConstraintsCountLabel() {
        let guide = self.viewForCount.safeAreaLayoutGuide
        
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.viewForCount.addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            countLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            countLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
//            countLabel.widthAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    private func setUpAndConstraintsSearchResultTableView() {
        let guide = self.view.safeAreaLayoutGuide
        
        searchResultTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(searchResultTableView)
        
        NSLayoutConstraint.activate([
            searchResultTableView.topAnchor.constraint(equalTo: viewForCount.bottomAnchor),
            searchResultTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            searchResultTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            searchResultTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }
    
    private func setUpAndConstraintsIndicatorView() {
        let guide = self.searchResultTableView.safeAreaLayoutGuide
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        self.searchResultTableView.addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            indicatorView.widthAnchor.constraint(equalToConstant: 100),
            indicatorView.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    
    
    private func searchBarIsEmpty() -> Bool {
        // Return true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }

    private func filterContentForSearchText(_ searchText: String) {
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
            countLabel.text = "검색 결과 : \(self.filteredNameOrAddress.count) 개"
            return filteredNameOrAddress.count
        }
        return filteredNameOrAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.reuseIdentifier, for: indexPath) as? ResultTableViewCell else {
            return UITableViewCell()
        }
        if self.searchController.isActive {
            cell.nameLabel.text = filteredNameOrAddress[indexPath.row].name
            cell.addressLabel.text = filteredNameOrAddress[indexPath.row].addr
            cell.typeLabel.text = filteredNameOrAddress[indexPath.row].convertType
        }
//        } else {
//            cell.nameLabel.text = storesData[indexPath.row].name
//            cell.addressLabel.text = storesData[indexPath.row].addr
//            cell.typeLabel.text = storesData[indexPath.row].convertType
//        }
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
