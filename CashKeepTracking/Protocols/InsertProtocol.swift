//
//  InsertProtocol.swift
//  CashKeepTracking
//
//  Created by Admin on 22.02.2021.
//

import Foundation
import SQLite3

protocol InsertPaymentModel {
    func addingPaymentModel(_ paymentModel: PaymentModel)
    func gettingPaymentList() -> [PaymentModel]
}

extension InsertPaymentModel {
    func addingPaymentModel(_ paymentModel: PaymentModel) {
        
        
        let insert = "insert into PaymentModel (name, method, payment, date, numberOfItem) VALUES ('\(paymentModel.name)', '\(paymentModel.method)', '\(paymentModel.payment)', '\(paymentModel.dateOfPayment)', '\(paymentModel.numberOfItem)')"
        var str: OpaquePointer? = nil
        
        guard sqlite3_prepare_v2(DB.db, insert, -1, &str, nil) == SQLITE_OK,
              sqlite3_step(str) == SQLITE_DONE
        
        else {
            let errmsg = String(cString: sqlite3_errmsg(DB.db)!)
            print("error preparing insert: \(errmsg): for insert: ", insert)
            return
            
        }
        
        
        print("query \(insert) was done")
        sqlite3_finalize(str)
        
    }
    
    func addingItemModel(_ itemModel: ItemModel) {
        
        let insert = "insert into ItemModel (name, imageName) VALUES ('\(itemModel.name)', '\(itemModel.imageName)')"
        var str: OpaquePointer? = nil
        
        guard sqlite3_prepare_v2(DB.db, insert, -1, &str, nil) == SQLITE_OK,
              sqlite3_step(str) == SQLITE_DONE
        
        else {
            let errmsg = String(cString: sqlite3_errmsg(DB.db)!)
            print("error preparing insert: \(errmsg): for insert: ", insert)
            return
            
        }
        
        print("query \(insert) was done")
        sqlite3_finalize(str)
        
    }
    
    func gettingItemList() -> [ItemModel] {
        let query = "SELECT * from ItemModel"
        var str: OpaquePointer? = nil
        
        var itemModels = [ItemModel]()
        
        if sqlite3_prepare_v2(DB.db, query, -1, &str, nil) == SQLITE_OK {
            print("Query \(query) is done!")
        } else {
            print("Query \(query) is incorrect!")
        }
        
        while sqlite3_step(str) == SQLITE_ROW {
            let name = String(cString: sqlite3_column_text(str, 1))
            let imageName = String(cString: sqlite3_column_text(str, 2))
            
            itemModels.append(ItemModel(name: "\(name)", imageName: "\(imageName)"))
        }
        
        sqlite3_finalize(str)
        
        return itemModels
    }
    
    func gettingPaymentList() -> [PaymentModel] {
        let query = "SELECT * from PaymentModel"
        var str: OpaquePointer? = nil
        
        var payments = [PaymentModel]()
        
        if sqlite3_prepare_v2(DB.db, query, -1, &str, nil) == SQLITE_OK {
            print("Query \(query) is done!")
        } else {
            print("Query \(query) is incorrect!")
        }
        
        while sqlite3_step(str) == SQLITE_ROW {
            let name = String(cString: sqlite3_column_text(str, 2))
            let method = String(cString: sqlite3_column_text(str, 1))
            let payment = Float(sqlite3_column_double(str, 3))
            let date = String(cString: sqlite3_column_text(str, 4))
            let numberOfItem = (sqlite3_column_int(str, 5))
            payments.append(PaymentModel(method: "\(method)", name: "\(name)", payment: payment, dateOfPayment: date, numberOfItem: Int(numberOfItem)))
        }
        
        sqlite3_finalize(str)
        
        return payments
    }
    
    func deletePaymentList(_ date: String) {
        let query = "delete from PaymentModel where date = '\(date)'"
        var del: OpaquePointer? = nil
        
        guard sqlite3_prepare_v2(DB.db, query, -1, &del, nil) == SQLITE_OK else {
            let errmsg = String(cString: sqlite3_errmsg(DB.db)!)
            print("error prepare delete: \(errmsg)")
            return
        }
        
        guard sqlite3_step(del) == SQLITE_DONE  else {
            let errmsg = String(cString: sqlite3_errmsg(DB.db)!)
            print("error delete: \(errmsg)")
            return
        }
        
        sqlite3_finalize(del)
        print(query)
    }
}
