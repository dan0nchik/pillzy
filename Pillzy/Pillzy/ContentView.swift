//
//  ContentView.swift
//  Pillzy
//
//  Created by Daniel Khromov on 4/23/20.
//  Copyright © 2020 Daniel Khromov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var session: SessionStore
    
    func getUser(){
        session.listen()
    }
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(named: "Background")
        UITabBar.appearance().tintColor = UIColor.clear
        UITabBar.appearance().isTranslucent = false
    }

    var body: some View{
        
        Group{
            
            if session.session != nil
            {
        TabView{
            Main()
            .tabItem({
                Image(systemName: "house").font(.title)
                Text("Home")
            })
            Settings()
            .tabItem({
                Image(systemName: "person.crop.circle").font(.title)
                Text("Settings")
            })
        }
            }
            else{
                Login()
            }
        }.onAppear(perform: getUser)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}

