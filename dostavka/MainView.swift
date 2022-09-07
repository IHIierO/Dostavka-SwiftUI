//
//  ContentView.swift
//  dostavka
//
//  Created by   macbookair132013 on 06.06.2022.
//

import SwiftUI
import UIKit
import RealmSwift
import YandexMapsMobile



//MARK: - Start coding
struct MainView: View {
    
    init() {
//        UINavigationBar.appearance().backgroundColor = .white
//        UIScrollView.appearance().backgroundColor = .white
//
////        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
////        UINavigationBar.appearance().shadowImage = UIImage()
//        UITableView.appearance().backgroundColor = .white
//        UITableViewCell.appearance().backgroundColor = .white
        
       }
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    
    @ObservedResults(HotelPoint.self) var hotelPoint
    @ObservedRealmObject var hotelPointComplete = HotelPoint()
    

    @State var searchText = ""

    @State var showCard = false
    @State var changeHotelDesc = false
    @State var showAllHotels = false
    @State var back = CGSize.zero
    
    @State var dayWork = false
    @State var dWButtonName = ["Посмотреть", "Назад"]
    
    @State var inProcces = 0
    @State var complete = 0

//    let localRealm = try! Realm()
    @Environment(\.realm) var localRealm
    
    let layout = [
    GridItem(.flexible(minimum: 100)),
    GridItem(.flexible(minimum: 100))
    ]

