//
//  favoriteView.swift
//  Frisa
//
//  Created by Alumno on 09/10/23.
//

import SwiftUI

struct favoriteView: View {
    var body: some View {
        NavigationStack{
            GeometryReader{geo in
                VStack{
                    List{
                        Text("Favorito")
                    }
                    .listStyle(.insetGrouped)
                    .frame(height: geo.size.height*12/13)
                    menuBarView()
                }
            }
        }
    }
}

#Preview {
    favoriteView()
}
