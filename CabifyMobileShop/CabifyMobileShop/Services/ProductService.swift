//
//  ProductService.swift
//  CabifyMobileShop
//
//  Created by User on 18.06.23.
//

import Foundation
import os

class ProductService {
    static let shared = ProductService()
    
    
    private let productsKey = "com.cabify.shop.Products"
    private let baseURL = URL(string: "https://gist.githubusercontent.com/palcalde/6c19259bd32dd6aafa327fa557859c2f/raw/ba51779474a150ee4367cda4f4ffacdcca479887/Products.json")!
    
    func fetchProducts() async throws -> [Product] {
        let data = try await fetchData()
        let products = try decodeProducts(from: data)
        return products
    }
    
    private func fetchData() async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: baseURL)
        return data
    }
    
    private func decodeProducts(from data: Data) throws -> [Product] {
        let decodedResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
        let products = decodedResponse.products
        var finalProducts: [Product] = []
        
        for product in products {
            finalProducts.append(ProductMapper.mapDTOToModel(dto: product))
        }
        return finalProducts
    }
    
}
