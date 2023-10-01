//
//  TestViewController.swift
//  VkusSovet
//
//  Created by Ilya on 28.09.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = CollectionViewModel()
    private var selectedIndex = 0
    
    // MARK: - UI Components
    
    lazy var collectionView: UICollectionView = {
        let compositionalLayout = createCompositionalLayout()
        compositionalLayout.configuration.interSectionSpacing = 20
        let cv = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        cv.backgroundColor = UIColor(white: 0.15, alpha: 1)
        cv.register(MenuCategoriesSectionCell.self, forCellWithReuseIdentifier: MenuCategoriesSectionCell.identifier)
        cv.register(FoodsListSectionCell.self, forCellWithReuseIdentifier: FoodsListSectionCell.identifier)
        cv.register(FoodListHeaderView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: FoodListHeaderView.identifier)
        cv.showsVerticalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgroundColor
        configureNavBar()
        viewModel.delegate = self
        setupCollectionView()
        viewModel.getCategories()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Setup UI
    
    private func configureNavBar() {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "phone"))
        
        let leftBarItem = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width * 0.3, height: 50))
        let imageLogo = UIImageView(image: UIImage(named: "vkusovet1"))
        imageLogo.contentMode = .scaleAspectFit
        imageLogo.frame = leftBarItem.bounds
        leftBarItem.addSubview(imageLogo)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarItem)
    }
    
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionID, _) -> NSCollectionLayoutSection? in
            guard let self = self else {
                return nil
            }
            return sectionID == 0 ? self.menuCategoriesLayoutSection() : self.listFoodsLayoutSection()
        }
    }
    
    private func menuCategoriesLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 3)
        group.interItemSpacing = .fixed(12)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 12
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        return section
        
    }
    
    private func listFoodsLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.65))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(16)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        section.interGroupSpacing = 44
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [headerElement]
        
        return section
    }
    
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}


// MARK: - CollectionView deleagtes realisation

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == Sections.categories.sectionID {
            return viewModel.categories.count
        } else if section == Sections.foods.sectionID {
            return viewModel.foods.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == Sections.categories.sectionID {
            setHeaderText(text: self.viewModel.categories[indexPath.row].name)
            viewModel.getFoods(for: viewModel.categories[indexPath.row])
            selectedIndex = indexPath.row
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == Sections.categories.sectionID {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCategoriesSectionCell.identifier, for: indexPath) as! MenuCategoriesSectionCell
            cell.configure(with: viewModel.categories[indexPath.row])
            
            cell.backgroundColor = selectedIndex == indexPath.row ? Colors.violet : Colors.categoryBackgroundGray
            
            return cell
            
        } else if indexPath.section == Sections.foods.sectionID {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodsListSectionCell.identifier, for: indexPath) as! FoodsListSectionCell
            cell.configure(with: viewModel.foods[indexPath.row])
            return cell
            
        } else {
            
            return UICollectionViewCell()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: FoodListHeaderView.identifier, for: indexPath) as! FoodListHeaderView
        return header
    }
    
    
}

// MARK: - CollectionViewModel delegate realisation
extension MainViewController: CollectionViewModelDelegate {
    func setHeaderText(text: String) {
        let header = collectionView.collectionViewLayout.collectionView?.visibleSupplementaryViews(ofKind: "header") [0] as! FoodListHeaderView
        header.configure(with: text)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func updateCollectionData() {
        self.collectionView.reloadData()
    }
}
