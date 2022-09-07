//
//  Background.swift
//  dostavka
//
//  Created by Artem Vorobev on 07.07.2022.
//

import SwiftUI
import UIKit
import RealmSwift
import YandexMapsMobile


struct Background: View {
    

    var body: some View {
        
        ZStack{
            
         LinearGradient(
            colors: [Color.white, Color.purple],
            startPoint: .top,
            endPoint: .bottom)
         .ignoresSafeArea()
            
            GeometryReader{proxy in
                let size = proxy.size
                
                Color.white
                    .opacity(0.7)
                    .blur(radius: 200)
                    .ignoresSafeArea()
                
                Circle()
                    .fill(Color(hue: 0.754, saturation: 0.964, brightness: 0.604))
                    .padding(50.0)
                    .blur(radius: 130)
                    .offset(x: -size.width / 1.8, y: -size.height / 5)
                Circle()
                    .fill(Color(hue: 0.754, saturation: 0.964, brightness: 0.604))
                    .padding(50)
                    .blur(radius: 120)
                    .offset(x: size.width / 1.8, y: -size.height / 2)
                Circle()
                    .fill(Color(hue: 0.754, saturation: 0.964, brightness: 0.604))
                    .padding(50)
                    .blur(radius: 160)
                    .offset(x: size.width / 1.8, y: size.height / 2)
                Circle()
                    .fill(Color(hue: 0.754, saturation: 0.964, brightness: 0.604))
                    .padding(100)
                    .blur(radius: 140)
                    .offset(x: size.width / 1.8, y: size.height / 2)
                
                
            }
        }
    }
}
        
struct Background_Previews: PreviewProvider {
   
    static var previews: some View {
            Background()
        }
    }

