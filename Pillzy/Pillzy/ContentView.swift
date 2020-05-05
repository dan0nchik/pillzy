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
    @State var showAddMed = false
    @State public var isPressed: Bool = false
    @State private var navigateToSettings = false
    @State private var deleted = false
    @State private var taken = false
    @State public var progress: Float = 0.0
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    var body: some View {
        
        ZStack{
            Color("Background")
            VStack{
                HStack {
                    VStack(alignment: .leading){
                        Text("Pillzy").font(.system(.largeTitle, design: .rounded)).bold().padding(.top,60)
                            .padding(.leading)
                        Text("Stay healthier").font(.system(.largeTitle, design: .rounded)).foregroundColor(.black).opacity(0.5).padding()
                    }
                    Spacer()
                    
//                    ProgressBar(progress: self.$progress)
//                    .frame(width: 100, height: 100)
//                    .padding(40)
                    
                }
                ScrollView{
                    ForEach(res, id: \.self){ i in
                        self.card(with: i.name, time: "", tap: self.isPressed, index: i)
                            .onTapGesture {
                                self.isPressed.toggle()
                        }
                        
                        .padding(20)
                    }
                }
                Spacer()
            }
            
            VStack{
                Spacer()
                Button(action: {
                    self.showAddMed.toggle()
                    self.isPressed.toggle()
                }) {
                    Text("+")
                        .foregroundColor(.pink)
                        .font(.largeTitle)
                        .padding(35)
                }.sheet(isPresented: $showAddMed, content: {AddPill()})
                    .background(Color("Background"))
                    .mask(Circle())
                    .lightShadow()
                    .darkShadow()
                    .padding()
            }
        }.edgesIgnoringSafeArea(.all)
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
    
    func card(with medName: String, time: String, tap: Bool, index: Pill) -> some View{
        
        return ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("Background"))
                .frame(width: 340, height: tap ? 200 : 120)
                .lightShadow()
                .darkShadow()
            
            VStack{
                HStack{
                    Image("pill2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding([.leading], 50)
                    
                        Text(medName)
                            .font(.system(.largeTitle, design: .rounded)).bold().opacity(0.6)
                            .padding()
                    
                    Image(systemName: index.taken ? "checkmark.circle.fill" : "").foregroundColor(.green).font(.title)
                    
                    Spacer()
                }.padding(.top, 20)
                
                if tap
                {
                HStack{
                    Button(action: {
                        do{
                            try realm.write({
                                realm.delete(index)
                            })
                        }
                        catch{
                            print(error.localizedDescription)
                        }
                    }, label: {
                        Text("Delete")
                        .padding(10)
                        .foregroundColor(.pink)
                            .frame(width: 100, height: 30)
                        .background(Color("Background"))
                        .cornerRadius(5)
                        .padding()
                        .lightShadow()
                        .darkShadow()
                    })
                    Button(action: {
                        do{
                            try
                            realm.write({
                                index.taken = true
                            })
                        }
                        catch{
                        print(error.localizedDescription)
                        }
                    }, label: {
                        Text("Take")
                        .padding(10)
                        .foregroundColor(.green)
                            .frame(width: 100, height: 30)
                        .background(Color("Background"))
                        .cornerRadius(5)
                        .padding()
                        .lightShadow()
                        .darkShadow()
                    })
                    }.padding(20)
                }
                Spacer()
            }
        }
    }
}

struct ProgressBar: View {
    @Binding var progress: Float
    @State var took = 0
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 15.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
            Circle()
                .trim(from: 0.0, to: CGFloat(self.progress))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270))
                .animation(.linear)
            Text("Taken").bold()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

