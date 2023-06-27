//
//  DiscountManager.swift
//  CabifyMobileShop
//
//  Created by Michèl Liebetrau on 25.06.23.
//

import Foundation

class DiscountManager: ObservableObject {
    @Published private(set) var totalDiscount: Double = 0.0
    @Published private(set) var discountData: [Discount] = []
    
    
    let discounts: [Discount] = [
        Discount(id: 1, title: "Buy 3 Get Discount", code: "TSHIRT", criteria: 3, discountAmount: 1.0, type: "buy3getdiscount"),
        Discount(id: 2, title: "Buy 2 Get One Free", code: "VOUCHER", criteria: 2, discountAmount: 1.0, type: "buy2get1free")
    ]
    
    func calculateDiscount(for products: [CartItem], action: String) {
        
        for item in products {
            if let discount = discounts.first(where: { $0.code == item.product.code }) {
                addDiscount(item.product, quantity: item.count, discount: discount, action: action)
            }
        }
        
        calculateTotalDiscount(products)
    }
    
    private func calculateTotalDiscount(_ products: [CartItem]) {
        var discount: Double = 0.0
        
        let discountCount = discountData.reduce(into: [:]) {
            counts, discount in
            counts[discount.code, default: 0] += 1
        }
        
        for (key, value) in discountCount {
            let find = products.first(where: { $0.product.code == key })
            if key == "VOUCHER" {
                discount += (find?.product.price ?? 0.0) * Double(value)
            } else if key == "TSHIRT" {
                let discountDate = discountData.first(where: { $0.code == key })
                discount += (discountDate?.discountAmount ?? 0.0) * Double(value)
            }
            
        }
        totalDiscount = discount
    }
    
    private func addDiscount(_ product: Product, quantity: Int, discount: Discount, action: String) {
        
        let discountCount = discountData.reduce(into: [:]) {
            counts, discount in
            counts[discount.code, default: 0] += 1
        }
        
        if discount.type == "buy3getdiscount" {
            
            if action == "add" {
                
                if product.code == discount.code {
                    
                    if quantity == discount.criteria && !discountData.contains(where: { $0.code == "TSHIRT" }) {
                        discountData.append(discount)
                        discountData.append(discount)
                        discountData.append(discount)
                    } else if quantity > discount.criteria {
                        if discountCount["TSHIRT"] != quantity {
                            discountData.append(discount)
                        }
                    }
                }
                
            } else {
                
                if quantity < discount.criteria {
                    discountData.removeAll(where: { $0.code == discount.code })
                } else {
                    if let index = discountData.firstIndex(of: discount) {
                        discountData.remove(at: index)
                    }
                }
            }
            
        } else if discount.type == "buy2get1free" {
            
            if action == "add" {
                
                if quantity >= discount.criteria {
                    let modulo = quantity % 2
                    if modulo == 0 {
                        if discountCount["VOUCHER"] ?? 0 < quantity / 2 {
                            discountData.append(discount)
                        }
                    }
                }
                
            } else {
                
                if quantity < discount.criteria {
                    discountData.removeAll(where: { $0.code == discount.code })
                } else {
                    
                    if discountCount["VOUCHER"] ?? 0 > quantity / 2 {
                        if let index = discountData.firstIndex(of: discount) {
                            discountData.remove(at: index)
                        }
                    }
                    
                }
                
            }
            
        }
    }
}
