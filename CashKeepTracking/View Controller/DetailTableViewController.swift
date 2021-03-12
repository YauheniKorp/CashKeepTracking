//
//  DetailTableViewController.swift
//  CashKeepTracking
//
//  Created by Admin on 11.01.2021.
//

import UIKit

class DetailTableViewController: UIViewController, CreateTableViewProtocol {
    
    var button = UIButton()
    var tableView = UITableView()
    var allMethods = [PaymentModel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allMethods.removeAll()
        
        for value in arrOfItem.indices {
            allMethods.append(contentsOf: arrOfItem[value].payments)
            
        }
        
        allMethods.sort (by: { $0.dateOfPayment > $1.dateOfPayment})
        button.addTarget(self, action: #selector(rightBarButtonItemTapped), for: .touchUpInside)
        createTableView(self,tableView, button)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(rightBarButtonItemTapped))
        
        
    }
    
    @objc func rightBarButtonItemTapped(_ sender: UIBarButtonItem) {
        
        tableView.isEditing ? tableView.setEditing(false, animated: true) : tableView.setEditing(true, animated: true)
        
    }
}

extension DetailTableViewController: UITableViewDelegate, UITableViewDataSource, InsertPaymentModel {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allMethods.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell
        
        guard allMethods.first != nil else {
            return cell
        }
        
        cell.setCell(allMethods[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let deleteItem = allMethods[indexPath.row]
        
        for value in arrOfItem.indices {
            for val in arrOfItem[value].payments.indices {
                if arrOfItem[value].payments[val] == deleteItem {
                    arrOfItem[value].payments.remove(at: val)
                    allMethods.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .left)
                    deletePaymentList(deleteItem.dateOfPayment)
                    tableView.reloadData()
                    return
                }
            }
        }
    }
}
