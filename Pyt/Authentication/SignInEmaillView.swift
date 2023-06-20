//
//  SignInEmaillViewModel.swift
//  Pyt
//
//  Created by Mauro de Oliveira  Andre on 19/05/23.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    
    
    func sigUp() async throws{
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or password found")
            return
        }
        try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
    
    func sigIn() async throws{
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or password found.")
            return
           }
            try await AuthenticationManager.shared.signInUser(email: email, password: password)
        
    }
}

struct SignInEmaillView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack(spacing: 20){
            
            Image("cash1")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            TextField("Digita o seu email", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.1))
            .cornerRadius(14)
            
            
            SecureField("Escreva uma palavra passe", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.1))
            .cornerRadius(14)
            
            Button {
                Task{
                    do{
                       try await viewModel.sigUp()
                        showSignInView = false
                        return
                    }catch{
                        print(error)
                    }
                    do{
                        try await viewModel.sigIn()
                        showSignInView = false
                        return
                    }catch{
                     print(error)
                    }
                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Sign In with Email")
    }
}

struct SignInEmaillView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SignInEmaillView(showSignInView: .constant(false))
        }
    }
}
