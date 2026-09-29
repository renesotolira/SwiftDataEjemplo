//
//  ProductDetailView.swift
//  Datos
//
//  Created by MAESTRO603 on 28/09/26.
//

import SwiftUI
import SwiftData

struct EditProductView: View {
    
    // El objeto original a editar (ya NO necesita @Bindable directo para la interfaz)
    let item: Product
    @State private var viewModel = ProductViewModel()
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss // Para cerrar la pantalla al guardar exitosamente
    
    // Objeto borrador temporal (no está en el context de SwiftData)
        @State private var draftProduct = Product(name: "", price: 0.0)
    
    @State private var showAlert = false
    @State private var alert: ProductAlert?
    
    var body: some View {
        
        Form {
            
            Section("Producto") {
                
                ProductView( product: draftProduct )
                
                ProductButton( title: "Guardar", systemImage: "pencil" ) {
                    let result = viewModel.updateProduct(
                        targetProduct: item,
                        from: draftProduct,
                        context: modelContext)
                    alert = viewModel.alert(for: result)
                    showAlert = true
                }
            }
        }
        .navigationTitle("Editar producto")
        .onAppear {
            //Cargar los datos reales en el borrador al entrar
                    draftProduct.name = item.name
                    draftProduct.price = item.price
        }
        .alert(alert?.title ?? "",isPresented: $showAlert) {
            Button("OK") {
                // Si la operación fue exitosa, cerramos la vista de edición
                if alert?.title == "Operación exitosa" {
                    dismiss()
                }
            }
        } message: {
            Text(alert?.message ?? "")
        }
    }
}


#Preview {
    EditProductView(item: ProductViewModel().exampleProduct())
}
