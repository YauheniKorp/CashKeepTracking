//
//  DetailTableViewCell.swift
//  CashKeepTracking
//
//  Created by Admin on 11.01.2021.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    func setCell(_ item: PaymentModel) {
        
        let methodLabel = UILabel()
        methodLabel.frame = CGRect(x: 30, y: 0, width: 110, height: 40)
        methodLabel.text = "\(item.method)"
        methodLabel.textColor = .black
        methodLabel.layer.cornerRadius = 20
        methodLabel.lineBreakMode = .byTruncatingTail
        methodLabel.adjustsFontSizeToFitWidth = true
        methodLabel.numberOfLines = 0
        switch item.method.contains("rd") {
        case true:
            methodLabel.backgroundColor = .systemGreen
        case false:
            methodLabel.backgroundColor = .systemYellow
        }
        
        let nameLabel = UILabel()
        nameLabel.frame = CGRect(x: 140, y: 0, width: 100, height: 40)
        nameLabel.text = "\(item.name)"
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.numberOfLines = 0
        
        let paymentLabel = UILabel()
        paymentLabel.frame = CGRect(x: 240, y: 0, width: 150, height: 40)
        paymentLabel.text = String(item.payment) + "р"
        paymentLabel.textAlignment = .left
        paymentLabel.textColor = .black
        
        let dateLabel = UILabel()
        dateLabel.frame = CGRect(x: 240, y: 40, width: 150, height: 30)
        dateLabel.text = item.dateOfPayment
        dateLabel.textAlignment = .left
        dateLabel.textColor = .black
        
        self.addSubview(methodLabel)
        self.addSubview(nameLabel)
        self.addSubview(paymentLabel)
        self.addSubview(dateLabel)

    }
}
