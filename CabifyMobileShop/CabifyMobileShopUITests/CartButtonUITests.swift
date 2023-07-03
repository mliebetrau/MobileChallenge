//
//  CartButtonUITests.swift
//  CabifyMobileShopUITests
//
//  Created by Michel Liebetrau on 03.07.23.
//

import XCTest
@testable import CabifyMobileShop

class CartButtonUITests: XCTestCase {
    
    var app: XCUIApplication!
    var cartManager: CartManager!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        cartManager = CartManager.shared
    }

    func testCartButtonWithNoProducts() throws {
        // Verify the initial state of the cart button when there are no products
        let cartButton = app.buttons["CartButton"]
        XCTAssert(cartButton.exists)
        XCTAssertFalse(cartButton.isEnabled)
        XCTAssertFalse(cartButton.isSelected)
        XCTAssert(cartButton.label == "0")
    }
    
    func testCartButtonWithProducts() throws {
        // Verify the state of the cart button when there are products
        let cartButton = app.buttons["CartButton"]
        
        // Create a sample product
        let product = Product(code: "TestProduct", name: "Test Product", price: 9.99)
        let product2 = Product(code: "TestProduct2", name: "Test Product2", price: 9.99)
        let product3 = Product(code: "TestProduct3", name: "Test Product3", price: 9.99)
        
        // Add the product to the cart
        cartManager.addToCart(product: product)
        cartManager.addToCart(product: product2)
        cartManager.addToCart(product: product3)
        
        // Assert the number of products displayed in the cart button
        XCTAssert(cartButton.label == "3")
    }
}