    var body: some View {
        ZStack {
            
            //MARK: - Background
            Background()
                .onTapGesture{
                    if dayWork == true {
                        dayWork = false
                    }
                }
            ZStack {
                
                //MARK: - Person
                Person()
                    .offset(x: UIScreen.main.bounds.width > 400 ? 0 : 20, y: UIScreen.main.bounds.width > 400 ? -350 : -260)
                    .blur(radius: dayWork ? 20 : 0)
                
                VStack {
                    VStack {
                        ZStack {
                            
                            //MARK: - Background for Hotels
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.clear)
                                .frame(width: UIScreen.main.bounds.width > 400 ? 340 : 320, height: UIScreen.main.bounds.width > 400 ? 165 : 150)
                                .background(Color.white.opacity(0.4))
                                .cornerRadius(20)
                            
                            
                            //MARK: - Hotels
                            NavigationView{
                                ScrollView {
                                    LazyVGrid(columns: layout, content: {
                                        ForEach(hotelPoint)
                                        { hotelsNamed in HotelsButton( hotelPoint: hotelsNamed)
                                        }
                                    })
                                    .padding()
                                    
                                    
                                } //end ScrolView for Hotels
                                
                                
                                .frame(width: UIScreen.main.bounds.width > 400 ? 340 : 320, height: UIScreen.main.bounds.width > 400 ? 165 : 150)
                                .navigationBarTitle("Отели")
                                .navigationBarItems(leading: Button("Добавить")
                                                    {
                                    self.changeHotelDesc.toggle()
                                }
                                                    
                                    .sheet(isPresented: $changeHotelDesc)
                                                    {DescripHotel(hotelPoint: HotelPoint())}
                                    .foregroundColor(Color.black))
                                .navigationBarItems(trailing: Button("Развернуть")
                                                    {
                                    self.showAllHotels.toggle()
                                }
                                    .sheet(isPresented: $showAllHotels){
                                        Hotels()
                                        
                                    }
                                                    
                                    .foregroundColor(Color.black))
                                .navigationBarTitleDisplayMode(.inline)
                                
                                
                            } //end NavigationView for Hotels
                            .frame(width: UIScreen.main.bounds.width > 400 ? 340 : 320, height: UIScreen.main.bounds.width > 400 ? 165 : 150)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.6), radius: 15, x: 0, y: 0)
                            .blendMode(.darken)
                            
                        } //end ZStack for Hotels
                        
                        //MARK: - Map
                        Map()
                            .frame(width: UIScreen.main.bounds.width > 400 ? 340 : 320, height: UIScreen.main.bounds.width > 400 ? 340 : 220)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.6), radius: 15, x: 0, y: 10)
                        
                    } //end VStack for Hotels and Map
                    .blur(radius: dayWork ? 20 : 0)
                    .offset(x: 0, y: UIScreen.main.bounds.width > 400 ? 180 : 15)
                    
                    ZStack {
                        //MARK: - Background for DWork
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.clear)
                            .frame(width: UIScreen.main.bounds.width > 400 ? (dayWork ? 407 : 347) : (dayWork ? 357 : 327), height: UIScreen.main.bounds.width > 400 ? (dayWork ? 647 : 227) : (dayWork ? 547 : 177), alignment: .center)
                            .background(Color.white.opacity(0.4))
                            .cornerRadius(20)
                            .offset(x: 0, y: UIScreen.main.bounds.width > 400 ? (dayWork ? -50 : -280) : (dayWork ? -140 : -260))
                            .animation(Animation.easeInOut(duration: 0.3), value: dayWork)
                        
                        //MARK: - DWork
                        NavigationView {
                            DWork(inProcces: $inProcces, complete: $complete, dWork: $dayWork)
                                .frame(width: UIScreen.main.bounds.width > 400 ? (dayWork ? 407 : 347) : (dayWork ? 357 : 327), height: UIScreen.main.bounds.width > 400 ? (dayWork ? 647 : 227) : (dayWork ? 547 : 177), alignment: .center)
                                .cornerRadius(20)
                            
                                .navigationBarTitle("Маршрут")
                                .navigationBarItems(trailing: Button("\(dayWork ? dWButtonName[1] : dWButtonName[0])") {
                                    self.dayWork.toggle()
                                }
                                    .foregroundColor(Color.black))
                                .navigationBarItems(leading: Button("Выполнено") {
                                    inProcces = 0
                                    complete = 0
                                    
                                    let realm = try! Realm()
                                    let hotelsComplete = realm.objects(HotelPoint.self).where{$0.complete == true}
                                    let hotelsCount = realm.objects(HotelPoint.self)
                                    let hotelsInWork = realm.objects(HotelPoint.self).where{$0.inWork == true}
                                    
                                    let hotelsIsSelected = realm.objects(HotelPoint.self).where{$0.selected == true}
                                    let hotelsIsntSelected = realm.objects(HotelPoint.self).where{$0.isntSelected == false}
                                    
                                    try! realm.write {
                                        hotelsComplete.setValue(false, forKey: "complete")
                                        hotelsCount.setValue("", forKey: "count")
                                        hotelsInWork.setValue(false, forKey: "inWork")
                                        hotelsIsSelected.setValue(false, forKey: "selected")
                                        hotelsIsntSelected.setValue(true, forKey: "isntSelected")
                                    }
                                    self.dayWork = false
                                }
                                    .foregroundColor(Color.black))
                                .navigationBarTitleDisplayMode(.inline)
                            
                        }// end NavigationView for DWork
                        .frame(width: UIScreen.main.bounds.width > 400 ? (dayWork ? 407 : 347) : (dayWork ? 357 : 327), height: UIScreen.main.bounds.width > 400 ? (dayWork ? 647 : 227) : (dayWork ? 547 : 177), alignment: .center)
                        .cornerRadius(20)
                        .offset(x: 0, y: UIScreen.main.bounds.width > 400 ? (dayWork ? -50 : -280) : (dayWork ? -140 : -260))
                        .animation(Animation.easeInOut(duration: 0.3), value: dayWork)
                        .shadow(color: .black.opacity(0.6), radius: 15, x: 0, y: -10)
                        .blendMode(.darken)
                        
                    } //end ZStack for DWork
                    .offset(x: 0, y: -295)
                    
                    
                    
                    
                    
                } //end VStack
                
                .offset(x: 0, y: UIScreen.main.bounds.width > 400 ? 80 : 200)
            } //end second ZStack
            .blur(radius: showCard ? 20 : 0)
            
            
            //            Text ("\(back.height)").offset(y: -300)
            
        } //end ferst ZStack
        .ignoresSafeArea(.keyboard, edges: .all)
        
    } //end body
  
}
//end MainView






struct MainView_Previews: PreviewProvider {
   
    static var previews: some View {
        MainView()
            .environment(\.realmConfiguration, RealmMigrator.configuration)
            .previewInterfaceOrientation(.portrait)
        }
    }



