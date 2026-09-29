//
//  ProductDetailView.swift
//  Datos
//
//  Created by MAESTRO603 on 28/09/26.
//

import SwiftUI

struct ProductDetailView: View {
    let item: Product
    var body: some View {
        HStack{
            Text("\(item.name)")
            Spacer()
            Text("\(item.price.formatted(.number))")
        }.padding()
    }
}

#Preview {
    ProductDetailView(item: Product(name: "----", price: 120.50))
}
