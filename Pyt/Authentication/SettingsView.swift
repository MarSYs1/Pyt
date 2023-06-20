//
//  SettingsView.swift
//  Pyt
//
//  Created by Mauro de Oliveira  Andre on 08/06/23.
//

import SwiftUI

@MainActor
final class SettingsViewModel:ObservableObject{
    
    
    
    func signOut() throws{
      try AuthenticationManager.shared.signOut()
    }

    func resetPassword() async throws{
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else{
            throw URLError(.fileDoesNotExist)
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updateEmail() async throws{
        let email = "mauroolivere@gmail.com"
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassword() async throws{
        let password = "hackerone832"
        try await AuthenticationManager.shared.updatePassword(password: password
        )
    }
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var mostrarSignInView: Bool
    
    var body: some View {
        List{
            Button("Log out"){
                Task{
                    do {
                        try viewModel.signOut()
                        mostrarSignInView = true
                    } catch{
                        print(error)
                    }
                }
            }
            
            Button("Reset Password"){
                Task{
                    do{
                        try await viewModel.resetPassword()
                        print("Password Reset")
                    }catch{
                        print(error)
                    }
                }
            }
            
            emailSection
            
        }//: List
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SettingsView(mostrarSignInView: .constant(false))
        }
    }
}




extension SettingsView{
    private var emailSection: some View{
        Section{
            Button("Update Passwor"){
                Task{
                    do{
                        try await viewModel.updatePassword()
                        print("Password Update")
                    }catch{
                        print(error)
                    }
                }
            } //: bottun2
            
            
            Button("Updadte Email"){
                Task{
                    do{
                        try await viewModel.updateEmail()
                        print("Email Update")
                    }catch{
                        print(error)
                    }
                }
            }//: Button
        }header: {
            Text("Email functions")
        }

    }
}
