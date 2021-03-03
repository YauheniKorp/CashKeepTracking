//
//  ItemView.swift
//  CashKeepTracking
//
//  Created by Admin on 28.12.2020.
//

import UIKit

class ItemView: UIView {
    
    @IBOutlet var itemContainer: UIView!
    
    @IBOutlet weak var doButton: UIButton!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    init(_ item: ItemModel) {
        super.init(frame: CGRect(x: 0, y: 0, width: 335, height: 150))
        
        Bundle.main.loadNibNamed("Item", owner: self, options: nil)
        addSubview(itemContainer)
        itemContainer.frame = self.bounds
        itemContainer.alpha = 0.8
        itemContainer.backgroundColor = .white
        itemContainer.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        itemContainer.layer.cornerRadius = 10
        
        let image = UIImage(named: item.imageName)
        nameLabel.text = item.name
        nameLabel.textColor = .black
        
        var sum = 0.0
        
        for value in item.payments {
            sum += Double(value.payment)
        }
        
        sumLabel.text = "\(sum)"
        sumLabel.textColor = .black
        doButton.setBackgroundImage(image, for: .normal)
        doButton.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


