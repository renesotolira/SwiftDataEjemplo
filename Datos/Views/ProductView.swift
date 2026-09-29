//
//  ProductView.swift
//  Datos
//
//  Created by Rene Soto Lira on 29/09/26.
//

import SwiftUI

struct ProductView: View {
    @Bindable var product: Product
    var body: some View {
        VStack{
            TextField( "Nombre", text: $product.name )
            TextField( "Precio", value: $product.price, format: .number )
                .keyboardType(.decimalPad)
        }
    }
}

#Preview {
    ProductView(product: ProductViewModel().exampleProduct())
}
