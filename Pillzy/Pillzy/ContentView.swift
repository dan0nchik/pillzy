//
//  ContentView.swift
//  Pillzy
//
//  Created by Daniel Khromov on 4/23/20.
//  Copyright © 2020 Daniel Khromov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Spacer()
                    Image("pill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: <#T##CGFloat?#>, height: <#T##CGFloat?#>, alignment: <#T##Alignment#>)
                }
            Text("Hello, World!")
                
            .navigationBarTitle("Home")
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
