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
    
    private func validateProduct(_ product: Product) -> ( name: String, price: Decimal )? {
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
            try context.save()
            product.price = 0.0
            product.name = ""
            return .success
        }catch {
            return .saveError
        }
        
    }
    
    func updateProduct(
        targetProduct: Product,
        from draftProduct: Product,
        context: ModelContext
    ) -> ProductOperationResult {
        // 1. Validar la información contenida en el producto borrador
        guard let validatedData = validateProduct(draftProduct) else {
            return .invalidData
        }
        
        // 2. Aplicar los cambios validados al producto real en la base de datos
        targetProduct.name = validatedData.name
        targetProduct.price = validatedData.price
        
        // 3. Guardar en el contexto de SwiftData
        do {
            try context.save()
            return .success
        } catch {
            return .saveError
        }
    }
    
    func deleteProduct(
        offsets: IndexSet,
        products: [Product],
        context: ModelContext
    ) -> ProductOperationResult {
        // 1. Eliminar cada elemento seleccionado según sus índices
        for index in offsets {
            guard products.indices.contains(index) else { continue }
            context.delete(products[index])
        }
        
        // 2. Guardar los cambios en el contexto de SwiftData
        do {
            try context.save()
            return .success
        } catch {
            return .saveError
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
