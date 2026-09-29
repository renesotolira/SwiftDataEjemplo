import Foundation
import SwiftData
import Observation

@Observable class ProductViewModel {

    var product: Product
    
    init(){
        product = Product(name: "", price: 0.0)
    }

    func addProduct(context: ModelContext) {

        let nombre = product.name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let precioTexto = String(product.price).trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !nombre.isEmpty,
              !precioTexto.isEmpty,
              let precio = Float(precioTexto)
        else {
            return
        }

        let newProduct = Product(
            name: nombre,
            price: precio
        )

        context.insert(newProduct)

        product.price = 0.0
        product.name = ""
    }

    func deleteProduct(
        offsets: IndexSet,
        products: [Product],
        context: ModelContext
    ) {

        for index in offsets {
            context.delete(products[index])
        }
    }
}
