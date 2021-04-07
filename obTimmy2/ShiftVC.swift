//
//  ShiftVC.swift
//  obTimmy2
//
//  Created by Pontus Croneld on 2021-04-06.
//

import UIKit

class ShiftVC: UIViewController, UICollectionViewDelegate {

    var collectionView : UICollectionView!
    var datasource : UICollectionViewDiffableDataSource<Section, Shift>!
    var shiftList = [Shift]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        var addButton = UIButton()
        addButton.backgroundColor = .blue
        addButton.setTitle("Add", for: .normal)
        addButton.frame = CGRect(x: view.bounds.midX - 50, y: view.bounds.midY - 50, width: 100, height: 100)
        
        view.addSubview(addButton)
        
        collectionView.register(ShiftCell.self, forCellWithReuseIdentifier: ShiftCell.reuseIdentifier)
        
        addButton.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func pressedButton(sender: UIButton){
        print("Button pressed")
        
        let randomInt = Int.random(in: 1...1000)
        var newShift = Shift(dayOfYear: "Idag + \(randomInt)")
        shiftList.append(newShift)
        reloadData()
        print(shiftList)
        
    }
    
    func configure<T: SelfConfiguringCell>(_ celltype: T.Type, with shift: Shift, for indexPath: IndexPath) -> T {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: celltype.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(celltype)")
        }
        cell.configure(with: shift)
        return cell
    }
    
    func createDataSource(){
        datasource = UICollectionViewDiffableDataSource<Section, Shift>(collectionView: collectionView){
            collectionView, indexPath, shift in
                return self.configure(ShiftCell.self, with: shift, for: indexPath)
            }
        }
    
    func reloadData(){
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Shift>()
        snapshot.appendSections([.main])
        snapshot.appendItems(shiftList)
        datasource?.apply(snapshot)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout{
        
        let layout = UICollectionViewCompositionalLayout {
            sectionIndex, layoutEnvironment in
            let section = Section.main
            return self.createShiftTable(using: section)
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
        
    }
    
    func createShiftTable(using section: Section) -> NSCollectionLayoutSection {
        
        let itemsize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemsize)
        
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(200))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
       
        
        return layoutSection
    }
}

extension ShiftVC {
    enum Section {
        case main
    }
}

 /*
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return layoutSectionHeader
    }
  */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //let layoutSectionHeader = createSectionHeader()
    
   // layoutSection.boundarySupplementaryItems = [layoutSectionHeader]




