//
//  DiscountRow.swift
//  CabifyMobileShop
//
//  Created by User on 25.06.23.
//

import SwiftUI

struct DiscountRow: View {
    @EnvironmentObject var discountManager: DiscountManager
    var discount: String
    var price: Double
    var count: Int
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "tag")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text("DISCOUNT: \(discount)")
                    .font(.headline)
                    .bold()
                
                Text("Price: \(String(format: "-%.2f", price)) Euro")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("Quantity: \(count)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
