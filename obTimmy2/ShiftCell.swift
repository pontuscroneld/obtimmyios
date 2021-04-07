//
//  ShiftCell.swift
//  obTimmy2
//
//  Created by Pontus Croneld on 2021-04-06.
//

import Foundation
import UIKit

class ShiftCell: UICollectionViewCell, SelfConfiguringCell {
    
    func configure(with shift: Shift) {
        info.text = shift.dayOfYear
    }
    
    
    static let reuseIdentifier = "ShiftCell"
    
    let info = UILabel()
    //let trashButton = UIButton
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        info.font = UIFont.preferredFont(forTextStyle: .title2)
        info.textColor = .label

        let stackView = UIStackView(arrangedSubviews: [info])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 20
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
