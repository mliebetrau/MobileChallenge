//
//  ProductListViewModel.swift
//  CabifyMobileShop
//
//  Created by User on 19.06.23.
//

import Foundation

class ProductListViewModel: ObservableObject {
    @Published private(set) var products: [Product] = []
    private let productManager = ProductManager.shared
    
    func fetchProducts() {
        Task {
            products = productManager.products
        }
    }
    
}
