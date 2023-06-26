//
//  ItemAmountDiscount.swift
//  CabifyMobileShop
//
//  Created by User on 25.06.23.
//

import Foundation

struct ItemAmountDiscount: Discount {
    let name: String
    let product: Product
    let discountAmount: Double

    func apply(to amount: Double, for product: Product) -> Double {
        guard product.code == self.product.code else {
            return amount
        }
        let discountedAmount = max(amount - discountAmount, 0)
        return discountedAmount
    }
}
