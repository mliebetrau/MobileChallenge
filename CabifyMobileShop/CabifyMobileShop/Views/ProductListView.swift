//
//  ProductListView.swift
//  CabifyMobileShop
//
//  Created by Michèl Liebetrau on 18.06.23.
//

import SwiftUI

struct ProductListView: View {
    @StateObject var cartManager = CartManager()
    @StateObject private var productManager = ProductManager.shared
    @StateObject var discountManager = DiscountManager()
    @State private var products: [Product] = []
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(products) { product in
                        ProductCard(product: product)
                            .environmentObject(cartManager)
                            .environmentObject(productManager)
                    }
                }
                .padding()
            }
            .navigationTitle(Text("Cabify Shop"))
            .toolbar {
                NavigationLink {
                    CartView()
                        .environmentObject(cartManager)
                        .environmentObject(discountManager)
                } label: {
                    CartButton(numberOfProducts: cartManager.productAmount())
                }
            }
            .task {
                await productManager.fetchProducts {
                    products = productManager.products
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
