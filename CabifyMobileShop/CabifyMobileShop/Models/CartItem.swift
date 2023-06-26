//
//  CartItem.swift
//  CabifyMobileShop
//
//  Created by Michèl Liebetrau on 19.06.23.
//

import Foundation

struct CartItem: Identifiable {
    var id: String
    var product: Product
    var count: Int
    var appliedDiscounts: [Discount]
    var totalDiscount: Double
    
    init(product: Product, count: Int) {
        self.id = UUID().uuidString
        self.product = product
        self.count = count
        self.appliedDiscounts = []
        self.totalDiscount = 0.0
    }
    
}
