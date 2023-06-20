//
//  AuthenticationView.swift
//  Pyt
//
//  Created by Mauro de Oliveira  Andre on 19/05/23.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift


@MainActor
final class AuthenticationViewModel: ObservedObject{
    
}


struct AuthenticationsView: View {
    
    @Binding var showSigInView: Bool
    
    var body: some View {
        VStack {
            NavigationLink{
                SignInEmaillView(showSignInView: $showSigInView)
            }label: {
                Text("Sign In with Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.black) 
                    .cornerRadius(10)
            }
            
            //: Google
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .wide, state: .normal)){
                
            }
            
            Spacer()
        }//: VStack
        .padding()
        .navigationTitle("Sign In")
    }
}

struct AuthenticationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AuthenticationsView(showSigInView: .constant(false))
        }
    }
}
