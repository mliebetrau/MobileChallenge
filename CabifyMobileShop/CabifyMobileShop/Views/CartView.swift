//
//  CartView.swift
//  CabifyMobileShop
//
//  Created by Michèl Liebetrau on 19.06.23.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var discountManager: DiscountManager
    
    var body: some View {
        ScrollView {
            VStack {
                if cartManager.products.isEmpty {
                    Text("Your shopping cart is empty.")
                        .font(.headline)
                        .foregroundColor(.gray)
                } else {
                    ForEach(cartManager.products, id: \.id) { product in
                        ProductRow(product: product.product, count: product.count)
                    }
                    
                    let discountCount = cartManager.discountManager.discountData.reduce(into: [:]) { counts, discount in
                        counts[discount.code, default: 0] += 1
                    }
                    
                    ForEach(Array(discountCount.sorted(by: <)), id: \.key) { (key: String, value: Int) in
                        DiscountRow(discount: key, price: calculateDiscountAmount(discountKey: key, count: value), count: value)
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Text("Total: \(cartManager.total, specifier: "%.2f Euro")")
                    .font(.headline)
                
                Spacer()
                
                Button(action: {
                    // Perform checkout action
                }) {
                    Text("Checkout")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
            }
        }
        .navigationTitle(Text("Shopping Cart"))
        .padding(.top)
    }
    
    func calculateDiscountAmount(discountKey: String, count: Int) -> Double {
        if discountKey == "VOUCHER" {
            if let product = cartManager.products.first(where: { $0.product.code == "VOUCHER" }) {
                return product.product.price * Double(count)
            }
        }
        
        return 1.00 * Double(count)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}
