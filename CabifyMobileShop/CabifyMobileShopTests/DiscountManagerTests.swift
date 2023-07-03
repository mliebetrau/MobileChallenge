//
//  DiscountManagerTests.swift
//  CabifyMobileShopTests
//
//  Created by User on 03.07.23.
//

import XCTest
@testable import CabifyMobileShop

class DiscountManagerTests: XCTestCase {
    
    var discountManager: DiscountManager!
    
    override func setUpWithError() throws {
        discountManager = DiscountManager()
    }
    
    func testCalculateDiscount_AddBuy3GetDiscount() {
        let products = [
            CartItem(product: Product(code: "TSHIRT", name: "T-Shirt", price: 10.0), count: 3)
        ]
        
        discountManager.calculateDiscount(for: products, action: "add")
        
        XCTAssertEqual(discountManager.discountData.count, 3)
        XCTAssertEqual(discountManager.totalDiscount, 3.0)
    }
    
    func testCalculateDiscount_AddBuy2GetOneFree() {
        let products = [
            CartItem(product: Product(code: "VOUCHER", name: "Voucher", price: 5.0), count: 4)
        ]
        
        discountManager.calculateDiscount(for: products, action: "add")
        
        XCTAssertEqual(discountManager.discountData.count, 2)
        XCTAssertEqual(discountManager.totalDiscount, 5.0)
    }
    
    func testCalculateDiscount_RemoveBuy3GetDiscount() {
        let products = [
            CartItem(product: Product(code: "TSHIRT", name: "T-Shirt", price: 10.0), count: 3)
        ]
        
        discountManager.calculateDiscount(for: products, action: "remove")
        
        XCTAssertEqual(discountManager.discountData.count, 0)
        XCTAssertEqual(discountManager.totalDiscount, 0.0)
    }
}
