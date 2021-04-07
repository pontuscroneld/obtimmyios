//
//  SelfConfiguringCell.swift
//  obTimmy2
//
//  Created by Pontus Croneld on 2021-04-06.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseIdentifier : String {get}
    func configure(with shift: Shift)
}
