//
//  ShoppingCart.swift
//  CabifyMobileShop
//
//  Created by User on 18.06.23.
//

import Foundation

class ShoppingCart: ObservableObject {
    @Published var items: [Product] = []
    
    func addItem(_ product: Product) {
        items.append(product)
    }
    
    func removeItem(_ product: Product) {
        if let index = items.firstIndex(where: { $0.name == product.name }) {
            items.remove(at: index)
        }
    }
    
    func totalPrice() -> Double {
        items.reduce(0) { $0 + $1.price }
    }
    
}
