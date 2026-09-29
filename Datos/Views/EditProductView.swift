//
//  ProductDetailView.swift
//  Datos
//
//  Created by MAESTRO603 on 28/09/26.
//

import SwiftUI
import SwiftData

struct EditProductView: View {
    
    @Bindable var item: Product
    
    @State private var viewModel = ProductViewModel()
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var showAlert = false
    @State private var alert: ProductAlert?
    
    var body: some View {
        
        Form {
            
            Section("Producto") {
                
                ProductView( product: item )
                
                ProductButton( title: "Guardar", systemImage: "pencil" ) {
                    let result = viewModel.updateProduct( product: item, context: modelContext )
                    alert = viewModel.alert(for: result)
                    showAlert = true
                   
                }
            }
        }
        .navigationTitle("Editar producto")
        .alert(alert?.title ?? "",isPresented: $showAlert) {
            Button("OK") { }
        } message: {
            Text(alert?.message ?? "")
        }
    }
}


#Preview {
    EditProductView(item: ProductViewModel().exampleProduct())
}
