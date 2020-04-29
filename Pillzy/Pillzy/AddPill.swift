//
//  AddPill.swift
//  Pillzy
//
//  Created by Daniel Khromov on 4/29/20.
//  Copyright © 2020 Daniel Khromov. All rights reserved.
//

import SwiftUI

struct AddPill: View {
    var body: some View {
        ZStack{
        Color("Background")
            .edgesIgnoringSafeArea(.all)
            VStack {
              Text("Add").font(.system(.largeTitle, design: .rounded)).bold().padding()
            Text("Pills name")
            
            Spacer()
        }
        }
    }
}

struct AddPill_Previews: PreviewProvider {
    static var previews: some View {
        AddPill()
    }
}
