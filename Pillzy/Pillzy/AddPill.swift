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

class Pill: Object {
    @objc dynamic var name = ""
    @objc dynamic var meal = ""
}

struct AddPill: View {
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    @State var added = false
    @State var pillName = ""
    @State var meal = ""
    @State private var remind = Date()
    @State var onTapBeforeMeal = false
    @State var onTapWithMeal = false
    @State var onTapAftereMeal = false
    @State var addedViaPlus = false
    let pill = Pill()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack(alignment: .leading) {
                    Text("Add").font(.system(.largeTitle, design: .rounded)).bold().padding()
                    Text("Pills name").bold()
                        .padding()
                    TextField("Name", text: $pillName)
                        .padding()
                        .background(Color("LighterBackground").cornerRadius(20))
                        .padding()
                    Text("Food & pills").bold()
                        .padding()
                    HStack{
                        food(align: "before").onTapGesture {
                            self.onTapBeforeMeal = true
                            self.onTapAftereMeal = false
                            self.onTapWithMeal = false
                            self.pill.meal = "Before"
                        }.foregroundColor(onTapBeforeMeal ? .pink : Color("LighterBackground"))
                        food(align: "with").onTapGesture {
                            self.onTapBeforeMeal = false
                            self.onTapAftereMeal = false
                            self.onTapWithMeal = true
                            self.pill.meal = "With"
                        }.foregroundColor(onTapWithMeal ? .pink : Color("LighterBackground"))
                        food(align: "after").onTapGesture {
                            self.onTapBeforeMeal = false
                            self.onTapAftereMeal = true
                            self.onTapWithMeal = false
                            self.pill.meal = "After"
                        }.foregroundColor(onTapAftereMeal ? .pink : Color("LighterBackground"))
                    }
                    HStack{
                    Text("Notification").bold()
                        .padding()
                        Button(action: {
                            if(self.pillName != "")
                            {
                            self.addedViaPlus = true
                            let content = UNMutableNotificationContent()
                                content.title = "Drink \(self.pill.name)"
                            content.subtitle = "\(self.pill.meal) meal"
                            content.sound = UNNotificationSound.default
                                let calendar = Calendar.autoupdatingCurrent
                                let trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute], from: self.remind), repeats: true)
                                print(calendar.dateComponents([.hour, .minute],from: self.remind))
                            // choose a random identifier
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            // add our notification request
                            UNUserNotificationCenter.current().add(request)
                            }
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.pink)
                                .font(.title)
                        })
                        Text("<- click to add more")
                    
                    }
                    DatePicker("", selection: $remind, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    Button(action: {
                        
                        if(self.pillName != ""){
                            do{
                                self.pill.name = self.pillName
                                try realm.write({
                                    realm.add(self.pill)
                                })
                                
                            }
                            catch{
                                print(error.localizedDescription)
                            }
                        if(self.addedViaPlus == false){
                            let content = UNMutableNotificationContent()
                            content.title = "Drink \(self.pill.name)"
                                           content.subtitle = "\(self.pill.meal) meal"
                                           content.sound = UNNotificationSound.default
                                               let calendar = Calendar.autoupdatingCurrent
                                               let trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute], from: self.remind), repeats: true)
                                               print(calendar.dateComponents([.hour, .minute],from: self.remind))
                                           // choose a random identifier
                                           let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                                           // add our notification request
                                           UNUserNotificationCenter.current().add(request)
                        }
                        }
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        Text("Save").font(.title).bold().foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.pink)
                            .background(Color(.systemPink))
                            .cornerRadius(20)
                            .padding()
                            .lightShadow()
                            .darkShadow()
                    })
                    Spacer()
                }
            }.onAppear {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        //print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
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

extension View
{
    func food(align: String) -> some View{
        
        return
            ZStack{
                RoundedRectangle(cornerRadius: 20).frame(width: 100, height: 90).padding()
                if(align == "before"){
                    HStack{
                        Image(align)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 90, height: 90)
                    }
                    
                }
                if(align == "with"){
                    HStack{
                        Image(align)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 90, height: 90)
                    }
                }
                if(align == "after"){
                    HStack{
                        Image(align)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 90, height: 90)
                    }
                }
        }
    }
}
