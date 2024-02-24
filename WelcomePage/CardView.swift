//
//  CardView.swift
//  TheGraphOracle
//
//  Created by Smit Patel on 17/02/24.
//


import SwiftUI

struct CardView: View {
    var card : Card
    var body: some View {
        //NavigationView{
            VStack{
                
                Text(card.title)
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text(card.description)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 25))
                    .foregroundColor(.black)
                    .frame(width: 900, height: 150)
                    .padding()
                
                
            }.padding()
                .offset(x: 0, y: 410)
       // }
    }
}

#Preview {
    CardView(card: testData[0]).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}

