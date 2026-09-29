import Foundation
import SwiftData
import Observation


enum ProductOperationResult {
    case success
    case invalidData
    case saveError
}

@Observable class ProductViewModel {
    
    var product: Product
    var searchText = ""
    
    init(){
        product = Product(name: "", price: 0.0)
    }
    
    func exampleProduct() -> Product {
        Product(name: "Chocolates", price: 5)
    }
    
    func exampleListProducts() -> [Product] {
        return [
            Product(name: "Tacos", price: 10),
            Product(name: "Tamales", price: 20),
            Product(name: "Tortas", price: 30)
        ]
    }
    
    func filteredProducts( from products: [Product] ) -> [Product] { let search = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !search.isEmpty else { return products }
        
        return products.filter { $0.name.localizedCaseInsensitiveContains(search) }
    }
    
    private func validateProduct(_ product: Product) -> ( name: String, price: Float )? {
        let nombre = product.name.trimmingCharacters( in: .whitespacesAndNewlines )
        
        guard !nombre.isEmpty,
              product.price >= 0
        else {
            return nil
        }
        
        return ( name: nombre, price: product.price )
    }
    
    func addProduct(context: ModelContext) -> ProductOperationResult {
        
        guard let data = validateProduct(product)
        else {
            return .invalidData
        }
        
        let newProduct = Product(
            name: data.name,
            price: data.price
        )
        
        context.insert(newProduct)
        
        do{
            try? context.save()
            product.price = 0.0
            product.name = ""
            return .success
        }catch {
            return .saveError
        }
        
    }
    
    func updateProduct(
        product: Product,
        context: ModelContext
    ) ->  ProductOperationResult {
        guard let data = validateProduct(product)
        else {
            return .invalidData
        }
        product.name = data.name
        product.price = data.price
        do{
            try? context.save()
            return .success
        }catch {
            return .saveError
        }
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
    
    func alert(for result: ProductOperationResult) -> ProductAlert {

            switch result {

            case .success:
                return ProductAlert(
                    title: "Operación exitosa",
                    message: "Los cambios se guardaron correctamente."
                )

            case .invalidData:
                return ProductAlert(
                    title: "Datos inválidos",
                    message: "El nombre del producto no puede estar vacío y el precio no puede ser menor que 0."
                )

            case .saveError:
                return ProductAlert(
                    title: "Error",
                    message: "No se pudieron guardar los cambios."
                )
            }
        }
    
}
