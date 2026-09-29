//
//  Item.swift
//  Datos
//
//  Created by MAESTRO603 on 28/09/26.
//

import Foundation
import SwiftData

@Model
final class Product {
    var name: String
    var price: Float
    
    init(name: String, price: Float) {
        self.name = name
        self.price = price
    }
}
