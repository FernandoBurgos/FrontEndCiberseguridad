//
//  UserConfig.swift
//  Frisa
//
//  Created by Alumno on 28/09/23.
//

import SwiftUI

struct UserConfig: View {
    
    @State var newName: String = ""
    @Binding var name: String
    @Binding var changeName: Bool
    
    var body: some View {
        VStack{
            Text("Cambiar nombre de usuario")
                .font(.title)
            TextField("Nombre de usuario", text: $newName).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                .frame(height: 52)
                .frame(maxWidth: 327) //para que quede igual que en figma
                .padding(10)
                .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                .cornerRadius(8)
            
            Spacer()
                .frame(height: 20)
            Button{
                name = newName
                changeName.toggle()
            } label: {
                Text("Actualizar datos")
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    UserConfig(name: .constant(""), changeName: .constant(true))
}
