//
//  HotelPoint.swift
//  dostavka
//
//  Created by   macbookair132013 on 15.06.2022.
//

import SwiftUI
import RealmSwift



class HotelPoint: Object, ObjectKeyIdentifiable {

    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var nameHotel: String = ""
    @Persisted var adresHotel: String = ""
    @Persisted var descriptionHotel: String = ""
    @Persisted var codeArky: String = ""
    @Persisted var codeParadny: String = ""
    @Persisted var locker: String = ""
    @Persisted var selected = false
    @Persisted var isntSelected = true
    @Persisted var inWork = false
    @Persisted var complete = false
    @Persisted var count: String = ""
    
}





