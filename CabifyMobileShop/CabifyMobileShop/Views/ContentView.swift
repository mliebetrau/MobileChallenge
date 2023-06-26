//
//  ContentView.swift
//  CabifyMobileShop
//
//  Created by User on 19.06.23.
//

import SwiftUI

struct ContentView: View {
    @State private var index = 0
    @StateObject private var viewModel = ProductListViewModel()
    
    var body: some View {
        
        VStack {
            Text("Vouchers")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(.green)
                .cornerRadius(8)
            
            TabView(selection: $index) {
                ForEach(viewModel.products) { products in
                    Image(products.image)
                        .resizable()
                        .padding()
                        .aspectRatio(1, contentMode: .fit)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            
            HStack (spacing: 4) {
                ForEach(0 ..< 3) { i in
                    Color("primaryColor")
                        .opacity(i == index ? 1 : 0.5)
                        .frame(width: i == index ? 16 : 8, height: 8)
                        .animation(.easeInOut(duration: 0.8), value: i == index)
                }
            }
            
            ZStack {
                ForEach(viewModel.products) { product in
                    VStack {
                        Text(product.name)
                            .font(.largeTitle)
                        
                        Text("An unbelivable nice Cup for all needs")
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.top, 8)
                            .padding(.bottom)
                    }
                }
            }
            
            Button {
                
            } label: {
                Text("Get started")
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: 48)
                    .foregroundColor(.white)
                    .background(Color("primaryColor"))
                    .cornerRadius(12)
            }
            
        }
        .padding()
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
