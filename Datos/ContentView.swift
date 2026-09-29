//
//  ContentView.swift
//  Datos
//
//  Created by MAESTRO603 on 28/09/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var name: String = ""
    @State var price: String = "0.0"
    @Environment(\.modelContext) private var modelContext
    @Query private var products: [Product]

    var body: some View {
        NavigationSplitView {
            VStack{
                
                GroupBox{
                    TextField("Nombre:", text: $name)
                    TextField("Precio:", text: $price)
                        Button(action: {
                            addProduct(name: name, price: price)
                        }) {
                            Label("Nuevo Producto", systemImage: "plus")
                        }
                        .padding()
                        .foregroundStyle(Color.white)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                List {
                    ForEach(products) { product in
                        
                        NavigationLink(destination: ProductDetailView(item: product) ){
                            Text(product.name)
                        }
                    }
                    .onDelete(perform: deleteProduct)
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

    private func addProduct(name: String, price: String) {
        withAnimation {
            let nombre = name.trimmingCharacters(in: .whitespacesAndNewlines)
            let newPrice = price.trimmingCharacters(in: .whitespacesAndNewlines)
            if( !nombre.isEmpty && !newPrice.isEmpty){
                print("no vacio")
                if let precio = Float(newPrice){
                    let newItem = Product(name: name, price: precio)
                    modelContext.insert(newItem)
                }
            }else{
                print("vacio")
            }
        }
    }

    private func deleteProduct(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(products[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Product.self, inMemory: true)
}
