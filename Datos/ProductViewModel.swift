import Foundation
import SwiftData
import Observation

@Observable class ProductViewModel {

    var name: String = ""
    var price: String = ""

    func addProduct(context: ModelContext) {

        let nombre = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let precioTexto = price.trimmingCharacters(
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

        name = ""
        price = ""
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
