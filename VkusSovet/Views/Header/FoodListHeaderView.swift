//
//  HeaderView.swift
//  VkusSovet
//
//  Created by Ilya on 29.09.2023.
//

import UIKit

class FoodListHeaderView: UICollectionReusableView {
    
    static let identifier = "header"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with title: String = "") {
        label.text = title
    }
}
