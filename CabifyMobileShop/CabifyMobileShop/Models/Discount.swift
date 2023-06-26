//
//  Discount.swift
//  CabifyMobileShop
//
//  Created by Michèl Liebetrau on 25.06.23.
//

import Foundation

struct Discount: Equatable, Identifiable {
    var id: Int
    let title: String
    let code: String
    let criteria: Int
    let discountAmount: Double
    let type: String
}
