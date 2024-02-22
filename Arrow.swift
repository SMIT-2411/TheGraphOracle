//
//  Arrow.swift
//  TheGraphOracle
//
//  Created by Smit Patel on 21/02/24.
//

import SwiftUI

struct Arrow: View {
    var next: Bool
    
    var body: some View {
        Circle()
            .foregroundColor(.white)
            .frame(width: 40, height: 40)
            .overlay {
                if next {
                    Image(systemName: "chevron.right")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        
                } else {
                    Image(systemName: "chevron.left")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
            }
    }
}

