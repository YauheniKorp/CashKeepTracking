//
//  ItemModel.swift
//  CashKeepTracking
//
//  Created by Admin on 28.12.2020.
//

import Foundation

enum MethodOfPayment: String {
    case Cash = "Cash"
    case Card = "Card"
}

struct PaymentModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: PaymentModel, rhs: PaymentModel) -> Bool {
        return lhs.dateOfPayment == rhs.dateOfPayment
    }
    
    var method: String
    var name: String
    var payment: Float
    var dateOfPayment: String
    var numberOfItem: Int
    
    var identifier: Int
    
    private static var identifierNumber = 0
    
    private static func identifierGenerator() -> Int {
        identifierNumber += 1
        return identifierNumber
    }
    
    init(method: String, name: String, payment: Float, dateOfPayment: String, numberOfItem: Int) {
        self.method = method
        self.name = name
        self.payment = payment
        self.dateOfPayment = dateOfPayment
        self.numberOfItem = numberOfItem
        self.identifier = PaymentModel.identifierGenerator()
    }
}

struct ItemModel {
    var name: String
    var imageName: String
    var sum: Float = 0.0
    var payments: [PaymentModel] = []
}




