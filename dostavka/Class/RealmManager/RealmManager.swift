//
//  RealmManager.swift
//  dostavka
//
//  Created by   macbookair132013 on 15.06.2022.
//

import RealmSwift




class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveHotelPoint(model: HotelPoint) {
        
        try! localRealm.write {
            localRealm.add(model)
        }
    }
}



