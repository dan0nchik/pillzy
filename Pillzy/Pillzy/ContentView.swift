//
//  ContentView.swift
//  Pillzy
//
//  Created by Daniel Khromov on 4/23/20.
//  Copyright © 2020 Daniel Khromov. All rights reserved.
//

import SwiftUI
import RealmSwift



struct ContentView: View {
    init() {
        UITabBar.appearance().barTintColor = UIColor(named: "Background")
        UITabBar.appearance().tintColor = UIColor.clear
        UITabBar.appearance().isTranslucent = false
    }

    var body: some View{
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
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

