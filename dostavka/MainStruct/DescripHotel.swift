//
//  DescripHotel.swift
//  dostavka
//
//  Created by Artem Vorobev on 21.06.2022.
//

import SwiftUI
import UIKit
import RealmSwift
import Foundation


struct DescripHotel: View {

    @Environment(\.dismiss) var dismiss
    @Environment(\.realm) var localRealm
    
    @State var showAlert = false
    
    @ObservedRealmObject var hotelPoint: HotelPoint

    var isUpdating: Bool {
      hotelPoint.realm != nil
    }

    var body: some View {
  
        ZStack{
            Background()
            Rectangle()
                .frame(width: 40, height: 3, alignment: .center)
                .cornerRadius(3)
                .opacity(0.3)
                .offset(x: 0, y: UIScreen.main.bounds.width > 400 ? -390: -300)
       
            NavigationView {
                List {
                    HStack {
                        Text ("""
                      Название
                      Отеля
                      """)
                        .bold()
                        .frame(width: 85, height: 60, alignment: .leading)
                        
                        TextField("", text: $hotelPoint.nameHotel)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black.opacity(0.2)))
                    }
                    HStack {
                        Text ("""
                      Адрес
                      Отеля
                      """)
                        .bold()
                        .frame(width: 85, height: 60, alignment: .leading)
                        
                        TextEditor(text: $hotelPoint.adresHotel)
                            .padding(4)
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary).opacity(0.5))
                    }
                    .padding(.vertical,10)
                    
                    HStack {
                        Text ("""
                      Описание
                      Отеля
                      """)
                        .bold()
                        .frame(width: 85, height: 60, alignment: .leading)
                        
                        TextEditor(text: $hotelPoint.descriptionHotel)
                            .padding(4)
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary).opacity(0.5))
                        
                    }
                    .padding(.vertical,10)
                    
                    HStack {
                        Text ("""
                      Код
                      Арки
                      """)
                        .bold()
                        .frame(width: 85, height: 60, alignment: .leading)
                        
                        TextField("", text: $hotelPoint.codeArky)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black.opacity(0.2)))
                    }
                    
                    HStack {
                        Text ("""
                      Код
                      Парадной
                      """)
                        .bold()
                        .frame(width: 85, height: 60, alignment: .leading)
                        
                        TextField("", text: $hotelPoint.codeParadny)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black.opacity(0.2)))
                    }
                    
                    HStack {
                        Text ("""
                      Код
                      Локера
                      """)
                        .bold()
                        .frame(width: 85, height: 60, alignment: .leading)
                        
                        TextField("", text: $hotelPoint.locker)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black.opacity(0.2)))
                    }
                    
                }
                
                
            .navigationBarTitle("Карточка Отеля")
            .navigationBarItems(trailing: Button(isUpdating ? "Изменить" : "Сохранить") {
                
                if isUpdating {
                dismiss()
              } else {
                try? localRealm.write {
                    localRealm.add(hotelPoint)
                }
                dismiss()
              }
                
                self.showAlert = true
                
                
            }
                .disabled(hotelPoint.nameHotel.isEmpty)
                .alert(isPresented: $showAlert){
                Alert(title: Text("Сохранено"),  dismissButton: .default(Text("OK")))
            }
             )
            .navigationBarTitleDisplayMode(.inline)
                
            }
            .blendMode(.darken)
            .cornerRadius(20)
            .offset(y: 30)
            .background(Color.white.opacity(0.5))
        }
        
    }
    
}

struct DescripHotel_Previews: PreviewProvider {
   
    static var previews: some View {
        DescripHotel(hotelPoint: HotelPoint())
                .environment(\.realmConfiguration, RealmMigrator.configuration)
        }
    }

