//
//  ProductMapper.swift
//  CabifyMobileShop
//
//  Created by Michèl Liebetrau on 18.06.23.
//

import Foundation

struct ProductMapper {
    static func mapDTOToModel(dto: ProductDTO) -> Product {
        let name = dto.name
        let code = dto.code
        let price = dto.price
        
        return Product(code: code, name: name, price: price)
    }
}
