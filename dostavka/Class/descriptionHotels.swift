//
//  descriptionHotels.swift
//  dostavka
//
//  Created by Artem Vorobev on 23.06.2022.
//

import SwiftUI
import UIKit
import RealmSwift


class DescriptionHotels{
    
    @Binding var nameHotel: String
    @Binding var adresHotel: String
    @Binding var descriptionHotel: String
    @Binding var codeArky: String
    @Binding var codeParadny: String
    @Binding var locker: String
    

    
    let localRealm = try! Realm()
    @State var hotelDesc: Results<HotelPoint>!
    
    func showDescriptionGraf() {
       
        hotelDesc = localRealm.objects(HotelPoint.self)
        
        let modelGraf = hotelDesc[0]
        
        nameHotel = "\(modelGraf.nameHotel)"
        adresHotel = "\(modelGraf.adresHotel)"
        descriptionHotel = "\(modelGraf.descriptionHotel)"
        codeArky = "\(modelGraf.codeArky)"
        codeParadny = "\(modelGraf.codeParadny)"
        locker = "\(modelGraf.locker)"
    }
    
    func showDescriptionAntares() {
       
        hotelDesc = localRealm.objects(HotelPoint.self)
        
        let modelAntares = hotelDesc[1]
        
        nameHotel = "\(modelAntares.nameHotel)"
        adresHotel = "\(modelAntares.adresHotel)"
        descriptionHotel = "\(modelAntares.descriptionHotel)"
        codeArky = "\(modelAntares.codeArky)"
        codeParadny = "\(modelAntares.codeParadny)"
        locker = "\(modelAntares.locker)"
    }
    
    init(nameHotel: Binding <String>, adresHotel: Binding <String>, descriptionHotel: Binding <String>, codeArky: Binding <String>, codeParadny: Binding <String>, locker: Binding <String>) {
       
        self._nameHotel = nameHotel
        self._adresHotel = adresHotel
        self._descriptionHotel = descriptionHotel
        self._codeArky = codeArky
        self._codeParadny = codeParadny
        self._locker = locker
        
    }
    
}
