//
//  MainTableViewCell.swift
//  maskStores
//
//  Created by 김광준 on 2020/06/18.
//  Copyright © 2020 VincentGeranium. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "MainTableViewCell"
    
    lazy var nameLabel: UILabel = {
        var name: UILabel = UILabel()
        name.backgroundColor = .systemOrange
        name.text = "Name Test String"
        return name
    }()
    
    lazy var typeLabel: UILabel = {
        var type: UILabel = UILabel()
        type.backgroundColor = .systemGray
        type.text = "Type Test String"
        return type
    }()
    
    lazy var addressLabel: UILabel = {
        var address: UILabel = UILabel()
        address.backgroundColor = .systemBlue
        address.text = "Address Test String"
        return address
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpNameLabelAndConstraint()
        setUpTypeLabelAndConstraints()
        
        
        
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
        
    }

}
