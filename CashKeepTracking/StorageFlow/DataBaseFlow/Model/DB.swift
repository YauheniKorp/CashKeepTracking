//
//  DB.swift
//  CashKeepTracking
//
//  Created by Admin on 20.02.2021.
//

import Foundation
import SQLite3

struct DB {
    
    static var db: OpaquePointer? = nil
    
    func openDB() -> String {
        
        let resource = "CashKeepTrackingDB"
        
        guard let dbResourcePath = Bundle.main.path(forResource: resource, ofType: "db") else {
            return "FIG_VAM"
        }
        
        let fileManager = FileManager.default
        
        do {
            let dbPath = try fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(resource + ".db")
                .path
            
            if !fileManager.fileExists(atPath: dbPath) {
                try fileManager.copyItem(atPath: dbResourcePath, toPath: dbPath)
            }
            
            guard sqlite3_open(dbPath, &DB.db) == SQLITE_OK else {
                print("error open DB \(Error.self)")
                return "error open DB on path =  \(dbPath)"
            }
            
            return "open DataBase done \(dbPath)"
        } catch {}
        
        return "error copy DB:\(dbResourcePath) in applicationSupportDirectory"
    }
    
    func closeDB() -> String{
        sqlite3_close(DB.db)
        return "Database was closed!"
    }
}


extension DB {
    func addingPaymentModel(_ paymentModel: PaymentModel) {
        
        
            let insert = "insert into PaymentModel (id, name, method, payment, date) VALUES (1, '\(paymentModel.name)', '\(paymentModel.method)', \(paymentModel.payment), '\(paymentModel.dateOfPayment)')"
            var str: OpaquePointer? = nil
            
            guard sqlite3_prepare_v2(DB.db, insert, -1, &str, nil) == SQLITE_OK,
                  sqlite3_step(str) == SQLITE_DONE
            else {
                let errmsg = String(cString: sqlite3_errmsg(DB.db)!)
                print("error preparing insert: \(errmsg): for insert: ", insert)
                return
                
            }
            sqlite3_finalize(str)
            
        
        
    }
    
    func addingItemModel() -> [ItemModel] {
        return []
    }
}
