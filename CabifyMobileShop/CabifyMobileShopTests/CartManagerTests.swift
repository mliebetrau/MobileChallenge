//
//  CartManagerTests.swift
//  CabifyMobileShopTests
//
//  Created by User on 03.07.23.
//

import XCTest
@testable import CabifyMobileShop

class CartManagerTests: XCTestCase {
    
    var cartManager: CartManager!

    override func setUpWithError() throws {
        cartManager = CartManager.shared
    }

    func testAddToCart() {
        // Create a sample product
        let product = Product(code: "TestProduct", name: "Test Product", price: 9.99)
        
        // Add the product to the cart
        cartManager.addToCart(product: product)
        
        // Verify that the product is added to the cart
        XCTAssertEqual(cartManager.products.count, 1)
        XCTAssertEqual(cartManager.products[0].product.code,"TestProduct")
        XCTAssertEqual(cartManager.products[0].count, 1)
    }
    
    func testRemoveFromCart() {
        // Create a sample product
        let product = Product(code: "TestProduct", name: "Test Product", price: 9.99)
        
        // Add the product to the cart
        cartManager.addToCart(product: product)
        
        // Remove the product from the cart
        cartManager.removeFromCart(product: product)
        
        // Verify that the product is removed from the cart
        XCTAssertEqual(cartManager.products.count, 0)
    }
    
    func testCalculateTotalPrice() {
        // Create sample products
        let product1 = Product(code: "TestProduct1", name: "Product 1", price: 9.99)
        let product2 = Product(code: "TestProduct2", name: "Product 2", price: 19.99)
        
        // Add products to the cart
        cartManager.addToCart(product: product1)
        cartManager.addToCart(product: product2)
        
        // Calculate the total price
        let totalPrice = cartManager.calculateTotalPrice()
        
        // Verify the total price calculation
        XCTAssertEqual(totalPrice, 29.98)
    }
}
