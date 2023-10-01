//
//  MenuCategoriesCollectionViewCell.swift
//  VkusSovet
//
//  Created by Ilya on 28.09.2023.
//

import UIKit

class MenuCategoriesSectionCell: UICollectionViewCell {
    static let identifier = "menu_categories_cell"
    
    // MARK: - UI Components
    
    lazy var image: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        
        return img
    }()
    
    lazy var title: UILabel = {
       let title = UILabel()
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 14, weight: .bold)
        title.textAlignment = .center
        return title
    }()
    
    lazy var countItems: UILabel = {
       let count = UILabel()
        count.textColor = Colors.textGray
        count.font = .systemFont(ofSize: 12, weight: .medium)
        count.textAlignment = .center
        count.translatesAutoresizingMaskIntoConstraints = false
        return count
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.categoryBackgroundGray
        setupUI()
        layer.masksToBounds = true
        layer.cornerRadius = 12
        setupSelectionColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.image.image = nil
    }
    
    
    public func configure(with category: CategoryItem) {
        self.image.loadImageFromURL(urlString: category.image)
        self.title.text = category.name
        self.countItems.text = "\(category.subMenuCount) товаров"
    }
    
    // MARK: - SetupUI
    
    private func setupSelectionColor() {
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor =  Colors.violet
        self.selectedBackgroundView = selectedBackgroundView
    }
    
    
    private func setupUI() {
        addSubview(image)
        addSubview(title)
        addSubview(countItems)
        
        
        NSLayoutConstraint.activate([
        
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 14),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            countItems.centerXAnchor.constraint(equalTo: centerXAnchor),
            countItems.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 14),
            countItems.leadingAnchor.constraint(equalTo: leadingAnchor),
            countItems.trailingAnchor.constraint(equalTo: trailingAnchor),
        
        ])
    }
}
