//
//  ProductRow.swift
//  CabifyMobileShop
//
//  Created by Michèl Liebetrau on 19.06.23.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    var count: Int
    
    var body: some View {
        HStack(spacing: 20) {
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text("\(product.name)")
                    .font(.headline)
                    .bold()
                
                Text("Price: \(String(format: "%.2f", product.price)) Euro")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("Quantity: \(count)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "trash")
                .foregroundColor(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                .onTapGesture {
                    cartManager.removeFromCart(product: product)
                }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: Product(code: "VOUCHER", name: "Cabify Voucher", price: 7.50), count: 1)
    }
}
