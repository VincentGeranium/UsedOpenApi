//
//  MainTapBarViewController.swift
//  maskStores
//
//  Created by 김광준 on 2020/06/26.
//  Copyright © 2020 VincentGeranium. All rights reserved.
//

import UIKit

class MainTapBarViewController: UIViewController {
    
    let searchNavi = UINavigationController.init(rootViewController: SearchViewController())
    let listNavi = UINavigationController.init(rootViewController: ListViewController())
    
    private let tab: UITabBarController = {
        var tab: UITabBarController = UITabBarController()
        return tab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTab()
    }
    
    private func setUpTab() {
        self.view.addSubview(tab.view)
        
        let listTabBarItem = UITabBarItem(title: "목록", image: UIImage.init(named: "list.png"), tag: 0)
        
        let searchTabBarItem = UITabBarItem(title: "검색", image: UIImage.init(named: "search.png"), tag: 1)
        
        searchNavi.tabBarItem = searchTabBarItem
        listNavi.tabBarItem  = listTabBarItem
        
        tab.viewControllers = [listNavi, searchNavi]
    }
}
