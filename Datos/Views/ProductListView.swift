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

    @Bindable var viewModel: ProductViewModel

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

                let filteredProducts =
                    viewModel.filteredProducts(
                        from: products
                    )

                viewModel.deleteProduct(
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
