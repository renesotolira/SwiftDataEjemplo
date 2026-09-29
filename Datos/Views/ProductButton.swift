//
//  ProductActionButton.swift
//  Datos
//
//  Created by Rene Soto Lira on 29/09/26.
//

import SwiftUI

struct ProductButton: View {
    let title: String
    let systemImage: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: action) {
                Label( title, systemImage: systemImage )
            }
            .padding()
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(RoundedRectangle( cornerRadius: 8))
        }
    }
}

#Preview {
    ProductButton(title: "Agregar/Editar", systemImage: "plus", action: {} )
}
