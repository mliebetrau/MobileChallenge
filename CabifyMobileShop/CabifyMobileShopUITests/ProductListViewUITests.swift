//
//  ProductListViewUITests.swift
//  CabifyMobileShopUITests
//
//  Created by User on 03.07.23.
//

import XCTest
@testable import CabifyMobileShop

class ProductListViewUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testProductListView_VerifyProductCards() {
        // Set up the initial data for the product list view
        let productManager = ProductManager()
        productManager.products = [
            Product(code: "1", name: "Product 1", price: 10.0),
            Product(code: "2", name: "Product 2", price: 15.0),
            Product(code: "3", name: "Product 3", price: 20.0)
        ]
        
        // Launch the ProductListView
        app.launch()
        
        // Find the product cards based on their accessibility identifiers
        let productCard1 = app.buttons["ProductCard_1"].firstMatch
        let productCard2 = app.buttons["ProductCard_2"].firstMatch
        let productCard3 = app.buttons["ProductCard_3"].firstMatch
        
        // Verify that the product cards exist
        XCTAssert(productCard1.exists)
        XCTAssert(productCard2.exists)
        XCTAssert(productCard3.exists)
    }
    
    func testProductListView_AddToCart() {
        // Set up the initial data for the product list view
        let product1 = Product(code: "1", name: "Product 1", price: 10.0)
        let product2 = Product(code: "2", name: "Product 2", price: 15.0)
        
        // Launch the ProductListView
        app.launch()
        
        // Find the add to cart button for Product 1
        let addToCartButton1 = app.buttons["AddToCartButton_1"].firstMatch
        
        // Tap the add to cart button for Product 1
        addToCartButton1.tap()
        
        // Verify that the cart manager has the correct product added
        let cartManager = CartManager.shared
        cartManager.addToCart(product: product1)
        cartManager.addToCart(product: product2)
        XCTAssertEqual(cartManager.products.count, 1)
        XCTAssertEqual(cartManager.products[0].product.name, "Product 1")
    }
    
    // Write additional tests to cover other functionalities of the ProductListView
    
}
