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
    
    var filteredNameOrAddress: [StoresDataVO] = []
    
    private let searchController: UISearchController = {
        var searchController: UISearchController = UISearchController(searchResultsController: nil)
        // 기본적으로 UISearchController는 표시된 뷰를 흐리게(obscure)만든다, true와 default는 흐리게, false는 흐리지 않게.
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.backgroundColor = .systemPink
        searchController.searchBar.placeholder = "이름 혹은 주소를 입력하세요."
        
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        self.definesPresentationContext = true
        self.title = "검색"
    }
    

    
    private func searchBarIsEmpty() -> Bool {
        // Return true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterContentForSearchText(_ searchText: String, _ scope: String = "All") {
        let listVC = ListViewController()
        
        filteredNameOrAddress = listVC.storesDataList.filter { (storeData: StoresDataVO) -> Bool in
            guard let name = storeData.name, let addr = storeData.addr else {
                return false
            }
            
            return name.lowercased().contains(searchText.lowercased()) && addr.lowercased().contains(searchText.lowercased())
            
            
        }
    }
    
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    
    
    
}
