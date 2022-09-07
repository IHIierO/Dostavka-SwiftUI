//
//  Person.swift
//  dostavka
//
//  Created by Artem Vorobev on 21.06.2022.
//

import SwiftUI
import UIKit
import RealmSwift


struct Person: View {
    var body: some View {
        Text ("I")
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(.black)
            .frame(width: UIScreen.main.bounds.width > 400 ? 120 : 100, height: UIScreen.main.bounds.width > 400 ? 70 : 60)
            .background(Color.white.opacity(0.7))
            .clipShape(Circle())
            .offset(x: -165, y: -40)
    }
}
