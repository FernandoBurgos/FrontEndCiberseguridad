//
//  UserView.swift
//  Frisa
//
//  Created by Alumno on 25/09/23.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        NavigationStack{
            VStack{
                
                Image("ProfilePlaceholder")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                List{
                    HStack{
                        Text("opcion1")
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    HStack{
                        Text("opcion2")
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    HStack{
                        Text("opcion3")
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    HStack{
                        Text("opcion4")
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    
                }
                .listStyle(.insetGrouped)
            }
        }
    }
}

#Preview {
    UserView()
}
