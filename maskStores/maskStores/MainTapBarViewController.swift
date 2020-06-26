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

        // Do any additional setup after loading the view.
        setUpTab()
    }
    
    private func setUpTab() {
        self.view.addSubview(tab.view)

        let searchTabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        let listTabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        searchNavi.tabBarItem = searchTabBarItem
        listNavi.tabBarItem  = listTabBarItem
        
        tab.viewControllers = [searchNavi, listNavi]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
