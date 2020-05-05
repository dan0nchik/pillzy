//
//  Login.swift
//  Pillzy
//
//  Created by Daniel Khromov on 5/6/20.
//  Copyright © 2020 Daniel Khromov. All rights reserved.
//

import SwiftUI

struct Login: View {
    
    @State var email: String = ""
    @State var pass: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    func signIn(){
        session.signIn(email: email, password: pass){
            (result, error) in
            if let error = error{
                self.error = error.localizedDescription
            }
            else{
                self.email = ""
                self.pass = ""
            }
        }
    }
    
    var body: some View {
        VStack{
        Text("Welcome back")
        TextField("Email", text: self.$email)
        SecureField("Password", text: self.$pass)
        Text(self.error)
        Button(action: signIn, label: {Text("sign in")})
        
    }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login().environmentObject(SessionStore())
    }
}
