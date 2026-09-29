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
    @State private var showAlert = false
    @State private var alert: ProductAlert?
    
    var body: some View {
        GroupBox{
            ProductView( product: viewModel.product )
            
            ProductButton( title: "Agregar", systemImage: "plus" ) {
                let result = viewModel.addProduct( context: modelContext )
                alert = viewModel.alert(for: result)
                showAlert = true
            }
        }
        .alert(alert?.title ?? "", isPresented: $showAlert) {
            Button("OK") { }
        } message: {
            Text(alert?.message ?? "")
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
