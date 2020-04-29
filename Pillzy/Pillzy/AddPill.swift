//
//  AddPill.swift
//  Pillzy
//
//  Created by Daniel Khromov on 4/29/20.
//  Copyright © 2020 Daniel Khromov. All rights reserved.
//

import SwiftUI
import UserNotifications
import RealmSwift
struct AddPill: View {
    @State var pillName = ""
    
    var body: some View {
        ZStack{
        Color("Background")
            .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
              Text("Add").font(.system(.largeTitle, design: .rounded)).bold().padding()
                    Text("Pills name").bold()
                    .padding()
                TextField("Name", text: $pillName)
                    .padding()
                    .background(Color("LighterBackground").cornerRadius(20))
                    .padding()
                    Text("Notification").bold()
                        .padding()
                    TextField("Name", text: $pillName)
                        .padding()
                        .background(Color("LighterBackground").cornerRadius(20))
                        .padding()
                
                Button(action: {
                    let content = UNMutableNotificationContent()
                    content.title = "Feed the cat"
                    content.subtitle = "It looks hungry"
                    content.sound = UNNotificationSound.default

                    // show this notification five seconds from now
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                    // add our notification request
                    UNUserNotificationCenter.current().add(request)
                }, label: {Text("n").padding()})
                Spacer()
        }
        }.onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("All set!")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}


struct AddPill_Previews: PreviewProvider {
    static var previews: some View {
        AddPill()
    }
}
