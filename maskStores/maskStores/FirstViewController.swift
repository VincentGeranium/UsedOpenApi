//
//  FirstViewController.swift
//  maskStores
//
//  Created by 김광준 on 2020/06/25.
//  Copyright © 2020 VincentGeranium. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    private let searchViewController: UISearchController = {
        var searchVC: UISearchController = UISearchController(searchResultsController: nil)
        searchVC.obscuresBackgroundDuringPresentation = false
        searchVC.searchBar.placeholder = "이름 혹은 주소를 입력하세요."
        
        return searchVC
    }()
    
    private let resultView: UIView = {
        var resultView: UIView = UIView()
        resultView.backgroundColor = .systemOrange
        return resultView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemOrange
        searchViewController.searchResultsUpdater = self
        // 기본적으로 UISearchController는 표시된 뷰를 흐리게(obscure)만든다, true와 default는 흐리게, false는 흐리지 않게.
//        searchViewController.obscuresBackgroundDuringPresentation = false
//        searchViewController.searchBar.placeholder = "이름 혹은 주소를 입력하세요."
        navigationItem.searchController = searchViewController
        self.definesPresentationContext = true
        setUpAndConstraintsResultView()
    }
    
    private func setUpAndConstraintsResultView() {
        let guide = self.view.safeAreaLayoutGuide
        
        resultView.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    private func searchBarIsEmpty() -> Bool {
        // Return true if the text is empty or nil
        return searchViewController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterContentForSearchText(_ searchText: String, _ scope: String = "All") {
        let listVC = ListViewController()
        
        let filteredNameOrAddress = listVC.storesDataList.filter { (storeData: StoresDataVO) -> Bool in
            guard let name = storeData.name, let addr = storeData.addr else {
                return false
            }
            
            return name.lowercased().contains(searchText.lowercased()) && addr.lowercased().contains(searchText.lowercased())
            
            
        }
    }

    
}

extension FirstViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    
    
    
    
}
