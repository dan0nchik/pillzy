//
//  ContentView.swift
//  Pillzy
//
//  Created by Daniel Khromov on 4/23/20.
//  Copyright © 2020 Daniel Khromov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var showAddMed = false
    var body: some View {
        ZStack{
            Color("Background")
            
            VStack{
                HStack {
                    VStack{
                        Text("Pillzy").font(.system(.largeTitle, design: .rounded)).bold().padding(50)
                    }
                    Spacer()
                    Image("pill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                    .padding(60)
                    .clipShape(Circle())
                }
                card(with: "Nurofen", time: "15:00")
                Spacer()
            }
            VStack{
            Spacer()
            Button(action: {
                self.showAddMed.toggle()
            }) {
                Text("+")
                .foregroundColor(.gray)
                .font(.largeTitle)
                .padding(35)
                }.sheet(isPresented: $showAddMed, content: {AddPill()})
                .background(Color("Background"))
                .mask(Circle())
            .lightShadow()
            .darkShadow()
            .padding()
            }
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

extension View
{
    func lightShadow() -> some View {
        return self.shadow(color: Color("Light shadow"), radius: 8, x: -8, y: -8)
    }
    func darkShadow() -> some View {
        return self.shadow(color: Color("Dark shadow"), radius: 8, x: 8, y: 8)
    }
    
    func card(with medName: String, time: String) -> some View{
        return ZStack{
        RoundedRectangle(cornerRadius: 20)
            .fill(Color("Background"))
            .frame(width: 330, height: 120)
            .lightShadow()
            .darkShadow()
            HStack{
                Image("pill2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding(.leading, 70)
                VStack(alignment: .leading){
                Text(medName)
                    .font(.system(.largeTitle, design: .rounded)).bold().opacity(0.6)
                    .padding()
                    
                }
                
                Spacer()
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

