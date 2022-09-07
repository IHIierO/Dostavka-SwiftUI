//
//  DayWork.swift
//  dostavka
//
//  Created by Artem Vorobev on 21.06.2022.
//

import SwiftUI
import UIKit
import RealmSwift


struct DWork: View {
    
    
    @State private var hFDWIsPresented = false
    
    @ObservedResults(HotelPoint.self, where: {$0.inWork == true}) var hotelsInWork
    @ObservedResults(HotelPoint.self, where: {$0.complete == true}) var hotelsEnded
    
    @ViewBuilder var openHotelForDW: some View {
      Button(action: openHFDW) {
        Text("Добавь Отели")
              .font(.system(size: UIScreen.main.bounds.width > 400 ? 18 : 16, weight: .semibold))
              .frame(width: UIScreen.main.bounds.width > 400 ? 95 : 75, height: UIScreen.main.bounds.width > 400 ? 55 : 45)
              .background(
                  RoundedRectangle(cornerRadius: 10)
                      .stroke(
                          Color(hue: 0.754, saturation: 0.964, brightness: 0.604),
                          lineWidth: 2.5
                      )
                      .background(Color.white.opacity(0.4))
                      .padding(2))
              .cornerRadius(10)
      }
      .foregroundColor(.black)
      .sheet(isPresented: $hFDWIsPresented) {
          HotelsForDayWork(complete: $complete)
      }
    }
    
    
    @Binding var inProcces: Int
    @Binding var complete: Int
    @Binding var dWork: Bool
    
    
    var body: some View {

            HStack {
                List{
                    Section("В работе") {
                        if hotelsInWork.isEmpty{
                            Text("Выбери отели из списка")
                        }
                        ForEach(hotelsInWork){name in NameForDay(hotelPoint: name, inProcces: $inProcces, complete: $complete)
                                
                        }
                    }
                    Section("Выполнено") {
                        if hotelsEnded.isEmpty{
                            Text("Доставь завтраки")
                           
                        }
                        ForEach(hotelsEnded){name in NameForDay(hotelPoint: name, inProcces: $inProcces, complete: $complete)
                                
                        }
                    }

                }
                
                .listStyle(PlainListStyle())
                .frame(width: UIScreen.main.bounds.width > 400 ? (dWork ? 280 : 230) : (dWork ? 240 : 210), height: UIScreen.main.bounds.width > 400 ? (dWork ? 650 : 230) : (dWork ? 560 : 200))
        
                VStack {
                    Text ("\(inProcces) из \(complete)")
                        .font(.system(size: UIScreen.main.bounds.width > 400 ? 22 : 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(width: UIScreen.main.bounds.width > 400 ? 95 : 75, height: UIScreen.main.bounds.width > 400 ? 55 : 45)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    Color(hue: 0.754, saturation: 0.964, brightness: 0.604),
                                    lineWidth: 2.5
                                )
                                .background(Color.white.opacity(0.4))
                                .padding(2))
                        .cornerRadius(10)
                    
                    Spacer(minLength: 10)
                    
                    openHotelForDW
                    
                }
                .frame(width: 110, height: 170)
                .offset(x: 0, y: dWork ? -150 : 63)
        }
            
//            .padding(20)

    }

}


extension DWork{
    
    func openHFDW(){
        hFDWIsPresented.toggle()
    }
}



struct NameForDay: View {
    
    @ObservedRealmObject var hotelPoint: HotelPoint
    
    
    var buttonImage: String {
        hotelPoint.selected ? "plus.circle.fill" : "plus.circle"
    }
    @State private var showCardH = false
  
    @Binding var inProcces: Int
    @Binding var complete: Int
    
    var body: some View {
        
        HStack {
           
            Button(action: {
                toggleSelected()
                countHotels()
                
            }) {
                HStack{
                Image(systemName: buttonImage)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.green)
                Text("\(hotelPoint.nameHotel)")
                    .font(.headline)
            }
//                .disabled(hotelPoint.complete)
        }
            .buttonStyle(.plain)
            Spacer()
            HStack{
                TextField("Шт", text: $hotelPoint.count)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 40, height: 24, alignment: .leading)
                    .disabled(true)
            
            Button(action: {self.showCardH.toggle()}) {
              Image(systemName: "info.circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.blue)
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $showCardH){
                    DescripHotel(hotelPoint: hotelPoint)
                }
            }
        }
    }
}
     
extension NameForDay{
    
    func toggleSelected(){
        $hotelPoint.complete.wrappedValue.toggle()
        $hotelPoint.inWork.wrappedValue.toggle()
        $hotelPoint.selected.wrappedValue.toggle()
        $hotelPoint.isntSelected.wrappedValue.toggle()
    }
    
    func countHotels(){
        if buttonImage == "plus.circle.fill"{
            inProcces = inProcces - 1
        }
        if buttonImage == "plus.circle"{
            inProcces = inProcces + 1
        }
    }
    
}


struct DayWork_Previews: PreviewProvider {
   
    static var previews: some View {
        MainView()
            .environment(\.realmConfiguration, RealmMigrator.configuration)
        }
    }
