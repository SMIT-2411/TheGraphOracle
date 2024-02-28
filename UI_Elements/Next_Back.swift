//
//  Arrow.swift
//  TheGraphOracle
//
//  Created by Smit Patel on 21/02/24.
//

import SwiftUI

struct Next_Back: View {
    var next: Bool
    
    var body: some View {
        Circle()
            .foregroundColor(.white)
            .frame(width: 100, height: 100)
            .overlay {
                if next {
                    Image("right")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        
                } else {
                    Image("left")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
            }
    }
    
}



