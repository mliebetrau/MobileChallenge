//
//  CartManager.swift
//  CabifyMobileShop
//
//  Created by Michèl Liebetrau on 19.06.23.
//

import Foundation

class CartManager: ObservableObject {
    static let shared = CartManager()
    @Published private(set) var products: [CartItem] = []
    @Published private(set) var discounts: [Discount] = []
    @Published private(set) var discountTotal: Double = 0.0
    @Published private(set) var total: Double = 0.0
    
    var discountManager: DiscountManager = DiscountManager()
    
    func addToCart(product: Product) {
        var addNewProduct = true
        for (index, item) in products.enumerated() {
            if item.product.id == product.id {
                products[index].count = products[index].count + 1
                addNewProduct = false
            }
        }
        if addNewProduct {
            products.append(CartItem(product: product, count: 1))
        }
        
        applyDiscounts(action: "add")
        calculateTotalAmount()
    }
    
    func removeFromCart(product: Product) {
        var removeOldProduct = true
        for (index, item) in products.enumerated() {
            if item.product.id == product.id && products[index].count > 1 {
                products[index].count = products[index].count - 1
                removeOldProduct = false
            }
        }
        if removeOldProduct {
            products = products.filter { $0.product.id != product.id }
        }
        applyDiscounts(action: "remove")
        calculateTotalAmount()
    }
    
    func productAmount() -> Int {
        var amount = 0
        for product in products {
            amount += product.count
        }
        return amount
    }
    
    func applyDiscounts(action: String) {
        discountManager.calculateDiscount(for: products, action: action)
    }
    
    func calculateTotalPrice() -> Double {
        return products.reduce(0.0) { $0 + ($1.product.price * Double($1.count)) }
    }
    
    func calculateTotalAmount() {
        total = calculateTotalPrice() - discountManager.totalDiscount
    }
    
}
