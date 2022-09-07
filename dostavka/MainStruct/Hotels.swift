//
//  DescripHotel.swift
//  dostavka
//
//  Created by Artem Vorobev on 20.06.2022.
//

import SwiftUI
import UIKit
import RealmSwift


struct Hotels: View {
    
    
//    var searchResults: [String] {
//            if searchText.isEmpty {
//                return hotelPoint
//            } else {
//                return hotelsNamed.filter { $0.contains(searchText) }
//            }
//        }
    
    @ObservedResults(HotelPoint.self) var hotelPoint

    @State private var searchText:String = ""
    
    
    let layout = [
    GridItem(.flexible(minimum: 100)),
    GridItem(.flexible(minimum: 100))
    ]
    
    var body: some View{
        ZStack {
            Background()
            
            Rectangle()
                .frame(width: 40, height: 3, alignment: .center)
                .cornerRadius(3)
                .opacity(0.3)
                .offset(x: 0, y: UIScreen.main.bounds.width > 400 ? -390: -300)
            VStack{
                HStack(spacing: 15){
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.gray)
                    TextField("Поиск", text: $searchText)
                }
                .padding(.vertical,7)
                .padding(.horizontal)
                .background(Color.primary.opacity(0.05))
                .cornerRadius(8)
                .padding(.horizontal,40)
                
                ScrollView {
                    LazyVGrid(columns: layout, content: {
                        ForEach(hotelPoint )
                        { hotelsNamed in HotelsButton( hotelPoint: hotelsNamed)
                        }
                        
                    })
                    .searchable(text: $searchText, collection: $hotelPoint, keyPath: \.nameHotel){
                        ForEach(hotelPoint){hotelsNamedFiltering in
                            Text(hotelsNamedFiltering.nameHotel).searchCompletion(hotelsNamedFiltering.nameHotel)
                        }
                    }
                    
                    .padding()
                    .frame(width: UIScreen.main.bounds.width > 400 ? 350 : 320)
                    //         .background(.clear)
                    
                }
                .blendMode(.darken)
                
            }
            .offset(x: 0, y: 40)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.opacity(0.5))
        }
    }
}



struct HotelsButton: View {
    
    @ObservedRealmObject var hotelPoint: HotelPoint
    
    @State private var showCardH = false
    

    let localRealm = try! Realm()
  

    var body: some View {
        
        VStack {
            Button (action: {
                self.showCardH.toggle()
                
            }) {
                Text (hotelPoint.nameHotel)
                    .font(.system(size: UIScreen.main.bounds.width > 400 ? 21 : 18, weight: .semibold))
                //                        .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width > 400 ? 140 : 130, height:UIScreen.main.bounds.width > 400 ? 55 : 50)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                Color(hue: 0.754, saturation: 0.964, brightness: 0.604),
                                lineWidth: 2.5
                            )
                            .background(Color.white.opacity(0.35))
                            .padding(2)
                    )
                    .cornerRadius(10)
                
            }
            .contextMenu{
                Button {
                    
                    let realm = try! Realm()
                    try! realm.write {
                        let hotelsForDelete = realm.objects(HotelPoint.self).where {
                            $0.nameHotel == "\(hotelPoint.nameHotel)"
                        }
                        realm.delete(hotelsForDelete)
                    }
                } label: {
                    Label("Удалить", systemImage: "trash")
                }
            }
            .sheet(isPresented: $showCardH){
                DescripHotel(hotelPoint: hotelPoint)}
        }
        
    }
   
}




struct Hotels_Previews: PreviewProvider {
   
    static var previews: some View {
        Hotels()
            .environment(\.realmConfiguration, RealmMigrator.configuration)
        }
    }
