//
//  ProductRowUITests.swift
//  CabifyMobileShopUITests
//
//  Created by User on 03.07.23.
//

import XCTest
@testable import CabifyMobileShop

class ProductRowUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testProductRow_DeleteButton_RemovesFromCart() {
        // Add a product to the cart
        let product = Product(code: "ABC123", name: "Sample Product", price: 9.99)
        let cartManager = CartManager.shared
        cartManager.addToCart(product: product)
        
        // Launch the view containing the ProductRow
        app.launch()
        
        // Find the ProductRow view based on the product name
        let productRow = app.tables.cells.staticTexts[product.name].firstMatch
        
        // Verify that the product is displayed with the correct details
        XCTAssert(productRow.exists)
        XCTAssert(app.staticTexts[product.name].exists)
        XCTAssert(app.staticTexts["Price: \(String(format: "%.2f", product.price)) Euro"].exists)
        XCTAssert(app.staticTexts["Quantity: \(cartManager.products.count)"].exists)
        
        // Tap the delete button in the ProductRow
        let deleteButton = productRow.buttons["trash"]
        deleteButton.tap()
        
        // Verify that the product is removed from the cart
        XCTAssertFalse(cartManager.products.contains(where: { $0.product.name == product.name}))
    }
}
