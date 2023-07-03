//
//  ProductManagerTests.swift
//  CabifyMobileShopTests
//
//  Created by User on 03.07.23.
//

import XCTest
@testable import CabifyMobileShop

class ProductManagerTests: XCTestCase {
    
    var productManager: ProductManager!
    
    override func setUpWithError() throws {
        productManager = ProductManager.shared
    }
    
    override func tearDown() {
        // Clear UserDefaults after each test
        UserDefaults.standard.removeObject(forKey: productManager.productsKey)
    }
    
    func testFetchProducts() async {
        // Create a mock URLSession for testing
        let mockURLSession = MockURLSession()
        
        // Create a sample product response
        let sampleProductResponse = ProductResponse(products: [ProductDTO(code: "TestProduct", name: "Test Product", price: 9.99)])
        
        // Encode the sample product response to data
        let sampleData = try! JSONEncoder().encode(sampleProductResponse)
        
        // Set the mock URLSession's data and response
        mockURLSession.data = sampleData
        mockURLSession.response = HTTPURLResponse(url: productManager.baseURL, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        // Perform the fetchProducts async function
        await productManager.fetchProducts(completion: {})
        
        // Verify that the products are fetched and stored correctly
        XCTAssertEqual(productManager.products.count, 1)
        XCTAssertEqual(productManager.products[0].name, "Test Product")
        XCTAssertEqual(productManager.products[0].price, 9.99)
    }
}

// Mock URLSession for testing
class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let task = MockURLSessionDataTask()
        task.completionHandler = { [weak self] in
            completionHandler(self?.data, self?.response, self?.error)
        }
        return task
    }
}

// Mock URLSessionDataTask for testing
class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    var completionHandler: (() -> Void)?
    
    func resume() {
        completionHandler?()
    }
}

// Protocol definitions for mocking URLSession and URLSessionDataTask
protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}
