//
//  ProductListView.swift
//  Datos
//
//  Created by Rene Soto Lira on 29/09/26.
//

import SwiftUI
import SwiftData

struct ProductListView: View {
    
    let products: [Product]
    
    var viewModel: ProductViewModel
    
    @Environment(\.modelContext)
    private var modelContext
    
    var body: some View {
        
        List {
            
            ForEach(
                viewModel.filteredProducts(
                    from: products
                )
            ) { product in
                
                NavigationLink(
                    destination: EditProductView(
                        item: product
                    )
                ) {
                    Text(product.name)
                }
            }
            .onDelete { offsets in
                
                // Obtenemos la lista filtrada que el usuario está viendo actualmente
                let filteredProducts = viewModel.filteredProducts(from: products)
                
                // Ejecutamos la eliminación pasándole la lista filtrada y el contexto
                _ = viewModel.deleteProduct(
                    offsets: offsets,
                    products: filteredProducts,
                    context: modelContext
                )
            }
        }
    }
}


#Preview {
    ProductListView(
        products: ProductViewModel().exampleListProducts(),
        viewModel: ProductViewModel()
    )
}
