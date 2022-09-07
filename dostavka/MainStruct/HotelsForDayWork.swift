//
//  HotelsForDayWork.swift
//  dostavka
//
//  Created by Artem Vorobev on 13.07.2022.
//

import SwiftUI
import UIKit
import RealmSwift




struct HotelsForDayWork: View {
    
    //    @State private var hFDWIsPresented = false
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedResults(HotelPoint.self, where: {$0.selected == true}) var hotelsIsSelected
    @ObservedResults(HotelPoint.self, where: {$0.isntSelected == true}) var hotelsIsntSelected
    
    
    @Binding var complete: Int
    
    var body: some View {
        
        
        ZStack {
            Background()
            
            Rectangle()
                .frame(width: 40, height: 3, alignment: .center)
                .cornerRadius(3)
                .opacity(0.3)
                .offset(x: 0, y: UIScreen.main.bounds.width > 400 ? -390: -300)
            NavigationView {
                List {
                    Section("В работе") {
                        if hotelsIsSelected.isEmpty{
                            Text("Добавь отели")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        ForEach(hotelsIsSelected){name in HotelsForDayWorkRow(hotelPoint: name,complete: $complete)
                        }
                    }
                    Section("Список Отелей") {
                        ForEach(hotelsIsntSelected){name in HotelsForDayWorkRow(hotelPoint: name,complete: $complete)
                        }
                    }
                }
                .foregroundColor(Color.black)
                .navigationBarItems(leading: EditButton(), trailing: Button("Начать")
                                    {
                    presentationMode.wrappedValue.dismiss()
                }
                    .foregroundColor(Color.black))
                .navigationBarTitleDisplayMode(.inline)
                
            }
            .offset(y: 20)
            .blendMode(.darken)
            .background(Color.white.opacity(0.5))
        }
        
    }
}




struct HotelsForDayWorkRow: View {
    
    @ObservedRealmObject var hotelPoint: HotelPoint
    
    var buttonImage: String {
        hotelPoint.selected ? "plus.circle.fill" : "plus.circle"
    }
    @State private var showCardH = false
  
   
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
            }
            Spacer()
            HStack{
                TextField("Шт", text: $hotelPoint.count)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 40, height: 24, alignment: .leading)
                
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
     
extension HotelsForDayWorkRow{
    
    func toggleSelected(){
        $hotelPoint.isntSelected.wrappedValue.toggle()
        $hotelPoint.selected.wrappedValue.toggle()
        $hotelPoint.inWork.wrappedValue.toggle()
    }
    
    func countHotels(){
        if buttonImage == "plus.circle.fill"{
            complete = complete + 1
            
        }else{
            complete = complete - 1
            
        }
    }
}


struct HotelsForDayWorkRow_Previews: PreviewProvider {
   
    static var previews: some View {
        MainView()
            .environment(\.realmConfiguration, RealmMigrator.configuration)
        }
    }

