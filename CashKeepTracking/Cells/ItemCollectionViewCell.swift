//
//  ItemCollectionViewCell.swift
//  CashKeepTracking
//
//  Created by Admin on 28.12.2020.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    func setCell(_ item: ItemModel) {
        let cell = ItemView(item)
        
        addSubview(cell)

    }
    
}
