//
//  RootView.swift
//  Pyt
//
//  Created by Mauro de Oliveira  Andre on 08/06/23.
//

import SwiftUI

struct RootView: View {
    
    @State private var mostrarSignInView: Bool = false
    
    var body: some View {
        ZStack{
            NavigationStack{
                SettingsView(mostrarSignInView: $mostrarSignInView)
            }
        }
        .onAppear{
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.mostrarSignInView = authUser == nil 
        }
        .fullScreenCover(isPresented: $mostrarSignInView){
            NavigationStack{
                AuthenticationsView(showSigInView: $mostrarSignInView)
            }
        }//: full
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
