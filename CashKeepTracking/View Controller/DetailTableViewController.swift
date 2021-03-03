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
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm E, d MMM" //Your date format
//        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
//
//        //according to date format your date string
//        guard let date = dateFormatter.date(from: allMethods[1].dateOfPayment) else {
//            fatalError()
//        }
//        print(date) //Convert String to Date
        
//        var dd = [Date]()
//        for val in allMethods.indices {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "HH:mm E, d MMM" //Your date format
//            guard let date = dateFormatter.date(from: allMethods[val].dateOfPayment) else {
//                fatalError()
//            }
//            dd.append(date)
//        }
//        dd.sort(by: {$0 < $1})
//        print(dd)
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
        
        //cell.setCell(allMethods[indexPath.row], )
        cell.setCell(allMethods[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
    }
//    func deleteElement(_ arr: inout [PaymentModel], _ index: Int) -> [PaymentModel]{
//        arr.remove(at: index)
//        return arr
//    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let deleteItem = allMethods[indexPath.row]
        print(allMethods[indexPath.row])
        //var indexOfItemInArr = 0
        
        for value in arrOfItem.indices {
            for val in arrOfItem[value].payments.indices {
                print("value is \(value) val is \(val)")
                //print(arrOfItem[value].payments[val])
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
        
        
//        for value in arrOfItem{
//            var newValue = value
//            for val in newValue.payments.indices {
//                print("index is \(val)")
//                print(newValue.payments[val])
//                if newValue.payments[val] == deleteItem {
//
//                   // print(newValue.payments[val])
//                    newValue.payments.remove(at: val)
//                    createTableView(self,tableView, button)
//
////                    print(arrOfItem[indexOfItemInArr].payments[val])
////                    arrOfItem[indexOfItemInArr].payments.remove(at: val)
//            }
//
//        }
            //indexOfItemInArr += 1

        //        arrOfItem[indexPath.row].payments.remove(at: <#T##Int#>)
        //tableView.reloadData()
    //}
    }
}
