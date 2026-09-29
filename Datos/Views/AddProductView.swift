//
//  AddProductView.swift
//  Datos
//
//  Created by MAESTRO603 on 28/09/26.
//

import SwiftUI
import SwiftData

struct AddProductView: View {
 /*
  @Bindable sirve para poder crear bindings ($) hacia las propiedades de un objeto observable q
  */
    @Bindable var viewModel: ProductViewModel
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        GroupBox{
            TextField("Nombre:", text: $viewModel.product.name)
            TextField("Precio:", value: $viewModel.product.price, format: .number)
                .keyboardType(.decimalPad)
            
                Button(action: {
                    viewModel.addProduct(context: modelContext)
                }) {
                    Label("Nuevo Producto", systemImage: "plus")
                }
                .padding()
                .foregroundStyle(Color.white)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    AddProductView(viewModel: ProductViewModel())
        .modelContainer(
              for: Product.self,
              inMemory: true
          )
}
