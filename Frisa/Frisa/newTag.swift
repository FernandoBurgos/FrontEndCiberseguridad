//
//  newTag.swift
//  Frisa
//
//  Created by Alumno on 25/09/23.
//

import SwiftUI

struct tags: Identifiable {
    var id = UUID()
    var name: String
}

struct newTag: View {
    
    @Binding var tag: String
    @Binding var tagsarr: [Tag]
    @Binding var newTag: Bool
    
    var body: some View {
        Text("Ingresa el nombre del tag")
        TextField("Nueva Etiqueta", text: $tag)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        Button{
            tagsarr.append(Tag(name: tag))
            print(tagsarr)
            tag = ""
            newTag.toggle()
        }label: {
            Text("Agregar etiqueta")
            
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    newTag(tag: .constant(""), tagsarr: .constant([]), newTag: .constant(true))
}
