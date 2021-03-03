//
//  CreateTableViewProtocol.swift
//  CashKeepTracking
//
//  Created by Admin on 11.01.2021.
//

import Foundation
import UIKit

protocol CreateTableViewProtocol: UITableViewDelegate, UITableViewDataSource  {
    func createTableView(_ viewController: UIViewController, _ tableView: UITableView, _ editButton: UIButton)
}

extension CreateTableViewProtocol{
    func createTableView(_ viewController: UIViewController, _ tableView: UITableView, _ editButton: UIButton) {
        //let tableView = tableView
        let frame = CGRect(x: 0, y: 50, width: viewController.view.frame.width, height: viewController.view.frame.height)
        tableView.frame = frame
        
        editButton.frame = CGRect(x: viewController.view.frame.width - 50, y: 10, width: 40, height: 30)
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(.black, for: .normal)
        editButton.backgroundColor = .systemYellow
        editButton.layer.cornerRadius = 10
        
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.setEditing(true, animated: true)
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: "DetailCell")
        
        viewController.view.addSubview(editButton)
        viewController.view.addSubview(tableView)
    }
}
