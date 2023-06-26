//
//  Product.swift
//  CabifyMobileShop
//
//  Created by Michel Liebetrau on 18.06.23.
//

import Foundation

struct Product: Identifiable, Codable {
    var id: String
    let code: String
    let name: String
    let price: Double
    let image: String
    
    init(code: String, name: String, price: Double) {
        self.id = ""
        self.name = name
        self.code = code
        self.price = price
        self.image = code.lowercased()
    }
    
}
