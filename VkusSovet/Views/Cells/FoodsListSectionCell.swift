//
//  FoodsListSectionCell.swift
//  VkusSovet
//
//  Created by Ilya on 29.09.2023.
//

import UIKit

class FoodsListSectionCell: UICollectionViewCell {
    
    static let identifier = "foods_list_cell"
    
    // MARK: - Properties
    
    private var spicyStatus: String? = nil {
        didSet {
            if (spicyStatus != nil) {
                self.setupSpicyIcon()
            }
        }
    }
    
    private var noContent: Bool = false {
        didSet {
            if (noContent) {
                reSetupPriceAndWeightStack()
            }
            }
    }
    
    // MARK: - UI Components
    
    lazy var image: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        
        return img
    }()
    
    lazy var name: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 16, weight: .bold)
        title.textAlignment = .center
        return title
    }()
    
    lazy var content: UILabel = {
        let content = UILabel()
        content.textColor = Colors.textGray
        content.font = .systemFont(ofSize: 12, weight: .medium)
        content.textAlignment = .center
        content.numberOfLines = 2
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    lazy var price: UILabel = {
        let count = UILabel()
        count.textColor = .white
        count.font = .systemFont(ofSize: 14, weight: .heavy)
        count.translatesAutoresizingMaskIntoConstraints = false
        return count
    }()
    
    lazy var weight: UILabel = {
        let weight = UILabel()
        weight.textColor = Colors.textGray
        weight.font = .systemFont(ofSize: 10, weight: .medium)
        weight.translatesAutoresizingMaskIntoConstraints = false
        return weight
    }()
    
    lazy var spicyIcon: UIImageView = {
        let spicy = UIImageView()
        spicy.image = UIImage(named: "red_pepper")
        spicy.contentMode = .scaleAspectFit
        spicy.translatesAutoresizingMaskIntoConstraints = false
        return spicy
    }()
    
    lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var button: UIButton = {
        let btt = UIButton()
        btt.backgroundColor = Colors.violet
        btt.setTitleColor(.white, for: .normal)
        btt.setTitle("В корзину", for:  .normal)
        btt.translatesAutoresizingMaskIntoConstraints = false
        btt.layer.cornerRadius = 8
        return btt
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupUI()
        layer.cornerRadius = 12
        self.noContent = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.spicyStatus = nil
        self.image.image = nil
        self.spicyIcon.removeFromSuperview()
        self.contentStack.removeFromSuperview()
        setupUI()
        self.noContent = false
    }
    
    public func configure(with food: FoodItem) {
        self.image.loadImageFromURL(urlString: food.image)
        self.name.text = food.name
        self.content.text = food.content
        if (food.content == "") { noContent = true }
        self.price.text = food.price
        if food.weight != nil {
            self.weight.text = food.weight
        } else {
            self.weight.removeFromSuperview()
        }
        self.spicyStatus = food.spicy
    }
    
    
    // MARK: - Setup UI
    
    
    private func setupUI() {
        setupContainer()
        setupButton()
    }
    
    private func reSetupPriceAndWeightStack() {
        self.contentStack.removeFromSuperview()
        containerView.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8),
            contentStack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupSpicyIcon() {
        addSubview(spicyIcon)
        
        NSLayoutConstraint.activate([
            
            spicyIcon.bottomAnchor.constraint(equalTo: image.topAnchor, constant: -8),
            spicyIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            spicyIcon.heightAnchor.constraint(equalToConstant: 24),
            spicyIcon.widthAnchor.constraint(equalToConstant: 24),
            
        ])
    }
    
    private func setupButton() {
        addSubview(button)

        NSLayoutConstraint.activate([
            
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            button.centerYAnchor.constraint(equalTo: image.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    
    private func setupContainer() {
        addSubview(containerView)
        containerView.addSubview(image)
        containerView.addSubview(name)
        containerView.addSubview(content)
        
        contentStack.addArrangedSubview(price)
        contentStack.addArrangedSubview(weight)
        containerView.addSubview(contentStack)
        
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            image.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5),
            image.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            name.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            name.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            name.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            content.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8),
            content.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            content.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            contentStack.bottomAnchor.constraint(equalTo: image.topAnchor, constant: -8),
            contentStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            
        ])
    }
}
