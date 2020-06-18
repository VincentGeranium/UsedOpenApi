//
//  ViewController.swift
//  maskStores
//
//  Created by 김광준 on 2020/06/18.
//  Copyright © 2020 VincentGeranium. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private let mainListTableView: UITableView = {
        var tableView: UITableView = UITableView()
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        mainListTableView.delegate = self
        mainListTableView.dataSource = self
        
        setUpMainListTableViewAndConstraints()
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
        return 1
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
        return cell
    }
    
    
}

