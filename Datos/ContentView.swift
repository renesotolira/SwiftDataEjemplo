//
//  ContentView.swift
//  Datos
//
//  Created by MAESTRO603 on 28/09/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var viewModel = ProductViewModel()
    @Environment(\.modelContext) private var modelContext
    @Query private var products: [Product]
    
    var body: some View {
        NavigationSplitView {
            VStack{
                
                AddProductView(viewModel: viewModel)
                
                List {
                    ForEach(products) { product in
                        
                        NavigationLink(destination: ProductDetailView(item: product) ){
                            Text(product.name)
                        }
                    }
                    .onDelete { offsets in
                        
                        viewModel.deleteProduct(
                            offsets: offsets,
                            products: products,
                            context: modelContext
                        )
                    }
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
            }
        } detail: {
            Text("Selecciona un Producto")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Product.self, inMemory: true)
}
