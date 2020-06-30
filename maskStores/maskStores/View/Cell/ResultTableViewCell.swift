//
//  ResultTableViewCell.swift
//  maskStores
//
//  Created by 김광준 on 2020/06/26.
//  Copyright © 2020 VincentGeranium. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "ResultTableViewCell"
    
    lazy var nameLabel: UILabel = {
        var name: UILabel = UILabel()
        // 테두리 만들기
        name.layer.borderColor = UIColor.black.cgColor
        // 테두리 굵기 설정
        name.layer.borderWidth = 1.0
        name.font = UIFont.systemFont(ofSize: 17)
        name.backgroundColor = .systemOrange
        name.font = UIFont.systemFont(ofSize: 17)
        
        return name
    }()
    
    lazy var typeLabel: UILabel = {
        var type: UILabel = UILabel()
        type.layer.borderColor = UIColor.black.cgColor
        type.layer.borderWidth = 1.0
        type.textAlignment = .center
        type.backgroundColor = .systemGray
        type.font = UIFont.systemFont(ofSize: 17)
        
        return type
    }()
    
    lazy var addressLabel: UILabel = {
        var address: UILabel = UILabel()
        address.layer.borderColor = UIColor.black.cgColor
        address.layer.borderWidth = 1.0
        address.backgroundColor = .systemBlue
        address.font = UIFont.systemFont(ofSize: 17)
        
        return address
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        self.accessoryType = .disclosureIndicator
        
        setUpNameLabelAndConstraint()
        setUpTypeLabelAndConstraints()
        setUpAddressLabelAndConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUpNameLabelAndConstraint() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
        ])
    }
    
    private func setUpTypeLabelAndConstraints() {
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(typeLabel)
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            typeLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            typeLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
        ])
    }
    
    private func setUpAddressLabelAndConstraints() {
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(addressLabel)
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            addressLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
