//
//  ProductManager.swift
//  CabifyMobileShop
//
//  Created by Michèl Liebetrau on 25.06.23.
//

import Foundation

class ProductManager: ObservableObject {
    static let shared = ProductManager()
    
    private let productsKey = "com.cabify.shop.Products"
    private let baseURL = URL(string: "https://gist.githubusercontent.com/palcalde/6c19259bd32dd6aafa327fa557859c2f/raw/ba51779474a150ee4367cda4f4ffacdcca479887/Products.json")!
    
    var products: [Product] {
        get {
            guard let data = UserDefaults.standard.data(forKey: productsKey),
                  let savedProducts = try? JSONDecoder().decode([Product].self, from: data) else {
                return []
            }
            return savedProducts
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                return
            }
            UserDefaults.standard.set(data, forKey: productsKey)
        }
    }
    
    func fetchProducts(completion: @escaping () -> Void) async {
            do {
                let (data, _) = try await URLSession.shared.data(from: baseURL)
                let fetchedProducts = try JSONDecoder().decode(ProductResponse.self, from: data)
                let products = fetchedProducts.products
                var finalProducts: [Product] = []
                for product in products {
                    finalProducts.append(ProductMapper.mapDTOToModel(dto: product))
                }
                let updatedProducts = updateProductUUIDs(for: finalProducts)
                self.products = updatedProducts
                
            } catch {
                // Introduce Error logging
            }

            completion()
        }

        private func updateProductUUIDs(for products: [Product]) -> [Product] {
            var updatedProducts = products

            // Generate or update UUID for each product
            for index in 0..<updatedProducts.count {
                let product = updatedProducts[index]
                let uniqueIdentifier = "\(product.name)-\(product.price)" // Use a unique identifier from the API response

                if let existingProduct = self.products.first(where: { $0.id == uniqueIdentifier }) {
                    updatedProducts[index] = existingProduct
                } else {
                    updatedProducts[index].id = uniqueIdentifier
                }
            }

            return updatedProducts
        }
}
