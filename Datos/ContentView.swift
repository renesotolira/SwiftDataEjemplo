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
    @Query private var products: [Product]
        
    var body: some View {
        NavigationSplitView {
            VStack{
                AddProductView(viewModel: viewModel)
                
                ProductListView( products: products, viewModel: viewModel )
            }
            .padding()
            .searchable( text: $viewModel.searchText,
                         placement: .navigationBarDrawer, prompt: "Buscar producto" )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .navigationTitle("Base de Datos Local")
        } detail: {
            Text("Selecciona un Producto")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Product.self, inMemory: true)
}
